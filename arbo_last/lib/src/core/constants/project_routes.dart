import 'package:arbo_last/src/core/x_controller/app_x_controller.dart';
import 'package:arbo_last/src/core/x_controller/user_x_controller.dart';
import 'package:get/get.dart';

import '../../features/auth/presentation/auth_screen.dart';
import '../../features/company/presentation/screens/add_company.dart';
import '../../features/company/presentation/screens/add_work_screen.dart';
import '../../features/company/presentation/screens/company_screen.dart';
import '../../features/company/presentation/x_controllers/companies_x_controller.dart';
import '../../features/company/presentation/x_controllers/company_x_controller.dart';
import '../../features/main/presentation/main_screen.dart';
import '../../features/map/map_select_screen.dart';
import '../../features/operations/get_x_controller/operations_page_x_controller.dart';
import '../../features/operations/presentation/screens/add_operation_screen.dart';

class ProjectRoutes{
  static String AUTH='/auth';
  static String NEW_COMPANY='/new_company';
  static String NEW_OPERATION='/new_operation';
  static String MAIN='/main';
  static String MAP_SELECT='/map_select';
  static String COMPANY='/company';
  static String NEW_WORK='/new_work';

  static List<GetPage> pages=[
    GetPage(
        name: AUTH,
        page:()=> const AuthScreen()
    ),
    GetPage(
        name: MAIN,
        page:()=> MainScreen(),
        binding: BindingsBuilder((){
          Get.lazyPut<UserXController>(() => UserXController());
          Get.lazyPut<AppXController>(() => AppXController());
          Get.lazyPut<CompaniesXController>(() => CompaniesXController());
          Get.lazyPut<OperationsXController>(() => OperationsXController());
        })
    ),
    GetPage(
        name: NEW_COMPANY,
        page:()=> const AddCompany(),
        binding: BindingsBuilder((){
          Get.lazyPut<UserXController>(() => UserXController());
          Get.lazyPut<AppXController>(() => AppXController());
        })
    ),
    GetPage(
        name: MAP_SELECT,
        page:()=> const MapSelectScreen(),
    ),
    GetPage(
      name: NEW_OPERATION,
      page:()=> const AddOperationScreen(),
        binding: BindingsBuilder((){
          Get.lazyPut<UserXController>(() => UserXController());
          Get.lazyPut<AppXController>(() => AppXController());
        })
    ),
    GetPage(
        name: COMPANY,
        page:()=> const CompanyScreen(),
        binding: BindingsBuilder((){
          Get.lazyPut<UserXController>(() => UserXController());
          Get.lazyPut<AppXController>(() => AppXController());
          Get.lazyReplace(() => CompanyXController(Get.arguments['id']));
        })
    ),
    GetPage(
        name: NEW_WORK,
        page:()=> const AddWorkScreen(),
        binding: BindingsBuilder((){
          Get.lazyPut<UserXController>(() => UserXController());
          Get.lazyPut<AppXController>(() => AppXController());
        })
    ),
  ];
}