import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ApiService {
  final Dio _dio;

  final _baseUrl = "https://route-ecommerce.onrender.com";

  ApiService(this._dio);

  Future<Map<String, dynamic>> get(
      {required String endPoint,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParameters}) async {
    var response = await _dio.get('$_baseUrl$endPoint',
        options: Options(headers: headers), queryParameters: queryParameters);
    return response.data;
  }

  Future<List<dynamic>> getList(
      {required String endPoint,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParameters}) async {
    var response = await _dio.get('$_baseUrl$endPoint',
        options: Options(
          headers: headers,
        ),
        queryParameters: queryParameters);
    List<dynamic> jsonList = response.data as List<dynamic>;
    return jsonList;
  }

  Future<Map<String, dynamic>> post(
      {required String endPoint,
      Map<String, dynamic>? data,
      FormData? formData,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParameters}) async {
    var response = await _dio.post('$_baseUrl$endPoint',
        data: data ?? formData,
        options: Options(
            headers: headers, receiveTimeout: const Duration(minutes: 2)),
        queryParameters: queryParameters);
    return response.data;
  }

  Future<Map<String, dynamic>> put({
    required String endPoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    var response = await _dio.put('$_baseUrl$endPoint',
        data: data,
        options: Options(headers: headers),
        queryParameters: queryParameters);
    return response.data;
  }

  Future<Map<String, dynamic>> delete({
    required String endPoint,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    var response = await _dio.delete('$_baseUrl$endPoint',
        options: Options(headers: headers), queryParameters: queryParameters);
    return response.data;
  }
}
