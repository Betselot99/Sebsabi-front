

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'dart:html' as html;

import 'package:sebsabi/model/FormModel.dart';
import 'package:sebsabi/model/FormQuestion.dart';
import 'package:sebsabi/model/FormResponse.dart';

import '../model/Status.dart';

class FormApi{
  static const String url = 'http://localhost:8080/api/core/forms';

  static Future<int?> createForm(final String title,String description,int usageLimit, Status status ) async {
    final token=html.window.localStorage['auth_token'];
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token!);
    String clientUsername = decodedToken['sub'];
    final createFormUrl = Uri.parse('$url/create?clientUsername=$clientUsername');

    if (token == null) {
      throw Exception('Bearer token not found');
    }

    final response = await http.post(
        createFormUrl, headers: {'Content-Type': 'application/json','Authorization': 'Bearer $token',
     },
        body: jsonEncode(FormModel(title: title, description: description, usageLimit: usageLimit, status: status)));
    if (response.statusCode == 201) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      int id =responseBody['id'];
      return id;
    } else {
      print("wrong");
      throw Exception('Failed to create form');
    }



  }

  static Future<String?> addQuestionToForm(int? formID, String? questionText, String? questionType ) async{
    final addQuestionUrl = Uri.parse('$url/add/question-to-form?formID=$formID');
    final token=html.window.localStorage['auth_token'];
    if (token == null) {
      throw Exception('Bearer token not found');
    }
    final response = await http.post(
        addQuestionUrl, headers: {'Content-Type': 'application/json','Authorization': 'Bearer $token',
    },
        body: jsonEncode(FormQuestion(questionText: questionText, questionType: questionType)));
    if (response.statusCode == 200) {

    } else {
      throw Exception('Failed to add question to form');
    }

  }

  static Future<List<FormResponse>> fetchForms(Status status) async {

    final token=html.window.localStorage['auth_token'];
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token!);
    String clientEmail = decodedToken['sub'];
    final getFormUrl = Uri.parse('$url/view/form?clientEmail=$clientEmail&status=${status?.toString().split('.').last}');// Replace with your actual authorization token
    final response = await http.get(
      getFormUrl,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => FormResponse.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load forms');
    }
  }

  static Future<FormModel> getFormById(int formId) async {

    final token=html.window.localStorage['auth_token'];
    final getFormByIdUrl = Uri.parse('$url$formId');// Replace with your actual authorization token
    final response = await http.get(
      getFormByIdUrl,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      
      return FormModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load forms');
    }
  }


  static Future<List<FormQuestion>> getQuestions(int formId) async {
    final token=html.window.localStorage['auth_token'];
    final getQuestionUrl = Uri.parse('$url/view/questionOfForm?formID=$formId');
    final response = await http.get(
      getQuestionUrl,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((question) => FormQuestion.fromJson(question)).toList();
    } else {
      // Handle error
      print("Error: ${response.statusCode}");
      throw Exception('Failed to load questions');
    }
  }



}

