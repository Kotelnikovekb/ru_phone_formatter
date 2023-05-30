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
  Future<ConsumptionModel> createOperation(
      {required String user,
      required String name,
      required String cost,
      required String pm,
      required String category,
      required String subcategory}
      ) async {
    try {
      final response = await _apiService.post('/create-consumption.php',data:{
        "user": user,
        "name":name,
        "cost":cost,
        "pm":pm,
        "category":category,
        "subcategory":subcategory
      });
      return ConsumptionModel(
          id: response.data['consumption'][0]['id'],
          datecreate: DateTime.now(),
          user: user,
          name: name,
          cost: cost,
          pm: pm,
          category: category,
          subcategory: subcategory,
          trueCost: (category=='Расход')?'-$cost':cost,
          paymentType: ''
      );
    } catch (e) {
      rethrow;
    }
  }
}