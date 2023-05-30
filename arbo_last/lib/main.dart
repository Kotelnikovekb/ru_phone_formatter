import 'package:arbo_last/src/core/constants/languages.dart';
import 'package:arbo_last/src/core/constants/project_routes.dart';
import 'package:arbo_last/src/core/x_controller/app_x_controller.dart';
import 'package:arbo_last/src/core/x_controller/user_x_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';

void main()async {
  await GetStorage.init();
  initializeDateFormatting('ru_RU', null);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Arbo DEMO',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      getPages: ProjectRoutes.pages,
      initialRoute: (GetStorage().read('name')!=null&&GetStorage().read('name')!='')?ProjectRoutes.MAIN:ProjectRoutes.AUTH,
      initialBinding: AppBinding(),
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('ru', 'ru'),
      translations: Languages(),
    );
  }
}
class AppBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserXController());
    Get.lazyPut(() => AppXController());
  }
}