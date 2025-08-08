import 'package:dio/dio.dart';

class Api {
  static final dio = Dio();
  static Map<String, String> _buildHeaders({String? token}) {
    return {
      if (token != null) 'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
  }

  static Future<dynamic> getData({
    required String endpoint,
    String? token,
  }) async {
    try {
      final response = await dio.get(
        endpoint,
        options: Options(headers: _buildHeaders(token: token)),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        print('Unexpected status code: ${response.statusCode}');
        return null;
      }
    } on DioException catch (e) {
      print('Dio error: ${e.message}');
      return null;
    } catch (e) {
      print('Unexpected error: $e');
      return null;
    }
  }

  static Future<dynamic> postData({
    required String endpoint,
    required Map<String, dynamic> data,
    String? token,
  }) async {
    try {
      final response = await dio.post(
        endpoint,
        data: data,
        options: Options(headers: _buildHeaders(token: token)),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        print('Unexpected status code: ${response.statusCode}');
        return null;
      }
    } on DioException catch (e) {
      print('Dio error: ${e.message}');
      return null;
    } catch (e) {
      print('Unexpected error: $e');
      return null;
    }
  }

  static Future<dynamic> putData({
    required String endpoint,
    required Map<String, dynamic> data,
    String? token,
  }) async {
    try {
      final response = await dio.put(
        endpoint,
        data: data,
        options: Options(headers: _buildHeaders(token: token)),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        print('Unexpected status code: ${response.statusCode}');
        return null;
      }
    } on DioException catch (e) {
      print('Dio error: ${e.message}');
      return null;
    } catch (e) {
      print('Unexpected error: $e');
      return null;
    }
  }

  static Future<int?> deleteData({
    required String endpoint,
    String? token,
  }) async {
    try {
      final response = await dio.delete(
        endpoint,
        options: Options(headers: _buildHeaders(token: token)),
      );

      return response.statusCode;
    } on DioException catch (e) {
      print('Dio error: ${e.message}');
      return null;
    } catch (e) {
      print('Unexpected error: $e');
      return null;
    }
  }
}
