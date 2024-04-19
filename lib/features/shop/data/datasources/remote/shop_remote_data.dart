import 'package:injectable/injectable.dart';
import '../../../../../core/di/injection_container.dart';
import '../../../../authentication/domain/entities/user_entity.dart';
import '../../models/brand_model/brand_model.dart';

import '../../../../../core/api/api_service.dart';
import '../../../../../core/constants/api_constants.dart';
import '../../models/category_model/category_model.dart';
import '../../models/product_model/product_model.dart';
import '../shop_data_source.dart';

@LazySingleton(as: ShopDataSource)
class ShopRemoteData implements ShopDataSource {
  final ApiService apiService;

  ShopRemoteData(this.apiService);
  @override
  Future<List<CategoryModel>> getCategories(
      {Map<String, dynamic>? queryParameters}) async {
    final data = await apiService.get(
        endPoint: EndPoints.getAllCategories, queryParameters: queryParameters);
    List<CategoryModel> categories = parseCategories(data);
    return categories;
  }

  List<CategoryModel> parseCategories(Map<String, dynamic> data) {
    List<CategoryModel> categories = [];
    for (var item in data['data']) {
      categories.add(CategoryModel.fromJson(item));
    }
    return categories;
  }

  List<BrandModel> parseBrands(Map<String, dynamic> data) {
    List<BrandModel> brands = [];
    for (var item in data['data']) {
      brands.add(BrandModel.fromJson(item));
    }
    return brands;
  }

  @override
  Future<List<BrandModel>> getBrands(
      {Map<String, dynamic>? queryParameters}) async {
    final data = await apiService.get(
        endPoint: EndPoints.getAllBrands, queryParameters: queryParameters);
    List<BrandModel> brands = parseBrands(data);
    return brands;
  }

  @override
  Future<List<ProductModel>> getProducts(
      {Map<String, dynamic>? queryParameters}) async {
    final data = await apiService.get(
        endPoint: EndPoints.getAllProducts, queryParameters: queryParameters);
    List<ProductModel> products = parseProducts(data);
    return products;
  }

  List<ProductModel> parseProducts(Map<String, dynamic> data) {
    List<ProductModel> products = [];
    for (var item in data['data']) {
      products.add(ProductModel.fromJson(item));
    }
    return products;
  }

  @override
  Future<void> addToFav(String productId) async {
    final data = await apiService.post(
      endPoint: EndPoints.wishlist,
      data: {"productId": productId},
      headers: {"token": getIt<UserEntity>().userToken},
    );

    return data['message'];
  }

  @override
  Future<void> removeFromFav(String productId) async {
    final data = await apiService.delete(
      endPoint: '${EndPoints.wishlist}/$productId',
      headers: {"token": getIt<UserEntity>().userToken},
    );

    return data['message'];
  }

  @override
  Future<List<ProductModel>> getFav() async {
    final data = await apiService.get(
      endPoint: EndPoints.wishlist,
      headers: {"token": getIt<UserEntity>().userToken},
    );
    List<ProductModel> products = parseProducts(data);
    return products;
  }
}
