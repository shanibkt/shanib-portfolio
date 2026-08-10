import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ContactResponse {
  final bool success;
  final String message;

  ContactResponse({required this.success, required this.message});
}

class ContactService {
  static const String scriptUrl = 'https://script.google.com/macros/s/AKfycbzdpGgZlnrq6M7e_cMoWUTJcSSj_98h9Cvue46scRujmBk9W52ZKfSn0JIYJkIPgIaYHg/exec';

  Future<ContactResponse> sendMessage({
    required String name,
    required String email,
    required String message,
    String? place,
    String? mobile,
  }) async {
    try {
      debugPrint('ContactService: Sending POST request');
      final response = await http.post(
        Uri.parse(scriptUrl),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'name': name,
          'email': email,
          'message': message,
          'place': place ?? '',
          'mobile': mobile ?? '',
        },
      );

      debugPrint('ContactService: Status Code: ${response.statusCode}');
      debugPrint('ContactService: Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 302) {
        final data = json.decode(response.body);
        return ContactResponse(
          success: data['success'] == true,
          message: data['message'] ?? (data['success'] == true ? 'Success' : 'Unknown error'),
        );
      }
      
      return ContactResponse(success: false, message: 'Server error: ${response.statusCode}');
    } catch (e) {
      debugPrint('ContactService: Exception: $e');
      return ContactResponse(success: false, message: 'Network error occurred');
    }
  }
}
