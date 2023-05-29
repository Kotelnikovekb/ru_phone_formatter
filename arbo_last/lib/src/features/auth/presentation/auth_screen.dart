import 'package:arbo_last/src/core/widgets/app_input.dart';
import 'package:arbo_last/src/core/x_controller/app_x_controller.dart';
import 'package:arbo_last/src/core/x_controller/user_x_controller.dart';
import 'package:arbo_last/src/features/auth/data/auth_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../core/constants/project_routes.dart';
import '../../../core/domain/user_data_model.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/app_selector.dart';
import '../domain/user_model.dart';


class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _userStorage=GetStorage();

  final _btnController = RoundedLoadingButtonController();
  final _formKey = GlobalKey<FormState>();
  final appXController=Get.find<AppXController>();
  final userXController=Get.find<UserXController>();
  final authApi=AuthApi();
  String userName='';
  final passwordController=TextEditingController();


  @override
  void initState() {

    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: _formKey,
              child: Column(
                  children: [
                    Obx(
                            () => AppSelector<UsersModel>(
                              items: appXController.users(),
                              title: "Пользователь",
                              onSelectionDone: (value){
                                setState(() {
                                  userName=(value as UsersModel).name;
                                });
                              },
                              itemKey: 'name',
                              itemAsString: (item){
                                final u=item as UsersModel;
                                return u.name;
                              },
                            )
                    ),
                    AppInput(
                      label: Text('Пароль'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Укажите пароль';
                        }
                        return null;
                      },
                      controller: passwordController,
                    ),
                    RoundedLoadingButton(
                      child: Text('Войти', style: TextStyle(color: Colors.white)),
                      controller: _btnController,
                      onPressed: login,
                    )
                  ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void login()async{
    try{
      if (!_formKey.currentState!.validate()) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Заполните поля')),
        );
        Utils.buttonAction(_btnController,success: false);
        return;
      }
      if(userName.isEmpty){
        Utils.buttonAction(_btnController,success: false);
        return;
      }
      final res=await authApi.login(userName, passwordController.text, '');
      if(res.data['success']=='0'){
        Get.snackbar('Упс..', 'Ошибка в логине или пароле');
        Utils.buttonAction(_btnController,success: false);
        return;
      }
      userXController.setUserData(UserDataModel.fromJson(res.data));
      Get.offAndToNamed(ProjectRoutes.MAIN);
      Utils.buttonAction(_btnController,success: true);
    }catch(e){
      print(e);
      Utils.buttonAction(_btnController,success: false);
    }
  }
}


