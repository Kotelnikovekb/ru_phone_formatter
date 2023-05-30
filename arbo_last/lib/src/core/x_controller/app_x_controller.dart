import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../features/auth/domain/user_model.dart';
import '../data/data/share_api.dart';
import '../domain/category_model.dart';

class AppXController extends GetxController{
  RxList<UsersModel> users=<UsersModel>[].obs;
  RxList<CategoryModel> categories=<CategoryModel>[].obs;
  final sharedApi=SharedApi();
  RxInt currentMainPage=0.obs;
  final _appStorage=GetStorage();


  @override
  void onInit() {
    super.onInit();
    if(_appStorage.hasData('category')){
      try{
        categories.addAll(List<CategoryModel>.from(json.decode(_appStorage.read('category')).map((x) => CategoryModel.fromJson(x))));
      }catch(e){
        print('Ошибка категорий $e');
      }
    }



    sharedApi.fetchUsers().then((value){
      users.addAll(value);
    });
    sharedApi.fetchCategory().then((value){
      categories.clear();
      categories.addAll(value);
    });
  }
}