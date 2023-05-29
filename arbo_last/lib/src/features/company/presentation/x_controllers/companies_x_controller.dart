import 'package:get/get.dart';

import '../../data/company_api.dart';
import '../../domain/companies_model.dart';

class CompaniesXController extends GetxController with StateMixin<List<CompaniesModel>>{

  final _api=CompanyApi();
  int page=0;
  @override
  void onInit() {
    fetchCompany();
    super.onInit();
  }
  void addCompany(CompaniesModel company){
    change([company,...state??[]],status: RxStatus.success());
  }

  void fetchCompany()async{
    try{
      final res=await _api.fetchCompany(page);
      if(res.isNotEmpty){
        page++;
        change([...state??[],...res],status: RxStatus.success());
      }else{
        change(state,status: (page==0)?RxStatus.empty():RxStatus.success());
      }
    }catch(e){
      change(null,status: RxStatus.error(e.toString()));
    }
  }
}