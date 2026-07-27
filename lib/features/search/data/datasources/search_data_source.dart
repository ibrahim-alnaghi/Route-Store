import '../../../shop/data/models/product_model/product_model.dart';

abstract class SearchDataSource {
  Future<List<ProductModel>> searchProducts({required String keyword});
}
