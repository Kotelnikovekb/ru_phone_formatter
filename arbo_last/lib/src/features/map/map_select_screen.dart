import 'dart:async';

import 'package:arbo_last/src/core/data/data/share_api.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../core/utils.dart';


class MapSelectScreen extends StatefulWidget {
  const MapSelectScreen({Key? key}) : super(key: key);

  @override
  _MapSelectScreenState createState() => _MapSelectScreenState();
}

class _MapSelectScreenState extends State<MapSelectScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  String showAddress='Поиск адреса';
  final _sharedApi=SharedApi();


  (String name,LatLng latLng) address=('',const LatLng(56.887188694231625,60.63237067723744));

  CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(56.887188694231625, 60.63237067723744),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();
    findMy();
  }

  void findMy()async{
    try{
      Position position=await Utils.determinePosition();

      setState(() {
        _kGooglePlex = CameraPosition(
          target: LatLng(position.latitude,position.longitude),
          zoom: 14.4746,
        );
        address=('',LatLng(position.latitude,position.longitude));
        geocode(LatLng(position.latitude,position.longitude));
      });
    }catch(e){
      print('Ошибка $e');
    }
  }

  void geocode(LatLng latLng)async{
    setState(() {
      showAddress='поиск';
    });
    try{
      final addressData=await _sharedApi.geocoder(latLng);
      if(addressData.isNotEmpty){
        address=(addressData.first.value,latLng);
        setState(() {
          showAddress=addressData.first.value;
        });
      }else{
        setState(() {
          showAddress='Адрес не определен';
        });
        address=('Адрес не определен',latLng);

      }
    }catch(e){
      setState(() {
        showAddress='Ошибка $e';
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.hybrid,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            onCameraIdle: (){
            },
            onCameraMove: (position){
              geocode(position.target);
            },


          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(12))
                ),
                height: 150,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(vertical: 48,horizontal: 48),
                child: Column(
                  children: [
                    Container(
                      child: Text(showAddress,textAlign: TextAlign.center,style: TextStyle(fontSize: 18),),
                      margin: EdgeInsets.only(top: 24,left: 24,right: 24),
                      alignment: Alignment.center,
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Expanded(
                            child: TextButton(
                              child: const Text('Назад',style: TextStyle(color: Colors.red),),
                              onPressed: ()=>Get.back(),
                            )
                        ),
                        Expanded(
                            child: TextButton(
                                onPressed: (){
                                  Get.back(result: address);
                                },
                                child: Text('Выбрать')
                            )
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          const Align(
            alignment: Alignment.center,
            child: Icon(Icons.location_on,size: 60,color: Colors.redAccent,),
          )

        ],
      ),
    );
  }

}