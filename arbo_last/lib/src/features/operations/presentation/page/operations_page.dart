import 'package:arbo_last/src/core/constants/project_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';
import 'package:intl/date_symbol_data_local.dart';
import '../../../../core/utils.dart';
import '../../domain/consumption_model.dart';
import '../../get_x_controller/operations_page_x_controller.dart';

class OperationsPage extends GetView<OperationsXController> {
  const OperationsPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('ru_RU', null);


    return controller.obx(
            (state) => Scaffold(
              appBar: AppBar(
                title: Text('Операции'),
              ),
              body: Column(
                children: [
                  Expanded(
                      child: StickyGroupedListView<ConsumptionModel, DateTime>(
                        shrinkWrap: true,
                        elements: state??[],
                        groupBy: (ConsumptionModel element) =>  DateTime(
                            element.datecreate.year,
                            element.datecreate.month,
                            element.datecreate.day
                        ),
                        groupSeparatorBuilder: (ConsumptionModel element) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 6),
                          child: Text(
                            DateFormat('dd LLL','ru_RU').format(element.datecreate),
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        itemBuilder: (context, ConsumptionModel element) => ListTile(
                          title: Text('${element.pm} - ${element.name}'),
                          subtitle: Text(DateFormat('dd LLLL HH:mm','ru_RU').format(element.datecreate)
                          ),
                          trailing: Text('${Utils.formatAmount(element.trueCost)} ₽',
                            style: TextStyle(
                                color: (Utils.doubleParser(element.trueCost) > 0) ? Colors.green : Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 18),
                          ),
                          /*leading: CircleAvatar(
                        backgroundColor: Utils.fromHex(element.category.color),
                        child: Icon(Utils.fromIcon(element.category.icon)),
                      ),*/
                          onTap: (){

                          },
                        ),
                        itemComparator: (item1, item2) => item1.datecreate.compareTo(item2.datecreate),
                        elementIdentifier: (element) => element.name ,
                        order: StickyGroupedListOrder.DESC,
                        itemScrollController: controller.itemScrollController,
                      )
                  )
                ],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () async{
                  final res=await Get.toNamed(ProjectRoutes.NEW_OPERATION);
                  if(res!=null){
                    controller.addOperation(res);
                  }
                },
                child: Icon(Icons.add),
              ),
            )
    );
  }
}
