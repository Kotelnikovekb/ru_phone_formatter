import 'package:dio/dio.dart';

import '../../../core/data/network/service/api_service.dart';

class AuthApi {
  final _apiService = ApiService();

  Future<Response> login(String email, String password,String deviceId) async {
    try {
      final Response response = await _apiService.post('/loginV2.php', data: {
        'name': email,
        'password': password,
        'deviceId':deviceId
      },);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
