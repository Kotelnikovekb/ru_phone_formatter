import 'package:get/get.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';

import '../data/consumption_api.dart';
import '../domain/consumption_model.dart';

class OperationsXController extends GetxController with StateMixin<List<ConsumptionModel>>{
  final _api=ConsumptionApi();
  int _page=0;
  final GroupedItemScrollController itemScrollController = GroupedItemScrollController();


  @override
  void onInit() {
    super.onInit();
    fetchOperations();
  }
  void fetchOperations()async{
    try{
      final res=await _api.fetchCompany(_page);

      if(res.isNotEmpty){
        _page++;
        change([...state??[],...res],status: RxStatus.success());
      }else{
        if(_page==0){
          change([],status: RxStatus.empty());
        }else{
          change(state??[],status: RxStatus.success());
        }
      }
    }catch(e){
      change(null,status: RxStatus.error(e.toString()));
    }
  }
}