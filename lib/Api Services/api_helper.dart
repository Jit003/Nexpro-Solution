import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Model/leads_model.dart';

class ApiHelper {
  static const String baseUrl = 'https://nexprosolution.com/api';
  static const String token = 'Bearer 18|OU6SBoQBy0hz0CMeIQyizio8Jfqy8Y1u4s6dSJjlb7cb0586';

  static Future<Map<String, dynamic>?> adminLogin(String email, String password) async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    var request = http.Request('POST', Uri.parse('$baseUrl/admin-login'));
    request.body = json.encode({
      "email": email,
      "password": password,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      return json.decode(responseBody);
    } else {
      return {'error': response.reasonPhrase};
    }
  }

  /// Fetch Leads Data
  static Future<LeadsModel?> fetchLeads() async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': token,
    };

    var request = http.Request('GET', Uri.parse('$baseUrl/leads'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      return LeadsModel.fromJson(json.decode(responseBody));
    } else {
      return null;
    }
  }
}


