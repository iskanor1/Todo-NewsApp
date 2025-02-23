import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioHelper {
  static Dio? _dio;

  static Dio get dio {
    if (_dio == null) {
      throw Exception('Dio is not initialized. Call DioHelper.init() first.');
    }
    return _dio!;
  }

  static void init() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://newsapi.org/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    required Map<String, dynamic> query,
  }) async {
    try {
      return await dio.get(
        url,
        queryParameters: query,
      );
    } on DioError catch (e) {
      // Handle Dio-specific errors
      throw Exception('Failed to load data: ${e.message}');
    } catch (e) {
      // Handle other errors
      throw Exception('Failed to load data: $e');
    }
  }
}