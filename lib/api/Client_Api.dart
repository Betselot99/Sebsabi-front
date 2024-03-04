
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sebsabi/model/Client.dart';
import 'package:sebsabi/model/ClientAuthRequest.dart';
import 'dart:html' as html;

class ClientApi{
  static const String url = 'http://localhost:8080';

  static Future<String?> loginClient(String username,String password) async {
    final loginUrl = Uri.parse('$url/api/auth/login');// Replace 'your_api_url_here' with your actual API endpoint
    final response = await http.post(
      loginUrl,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(ClientAuthRequest(username: username, password: password)),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);

      // Assuming your token is in a field named 'token' in the JSON response
      final String token = responseData['token'] as String;
      saveTokenToLocalStorage(token);
      return token;
    }else{
      throw Exception('Failed to login');
    }
  }

  static void saveTokenToLocalStorage(String token) {
    html.window.localStorage['auth_token'] = token;
  }

  static String? getTokenFromLocalStorage() {
    return html.window.localStorage['auth_token'];
  }

  // static Future<bool> validateToken(String? token) async {
  //   final validationUrl = Uri.parse('$url/auth/validate?token=$token');
  //   final response = await http.get(validationUrl);
  //
  //   return response.statusCode == 200;
  // }



  // Future<bool> isLoggedIn() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getString('accessToken') != null;
  // }

  static Future<int> register(Client client) async {
    final registerUrl = Uri.parse('$url/api/core/client/signup');
    final response = await http.post(registerUrl, headers: {
      'Content-Type': 'application/json'},body: jsonEncode(client.toJson()));

    if (response.statusCode == 201) {
      print(response.body);
      return 1;
    }else
    {
      return 0;
    }
  }

  static Future<Map<String, dynamic>> getClientById() async {
  final token=html.window.localStorage['auth_token'];
  final createFormUrl = Uri.parse('$url/api/core/client/view/profile');

  if (token == null) {
  throw Exception('Bearer token not found');
  }
try{
  final response = await http.get(
  createFormUrl, headers: {'Authorization': 'Bearer $token',
  },);
  if (response.statusCode == 200) {
  Map<String, dynamic> responseBody = jsonDecode(response.body);

  return responseBody;
  } else {
  print("wrong");
  throw Exception('Failed to Update form');
  }

  }catch(e){
  print(e);
  return {};

  }



}

  static Future<void> UpdateClient(Map<String, dynamic> clientRequest ) async {
    final token=html.window.localStorage['auth_token'];
    final createFormUrl = Uri.parse('$url/api/core/client//view/profile/update');

    if (token == null) {
      throw Exception('Bearer token not found');
    }

    final response = await http.put(
        createFormUrl, headers: {'Content-Type': 'application/json','Authorization': 'Bearer $token',
    },
        body: jsonEncode(clientRequest));
    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      print('Client updated successfully: $responseBody');
    } else {
      print("wrong");
      throw Exception('Failed to Update form');
    }



  }

}

  // static Future<int> checkPhone(String phoneNo) async {
  //   final checkPhoneUrl = Uri.parse('$url/phone/check');
  //   try {
  //     final response = await http.post(
  //         checkPhoneUrl, headers: {'Content-Type': 'application/json'},
  //         body: jsonEncode({'phoneNo': phoneNo}));
  //     if (response.statusCode == 400) {
  //       print('phone number already in use');
  //       return 1;
  //     } else {
  //       return 0;
  //     }
  //   }catch (e) {
  //     // Handle network or other errors
  //     print("error:$e");
  //     return 2;
  //   }
  // }
  //
  // static Future<int?> uploadUserImage(String? imagePath) async {
  //   final registerUrl = Uri.parse('$url/userupload');
  //
  //   try {
  //     // Read the image file as bytes
  //     List<int> imageBytes = await File(imagePath!).readAsBytes();
  //
  //     // Create a multipart request
  //     var request = http.MultipartRequest('POST', registerUrl);
  //
  //     // Attach the image file to the request
  //     request.files.add(http.MultipartFile.fromBytes('image', imageBytes, filename: 'user_image.jpg'));
  //
  //     // Send the request
  //     final response = await request.send();
  //
  //     // Check the response status
  //     if (response.statusCode == 200) {
  //       print("image uploded");
  //       Map<String, dynamic> jsonResponse = json.decode(await response.stream.bytesToString());
  //
  //       // Access the userImageId from the response
  //       int userImageId = jsonResponse['userImageId'];
  //       print(userImageId);
  //       return userImageId;
  //     } else {
  //       // Handle error response
  //       print("image failed to uplode");
  //       return null;
  //     }
  //   } catch (e) {
  //     // Handle network or other errors
  //     print("error:$e");
  //     return null;
  //   }
  // }

