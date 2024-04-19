import '../models/brand_model/brand_model.dart';

import '../models/category_model/category_model.dart';
import '../models/product_model/product_model.dart';

abstract class ShopDataSource {
  Future<List<CategoryModel>> getCategories(
      {Map<String, dynamic>? queryParameters});
  Future<List<BrandModel>> getBrands({Map<String, dynamic>? queryParameters});
  Future<List<ProductModel>> getProducts(
      {Map<String, dynamic>? queryParameters});
  Future<List<ProductModel>> getFav();
  Future<void> addToFav(String productId);
  Future<void> removeFromFav(String productId);
}
