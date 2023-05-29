import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/data/network/service/api_service.dart';
import '../../../features/auth/domain/user_model.dart';
import '../../domain/coordinats_model.dart';

class SharedApi {
  final _apiService = ApiService();
  final Dio _dio=Dio();
  Future<List<UsersModel>> fetchUsers() async {
    try {
      final Response response = await _apiService.get('/fetch-users.php',);
      return List<UsersModel>.from(response.data.map((x) => UsersModel.fromJson(x)));
    } catch (e) {
      rethrow;
    }
  }
  Future<List<CoordinatsModel>> geocoder(LatLng latLng) async {
    try {
      final response = await _apiService.post('/geocoder.php',data: {'lat':latLng.latitude,'long':latLng.longitude});
      return List<CoordinatsModel>.from(response.data.map((x) => CoordinatsModel.fromJson(x)));
    } catch (e) {
      rethrow;
    }
  }

}
