import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://newsapi.org/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getDate(
      {required String url, required Map<String,dynamic> query}) async {
    return dio.get(url, queryParameters: query);
  }
}
