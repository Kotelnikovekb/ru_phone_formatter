import '../../../core/data/network/service/api_service.dart';
import '../domain/consumption_model.dart';

class ConsumptionApi{
  final _apiService = ApiService();

  Future<List<ConsumptionModel>> fetchCompany(int page) async {
    try {
      final response = await _apiService.get('/getConsumptionList.php',queryParameters: {'page':page});
      return  List<ConsumptionModel>.from(response.data['consumption'].map((x) => ConsumptionModel.fromJson(x)));
    } catch (e) {
      rethrow;
    }
  }
}