import 'package:injectable/injectable.dart';

import '../../../../../core/api/api_service.dart';
import '../../../../../core/constants/api_constants.dart';
import '../../../../shop/data/models/product_model/product_model.dart';
import '../search_data_source.dart';

@LazySingleton(as: SearchDataSource)
class SearchRemoteData implements SearchDataSource {
  final ApiService apiService;

  SearchRemoteData(this.apiService);

  @override
  Future<List<ProductModel>> searchProducts({required String keyword}) async {
    final data = await apiService.get(
        endPoint: EndPoints.getAllProducts,
        queryParameters: {'keyword': keyword});
    return parseProducts(data);
  }

  List<ProductModel> parseProducts(Map<String, dynamic> data) {
    List<ProductModel> products = [];
    for (var item in data['data']) {
      products.add(ProductModel.fromJson(item));
    }
    return products;
  }
}
