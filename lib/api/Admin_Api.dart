
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sebsabi/model/Client.dart';
import 'package:sebsabi/model/ClientAuthRequest.dart';
import 'dart:html' as html;

class AdminApi{
  static const String url = 'https://api.sebsabi.b.gebeyalearning.com';

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

 static  Future<List<dynamic>> searchClients(String by,String searchText, int size) async {
    final token=html.window.localStorage['auth_token'];
    final clientUrl = Uri.parse('$url/api/core/admin/view/search/clients?$by=$searchText&size=$size');
    try {
      final response = await http.get(clientUrl,headers: {'Authorization': 'Bearer $token'},);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return data['content'];
      } else {
        throw Exception('Failed to load clients');
      }
    }catch(e){
      throw Exception('Failed to load clients: $e');
    }
  }
  static  Future<List<dynamic>> searchGigWorker(String by,String searchText, int size) async {
    final token=html.window.localStorage['auth_token'];
    final clientUrl = Uri.parse('$url/api/core/admin/view/search/gig-worker?$by=$searchText&size=$size');
    try {
      final response = await http.get(clientUrl,headers: {'Authorization': 'Bearer $token'},);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return data['content'];
      } else {
        throw Exception('Failed to load clients');
      }
    }catch(e){
      throw Exception('Failed to load clients: $e');
    }
  }
  static  Future<List<dynamic>> searchForms(String title, int size) async {
    final token=html.window.localStorage['auth_token'];
    final clientUrl = Uri.parse('$url/api/core/admin/view/search?title=$title&size=$size');
    try {
      final response = await http.get(clientUrl,headers: {'Authorization': 'Bearer $token'},);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return data['content'];
      } else {
        throw Exception('Failed to load clients');
      }
    }catch(e){
      throw Exception('Failed to load clients: $e');
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

  static Future<int> fetchNumberofClients() async {
    final token=html.window.localStorage['auth_token'];
    final clientUrl = Uri.parse('$url/api/core/admin/view/number_of_clients');
    try{
    final response = await http.get(
      clientUrl,
      headers: {'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load number of clients");
    }

    }catch (e) {
      throw Exception("Failed to load number of clients: $e");
    }

  }
  static Future<int> fetchNumberofGigWorkers() async {
    final token=html.window.localStorage['auth_token'];
    final clientUrl = Uri.parse('$url/api/core/admin/view/number_of_gigworkers');
    try{
      final response = await http.get(
        clientUrl,
        headers: {'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception("Failed to load number of clients");
      }

    }catch (e) {
      throw Exception("Failed to load number of clients: $e");
    }

  }

  static Future<num> formsPerClient() async {
    final token=html.window.localStorage['auth_token'];
    final clientUrl = Uri.parse('$url/api/core/admin/view/formsPerClient');
    try{
      final response = await http.get(
        clientUrl,
        headers: {'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        // Parse the JSON response
        final List<dynamic> formsPerClientData = jsonDecode(response.body);

        // Calculate the average count
        num totalCount = 0;
        for (var formData in formsPerClientData) {
          totalCount += formData['count'];
          print(totalCount);
        }

        // Ensure there's at least one entry to avoid division by zero
        return (formsPerClientData.isNotEmpty)
            ? double.parse((totalCount / formsPerClientData.length).toStringAsFixed(1))
            : 0.0;
      } else {
        throw Exception("Failed to load forms per client data");
      }

    }catch (e) {
      throw Exception("Failed to load number of clients: $e");
    }

  }

  static Future<num> proposalsPerClient() async {
    final token=html.window.localStorage['auth_token'];
    final clientUrl = Uri.parse('$url/api/core/admin/view/proposalsPerForm');
    try{
      final response = await http.get(
        clientUrl,
        headers: {'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        // Parse the JSON response
        final List<dynamic> formsPerClientData = jsonDecode(response.body);

        // Calculate the average count
        num totalCount = 0;
        for (var formData in formsPerClientData) {
          totalCount += formData['count'];
          print(totalCount);
        }

        // Ensure there's at least one entry to avoid division by zero
        return (formsPerClientData.isNotEmpty)
            ? double.parse((totalCount / formsPerClientData.length).toStringAsFixed(1))
            : 0.0;
      } else {
        throw Exception("Failed to load forms per client data");
      }

    }catch (e) {
      throw Exception("Failed to load number of clients: $e");
    }

  }

  static Future<num> formsAssignedPerWorker() async {
    final token=html.window.localStorage['auth_token'];
    final clientUrl = Uri.parse('$url/api/core/admin/view/formsAssignedToGigWorkers');
    try{
      final response = await http.get(
        clientUrl,
        headers: {'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        // Parse the JSON response
        final List<dynamic> formsPerClientData = jsonDecode(response.body);

        // Calculate the average count
        num totalCount = 0;
        for (var formData in formsPerClientData) {
          totalCount += formData['count'];
          print(totalCount);
        }

        // Ensure there's at least one entry to avoid division by zero
        return (formsPerClientData.isNotEmpty)
            ? double.parse((totalCount / formsPerClientData.length).toStringAsFixed(1))
            : 0.0;
      } else {
        throw Exception("Failed to load forms per client data");
      }

    }catch (e) {
      throw Exception("Failed to load number of clients: $e");
    }

  }

  static Future<List<Map<String, dynamic>>> countByStatus() async {
    final token=html.window.localStorage['auth_token'];
    final clientUrl = Uri.parse('$url/api/core/admin/view/countByStatus');
    try{
      final response = await http.get(
        clientUrl,
        headers: {'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        // Parse the JSON response
        return List<Map<String, dynamic>>.from(jsonDecode(response.body));
      } else {
        throw Exception("Failed to load forms by status data");
      }

    }catch (e) {
      throw Exception("Failed to load forms by status data: $e");
    }

  }

 static Future<Map<String, dynamic>> updateStatusClient(
      int clientId, Map<String, dynamic> clientRequest) async {
   final token=html.window.localStorage['auth_token'];
   final clientUrl = Uri.parse('$url/api/core/admin/view/ban/clients?clientId=$clientId'); // Put your API endpoint here

    try {
      final response = await http.put(
        clientUrl,
        headers: <String, String>{
          'Content-Type': 'application/json','Authorization': 'Bearer $token',
        },
        body: jsonEncode(clientRequest,
        ),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to update client');
      }
    } catch (e) {
      print(jsonEncode( clientRequest,
      ),);
      throw Exception('Failed to update client: $e');
    }
  }

  static Future<Map<String, dynamic>> updateStatusWorker(
      int gigWorkerid, Map<String, dynamic> gigWorkerRequest) async {
    final token=html.window.localStorage['auth_token'];
    final clientUrl = Uri.parse('$url/api/core/admin/view/ban/gig-workers?gigWorkerid=$gigWorkerid'); // Put your API endpoint here

    try {
      final response = await http.put(
        clientUrl,
        headers: <String, String>{
          'Content-Type': 'application/json','Authorization': 'Bearer $token',
        },
        body: jsonEncode(gigWorkerRequest,
        ),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to update client');
      }
    } catch (e) {
      print(jsonEncode( gigWorkerRequest,
      ),);
      throw Exception('Failed to update client: $e');
    }
  }



}





