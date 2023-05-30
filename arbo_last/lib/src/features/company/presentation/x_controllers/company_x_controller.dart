import 'package:arbo_last/src/features/company/data/company_api.dart';
import 'package:get/get.dart';

import '../../domain/company_model.dart';

class CompanyXController extends GetxController with StateMixin<CompanyModel>{
  final int companyId;
  CompanyXController(this.companyId);
  final api=CompanyApi();

  @override
  void onInit() {
    super.onInit();
    api.fetchCompanyData(companyId)
        .then((value){
          change(value,status: RxStatus.success());
    })
        .catchError((e){
      change(null,status: RxStatus.error(e));
    });
  }
  void addWork(Work work){
    if(state!=null){
      final ns= state!;
      ns.works.insert(0, work);
      change(ns,status: RxStatus.success());
    }
  }
}