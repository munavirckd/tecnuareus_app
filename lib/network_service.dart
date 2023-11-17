import 'package:dio/dio.dart';

class NetworkService {
  final Dio _dio = Dio();

  Future<Response> get(String url) async {
    try {
      final response = await _dio.get(url);
      return response;
    } catch (error) {
      throw Exception("Failed to get data: $error");
    }
  }

  Future<Response> post(String url, Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(
        url,
        data: data,
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
      return response;
    } catch (error) {
      throw Exception("Failed to post data: $error");
    }
  }
}
