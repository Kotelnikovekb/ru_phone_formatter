import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../domain/user_data_model.dart';

class UserXController extends GetxController{
  final _userStorage=GetStorage();

  RxString name=''.obs;
  RxString avatar=''.obs;


  void setUserData(UserDataModel data){
    try{
      name(data.name);
      avatar(data.avatar);
      _userStorage.write('name', data.name);
      _userStorage.write('avatar', data.avatar);
      print('====================>>>>>>>>>>>${_userStorage.hasData('name')}');
    }catch(e,s){
      print('====================>>>>>>>>>>>${e}\n$s');

    }
  }

  @override
  void onInit() {
    super.onInit();
    name(_userStorage.read('name')??'');
    avatar(_userStorage.read('avatar')??'');
  }
}