import 'package:arbo_last/src/core/data/network/service/api_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../domain/companies_model.dart';

class CompanyApi{
  final _apiService = ApiService();
  Future<List<CompaniesModel>> fetchCompany(int page) async {
    try {
      final response = await _apiService.get('/fetchCompany.php',queryParameters: {'page':page});
      return List<CompaniesModel>.from(response.data.map((x) => CompaniesModel.fromJson(x)));
    } catch (e) {
      rethrow;
    }
  }
  Future<CompaniesModel> createCompany({
    required String user,
    required LatLng latLng,
    required String name,
    required String address,
    required String phone,
    required String companyName,
    required String email,
    required String type
  }) async {
    try {
      final response = await _apiService.post('/add-company.php',data: {
        "user":user,
        "name":name,
        "address":address,
        "phone":phone,
        "v":"56.887188694231625",
        "v1":"60.63237067723744",
        "company_name":companyName,
        "email":email,
        "type":type
      });
      if(response.data['success']=='0'){
        throw Error();
      }
      return CompaniesModel(
          id: response.data['companyId'].toString(),
          name: name,
          adress: address,
          phone: phone,
          fio: user,
          email: email,
          v1: latLng.latitude.toString(),
          v2: latLng.longitude.toString(),
          dateCreate: DateTime.now(),
          category: categoryValues.map[type]!
      );
    } catch (e) {
      rethrow;
    }
  }
}