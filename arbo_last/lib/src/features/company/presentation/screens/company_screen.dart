import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';

import '../../../../core/constants/project_routes.dart';
import '../../../../core/utils.dart';
import '../../domain/company_model.dart';
import '../x_controllers/company_x_controller.dart';

class CompanyScreen extends GetView<CompanyXController> {
  const CompanyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('ru_RU', null);

    return controller.obx(
            (state) => DefaultTabController(
                length: 2,
                child: Scaffold(
                  appBar: AppBar(
                    title: Text('Компания ${state?.name}'),
                    bottom: TabBar(
                      tabs: [
                        Tab(child: Text('Инфо'),),
                        Tab(child: Text('Работы'),),
                      ],
                    ),
                  ),
                  body: TabBarView(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              ListTile(
                                title: Text('Адрес'),
                                subtitle: Text(state?.address??'НД'),
                              ),
                              ListTile(
                                title: Text('Телефон'),
                                subtitle: Text(state?.phone??'НД'),
                              ),
                              ListTile(
                                title: Text('Клиент'),
                                subtitle: Text(state?.fio??'НД'),
                              ),
                              ListTile(
                                title: Text('Email'),
                                subtitle: Text(state?.email??'НД'),
                              ),
                              ListTile(
                                title: Text('Категория'),
                                subtitle: Text(state?.category??'НД'),
                              ),
                              /*SizedBox(
                                height: Get.width,
                                child: GoogleMap(
                                  initialCameraPosition: CameraPosition(
                                    target: LatLng(
                                        Utils.doubleParser(state?.v1,defaultValue: 56.887188694231625),
                                        Utils.doubleParser(state?.v2,defaultValue: 60.63237067723744)
                                    ),
                                    zoom: 16,
                                  ),
                                  markers: {
                                    Marker(
                                      markerId: MarkerId("${state?.name}"),
                                      position: LatLng(
                                          Utils.doubleParser(state?.v1,defaultValue: 56.887188694231625),
                                          Utils.doubleParser(state?.v2,defaultValue: 60.63237067723744)
                                      ),
                                    ),
                                  },
                                ),
                              )*/
                            ],
                          ),
                        ),
                      ),
                      Container(
                        child: (state!.works.isNotEmpty)?
                        StickyGroupedListView<Work, DateTime>(
                          elements: state?.works??[],
                          groupBy: (Work element) =>  DateTime(
                              element.datecreate.year,
                              element.datecreate.month,
                              element.datecreate.day
                          ),
                          groupSeparatorBuilder: (Work element) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 6),
                            child: Text(
                              DateFormat('dd LLL','ru_RU').format(element.datecreate),
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          itemBuilder: (context, Work element) => ListTile(
                            title: Text('${element.category} - ${element.name}'),
                            subtitle: Text(DateFormat('dd LLLL HH:mm','ru_RU').format(element.datecreate)
                            ),
                            trailing: Text('${Utils.formatAmount(element.trueCost)} ₽',
                              style: TextStyle(
                                  color: (Utils.doubleParser(element.trueCost) > 0) ? Colors.green : Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18),
                            ),
                            /*leading: CircleAvatar(
                        backgroundColor: Utils.fromHex(element.category.color),
                        child: Icon(Utils.fromIcon(element.category.icon)),
                      ),*/
                            onTap: (){

                            },
                          ),
                          itemComparator: (item1, item2) => item1.datecreate.compareTo(item2.datecreate),
                          elementIdentifier: (element) => element.name ,
                          order: StickyGroupedListOrder.DESC,
                        )
                        :
                        Center(
                          child: Text('Добавте работы'),
                        ),
                      ),
                    ],
                  ),
                  floatingActionButton: FloatingActionButton(
                    onPressed: () async{
                      final res=await Get.toNamed(ProjectRoutes.NEW_WORK,arguments: {
                        'id':controller.companyId
                      });
                      if(res!=null){
                        controller.addWork(res);
                      }
                    },

                  ),
                )
            ),
      onLoading: Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      )
    );
  }
}
