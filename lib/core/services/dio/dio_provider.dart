import 'package:dio/dio.dart';

import '../../constants/api_constants.dart';

class DioProvider {
  static late Dio dio;
  static init() {
    dio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));
  }

  static Future<Response> post({
    required String endpoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    return await dio.post(endpoint,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
        ));
  }

  static Future<Response> get({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    return await dio.get(endpoint,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
        ));
  }

  static Future<Response> put({
    required String endpoint,
    required Map<String, dynamic> data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    return await dio.put(endpoint,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
        ));
  }

  static Future<Response> delete({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    return await dio.delete(endpoint,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
        ));
  }
}
