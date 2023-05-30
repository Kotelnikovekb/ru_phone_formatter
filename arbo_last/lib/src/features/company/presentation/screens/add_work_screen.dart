import 'package:arbo_last/src/features/company/data/company_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../../core/utils.dart';
import '../../../../core/widgets/app_input.dart';
import '../../../../core/widgets/app_selector.dart';
import '../../../../core/widgets/type_select_button.dart';
import '../../../../core/x_controller/app_x_controller.dart';
import '../../../../core/x_controller/user_x_controller.dart';

class AddWorkScreen extends StatefulWidget {
  const AddWorkScreen({Key? key}) : super(key: key);

  @override
  State<AddWorkScreen> createState() => _AddWorkScreenState();
}

class _AddWorkScreenState extends State<AddWorkScreen> {
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
  final companyApi=CompanyApi();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Новая работа'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 12,vertical: 12),
        child: SingleChildScrollView(
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
      ),
    );
  }
  @override
  void initState() {
    super.initState();
    changeType(0);

  }
  void changeType(int type){
    selectType=type;
    category.clear();
    selectSubCategory='';
    appXController.categories.forEach((element) {
      if(element.type==((type==0)?'3':'4')&&category.where((element1) => element1==element.header).isEmpty){
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
      if(element.type==((selectType==0)?'3':'4')&&element.header==category){
        subCategory.add(element.name);
      }
    });
    setState(() {

    });
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
      final res=await companyApi.createWork(
          user: userXController.name(),
          name: commentController.text,
          cost: costController.text,
          id: Get.arguments['id'].toString(),
          type:  (selectType==0)?'Расход':'Доход',
          category: selectCategory,
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
