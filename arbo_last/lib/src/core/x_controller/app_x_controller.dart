import 'package:get/get.dart';

import '../../features/auth/domain/user_model.dart';
import '../data/data/share_api.dart';

class AppXController extends GetxController{
  RxList<UsersModel> users=<UsersModel>[].obs;
  final sharedApi=SharedApi();
  RxInt currentMainPage=0.obs;

  @override
  void onInit() {
    super.onInit();
    sharedApi.fetchUsers().then((value){
      users.addAll(value);
    });
  }
}