
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sebsabi/model/Client.dart';
import 'package:sebsabi/model/ClientAuthRequest.dart';
import 'dart:html' as html;

class AdminApi{
  static const String url = 'http://api.sebsabi.b.gebeyalearning.com';

  static Future<List<Map<String, dynamic>>> fetchClients() async {
    final token=html.window.localStorage['auth_token'];
    final clientUrl = Uri.parse('$url/api/core/admin/view/clients');// Replace 'your_api_url_here' with your actual API endpoint

    final response = await http.get(
     clientUrl,
      headers: {'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the data
      List<dynamic> jsonResponse = json.decode(response.body);
      return List<Map<String, dynamic>>.from(jsonResponse);
    } else {
      // If the server did not return a 200 OK response, throw an exception
      throw Exception('Failed to load clients');
    }
  }

  static Future<List<Map<String, dynamic>>> fetchWorkers() async {
    final token=html.window.localStorage['auth_token'];
    final clientUrl = Uri.parse('$url/api/core/admin/view/gigworkers');// Replace 'your_api_url_here' with your actual API endpoint

    final response = await http.get(
      clientUrl,
      headers: {'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the data
      List<dynamic> jsonResponse = json.decode(response.body);
      return List<Map<String, dynamic>>.from(jsonResponse);
    } else {
      // If the server did not return a 200 OK response, throw an exception
      throw Exception('Failed to load clients');
    }
  }
}





