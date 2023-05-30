import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../../core/x_controller/app_x_controller.dart';
import '../../company/presentation/pages/companies_page.dart';
import '../../operations/presentation/page/operations_page.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);
  final List<Widget> items=[
    CompaniesPage(),
    OperationsPage()
  ];

  final mainXController=Get.find<AppXController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(
          ()=>SalomonBottomBar(
            currentIndex: mainXController.currentMainPage(),
            onTap: (i) => mainXController.currentMainPage(i),
            items: [
              SalomonBottomBarItem(
                icon: Icon(Icons.home),
                title: Text("Компании"),
                selectedColor: Colors.purple,
              ),
              /// Profile
              SalomonBottomBarItem(
                icon: Icon(Icons.currency_ruble),
                title: Text("Операции"),
                selectedColor: Colors.teal,
              ),
            ],
          )
      ),
      body: Obx(
          ()=>items[mainXController.currentMainPage()]
      ),
    );
  }
}
