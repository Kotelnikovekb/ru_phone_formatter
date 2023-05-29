import 'package:arbo_last/src/core/constants/project_routes.dart';
import 'package:arbo_last/src/core/widgets/app_button.dart';
import 'package:arbo_last/src/core/widgets/app_input.dart';
import 'package:arbo_last/src/core/widgets/app_selector.dart';
import 'package:arbo_last/src/core/x_controller/user_x_controller.dart';
import 'package:arbo_last/src/features/company/data/company_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:ru_phone_formatter/ru_phone_formatter.dart';

import '../../../../core/utils.dart';

class AddCompany extends StatefulWidget {
  const AddCompany({Key? key}) : super(key: key);

  @override
  State<AddCompany> createState() => _AddCompanyState();
}

class _AddCompanyState extends State<AddCompany> {
  LatLng companyLatLong=const LatLng(56.887188694231625,60.63237067723744);
  final userXController=Get.find<UserXController>();
  final companyApi=CompanyApi();
  final mapController=TextEditingController();
  final emailController=TextEditingController();
  final companyNameController=TextEditingController();
  final customerController=TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final maskFormatter =  RuPhoneInputFormatter();
  String type='';
  final _btnController = RoundedLoadingButtonController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Новая компания'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            AppInput(
              label: Text('Название'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Укажите название компании';
                }
                return null;
              },
              textInputAction: TextInputAction.next,
              controller: companyNameController,
            ),
            AppInput(
              label: Text('ФИО'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Укажите имя клиента';
                }
                return null;
              },
              textInputAction: TextInputAction.next,
              controller: customerController,
            ),

            AppInput(
              label: const Text('Email'),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
            ),
            AppInput(
              label: Text('Телефон'),
              inputFormatters:[maskFormatter],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Укажите телефон';
                }
                return null;
              },
              keyboardType: const TextInputType.numberWithOptions(signed: true,decimal: true),
              textInputAction: TextInputAction.next,
            ),
            AppInput(
              controller: mapController,
              label: Text('Адрес'),
              suffixIcon: IconButton(
                icon: Icon(Icons.location_on),
                onPressed: ()async{
                  final res=await Get.toNamed(ProjectRoutes.MAP_SELECT);
                  if(res!=null){
                    final d=res as (String name,LatLng latLng);
                    mapController.text=d.$1;
                    companyLatLong=d.$2;
                  }
                },
              ),
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Укажите адрес';
                }
                return null;
              },
            ),
            AppSelector(
                title: 'Направление',
                onSelectionDone: (value){
                  type=value;
                },
                items: [
                  'Спил Деревьев',
                  'Дробление пней',
                  'Смешенные работы',
                  'Посадка и ландшафт',
                  'Уборка крыш от снега',
                  'Обработка участков'
                ]
            ),
            RoundedLoadingButton(
              child: Text('Создать', style: TextStyle(color: Colors.white)),
              controller: _btnController,
              onPressed: create,
            )
          ],
        ),
      ),
    );
  }

  void create()async{
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Заполните поля')),
      );
      Utils.buttonAction(_btnController,success: false);
      return;
    }
    if(type.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Укажите тип')),
      );
      Utils.buttonAction(_btnController,success: false);

      return;
    }
    try{
      final res = await companyApi.createCompany(
          user: userXController.name(),
          latLng: companyLatLong,
          name: customerController.text,
          address: mapController.text,
          phone: maskFormatter.getClearPhone(),
          companyName: companyNameController.text,
          email: emailController.text,
          type: type
      );
      Utils.buttonAction(_btnController,success: true);
      Get.back(result: res);
    }catch(e){
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка создания $e')),
      );
      Utils.buttonAction(_btnController,success: false);
    }
  }
}
