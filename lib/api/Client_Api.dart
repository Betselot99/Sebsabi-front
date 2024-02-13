import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sebsabi/model/Client.dart';

class ClientApi{
  static const String url = 'http://10.0.2.2:3000/api/core';

  // static Future<Map<String, dynamic>> loginUser(String phoneNo, String password) async {
  //   final loginUrl = Uri.parse('$url/login');// Replace 'your_api_url_here' with your actual API endpoint
  //   final response = await http.post(
  //     loginUrl,
  //     headers: {'Content-Type': 'application/json'},
  //     body: jsonEncode({
  //       'phoneNo': phoneNo,
  //       'password': password,
  //     }),
  //   );
  //
  //   if (response.statusCode == 200) {
  //     // Successful login
  //     Map<String, dynamic> data = jsonDecode(response.body);
  //     //return {'success': true, 'data': data};
  //
  //     //Store user credentials locally
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     prefs.setString('accessToken', data['accessToken']);
  //     prefs.setInt('roleId', data['message']);
  //
  //     return {'success': true, 'data': data};
  //   } else {
  //     // Login failed
  //     Map<String, dynamic> error = jsonDecode(response.body);
  //     return {'success': false, 'error': error['error']};
  //   }
  // }

  // Future<bool> isLoggedIn() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getString('accessToken') != null;
  // }

  static Future<int> register(Client client) async {
    final registerUrl = Uri.parse('$url/signup/clients');
    final response = await http.post(registerUrl, headers: {'Content-Type': 'application/json'},body: jsonEncode(client.toJson()));
    if (response.statusCode == 201) {
      print('Api Data saved successfully');
      return 1;
    }else{return 0;}
  }

  static Future<String> loginClient(String username, String password) async {
    final loginUrl = Uri.parse('$url/login');
    final response = await http.post(
      loginUrl,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return data['token'];
    } else if (response.statusCode == 400) {
      throw Exception('Invalid credentials');
    } else {
      throw Exception('Failed to login');
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

