import 'package:arbo_last/src/core/widgets/app_input.dart';
import 'package:arbo_last/src/core/widgets/app_selector.dart';
import 'package:arbo_last/src/core/x_controller/app_x_controller.dart';
import 'package:arbo_last/src/core/x_controller/user_x_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../../core/utils.dart';
import '../../../../core/widgets/type_select_button.dart';
import '../../data/consumption_api.dart';

class AddOperationScreen extends StatefulWidget {
  const AddOperationScreen({Key? key}) : super(key: key);

  @override
  State<AddOperationScreen> createState() => _AddOperationScreenState();
}

class _AddOperationScreenState extends State<AddOperationScreen> {
  int selectType=0;
  List<String> category=[];
  List<String> subCategory=[];
  final appXController=Get.find<AppXController>();
  final userXController=Get.find<UserXController>();
  String selectCategory='';
  String selectSubCategory='';
  final _btnController = RoundedLoadingButtonController();
  final costController=TextEditingController();
  final commentController=TextEditingController();
  final _api=ConsumptionApi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Добавить операцию'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 24,horizontal: 24),
        child: Form(
          child: Column(
            children: [
              TypeSelectButton(
                onSelect: changeType
              ),
              const SizedBox(height: 6,),
              AppSelector(
                  title: 'Категория',
                  onSelectionDone: changeCategory,
                  items:category,

              ),
              const SizedBox(height: 6,),
              if(selectCategory.isNotEmpty)
                AppSelector(
                  title: 'Под. категория',
                  onSelectionDone: (cate){
                    selectSubCategory=cate;
                  },
                  items:subCategory,

                ),
              const SizedBox(height: 6,),
              AppInput(
                label: Text('Комментарий'),
                textInputAction: TextInputAction.next,
                controller: commentController,
              ),
              const SizedBox(height: 6,),
              AppInput(
                label: Text('Сумма'),
                  textInputAction: TextInputAction.send,
                keyboardType: TextInputType.number,
                controller: costController,
              ),
              const SizedBox(height: 6,),
              RoundedLoadingButton(
                child: Text('Добавить', style: TextStyle(color: Colors.white)),
                controller: _btnController,
                width: Get.width,
                onPressed: create,
              )
            ],
          ),
        ),
      ),
    );
  }
  void changeType(int type){
    selectType=type;
    category.clear();
    selectSubCategory='';
    appXController.categories.forEach((element) {
      if(element.type==((type==0)?'1':'2')&&category.where((element1) => element1==element.header).isEmpty){
        category.add(element.header);
      }
    });
    setState(() {

    });
  }
  void changeCategory(dynamic category){
    subCategory.clear();
    selectSubCategory='';
    selectCategory=category.toString();
    appXController.categories.forEach((element) {
      if(element.type==((selectType==0)?'1':'2')&&element.header==category){
        subCategory.add(element.name);
      }
    });
    setState(() {

    });
  }
  @override
  void initState() {
    super.initState();
    changeType(0);
  }
  void create() async{
    if(selectCategory.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Укажите Категорию')),
      );
      Utils.buttonAction(_btnController,success: false);
      return;
    }
    if(selectSubCategory.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Укажите Подкатегорию')),
      );
      Utils.buttonAction(_btnController,success: false);
      return;
    }
    if(costController.text.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Укажите Сумму')),
      );
      Utils.buttonAction(_btnController,success: false);
      return;
    }
    try{
      final res=await _api.createOperation(
          user: userXController.name() ,
          name: commentController.text,
          cost: costController.text,
          pm: selectSubCategory,
          category: (selectType==0)?'Расход':'Доход',
          subcategory: selectCategory
      );
      Get.back(result: res);
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка: $e')),
      );
      Utils.buttonAction(_btnController,success: false);
    }
  }
}
