import 'dart:convert';
import 'package:http/http.dart' as http;

class SokoApi {
  static const String baseUrl = 'https://soko.ug/api/v1/';

  static Future<ApiResponse> getBrands() async {
    final response = await http.get(Uri.parse(baseUrl + 'brands/top'));
    if (response.statusCode == 200) {
      return ApiResponse.fromJson(json.decode(response.body));
    } else {
      return ApiResponse(
        success: false,
        message: 'Error fetching brands',
      );
    }
  }
}

class ApiResponse {
  final bool success;
  final String message;
  final dynamic data;

  ApiResponse({required this.success, required this.message, this.data});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      success: json['success'],
      message: json['message'],
      data: json['data'],
    );
  }
}
