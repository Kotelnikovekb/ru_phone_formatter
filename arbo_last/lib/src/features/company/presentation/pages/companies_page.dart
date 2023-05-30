import 'package:arbo_last/src/core/constants/project_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../x_controllers/companies_x_controller.dart';

class CompaniesPage extends GetView<CompaniesXController> {
  const CompaniesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.obx(
            (state) => Scaffold(
              appBar: AppBar(
                title: Text('Компании'),
              ),
              body: ListView.separated(
                  itemBuilder: (_,index){
                    return ListTile(
                     title: Text(state[index].name),
                      subtitle: Text(state[index].adress),
                      onTap: ()=>Get.toNamed(
                          ProjectRoutes.COMPANY,
                          arguments: {
                            'id':int.parse(state[index].id),
                            'name':state[index].name
                          }
                      ),
                    );
                  },
                  separatorBuilder: (_,index)=> const Divider(),
                  itemCount: state!.length
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () async{
                  final res=await Get.toNamed(ProjectRoutes.NEW_COMPANY);
                  controller.addCompany(res);
                },
                child: Icon(Icons.add),
              ),
            ),
    );
  }
}
