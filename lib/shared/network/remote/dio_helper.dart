import 'package:dio/dio.dart';

class DioHelper {
  static var dio = Dio(
    BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true),
  );

  static Future<Response> postData(
      {required String path,
      required Map<String, dynamic> data,
      String? token}) {
    dio.options.headers = {
      'lang': 'en',
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    return dio.post(path, data: data);
  }

  static Future<Response> putData(
      {required String path,
      required Map<String, dynamic> data,
      required String? token}) {
    dio.options.headers = {
      'lang': 'en',
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    return dio.put(path, data: data);
  }

  static Future<Response> getData(
      {required String path, String? token, Map<String, dynamic>? data}) async {
    dio.options.headers = {
      'lang': 'en',
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    return await dio.get(path, queryParameters: data);
  }
}
