



import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'dart:html' as html;

import 'package:sebsabi/model/FormModel.dart';
import 'package:sebsabi/model/FormQuestion.dart';
import 'package:sebsabi/model/FormResponse.dart';

import '../model/MultipleChoiceOption.dart';
import '../model/Status.dart';

class FormApi{
  static const String url = 'http://localhost:8080';

  static Future<Map<String, dynamic>> updateForm(int formId, String? title,String? description,int? usageLimit, Status? status ) async {
    final token=html.window.localStorage['auth_token'];
    final updateFormUrl = Uri.parse('$url/api/core/client/view/form/update?formId=$formId');

    if (token == null) {
      throw Exception('Bearer token not found');
    }

    final response = await http.put(
        updateFormUrl, headers: {'Content-Type': 'application/json','Authorization': 'Bearer $token',
    },
        body: jsonEncode(FormModel(title: title!, description: description!, usageLimit: usageLimit!, status: status!)));
    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);

      return responseBody;
    } else {
      print(response.statusCode);
      throw Exception('Failed to Update form');
    }



  }

  static Future<int?> createForm(final String title,String description,int usageLimit, Status status ) async {
    final token=html.window.localStorage['auth_token'];
    final createFormUrl = Uri.parse('$url/api/core/client/create/form');

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

  static Future<String?> addQuestionToForm(int? formID, String? questionText, String? questionType, List<String?> multipleChoiceOption, int? ratingScale ) async {
    final addQuestionUrl = Uri.parse('$url/api/core/client/create/form/add/question-to-form?formID=$formID');
    final token = html.window.localStorage['auth_token'];

    if (token == null) {
      throw Exception('Bearer token not found');
    }

    // Create a list of MultipleChoiceOption from the optionText list


    // Create a FormQuestion object
    FormQuestion formQuestion = FormQuestion(
      questionText: questionText,
      questionType: questionType,
      multipleChoiceOptions: multipleChoiceOption,
      ratingScale: ratingScale,
    );

    // Convert FormQuestion to a list for the API
    List<FormQuestion> questionList = [formQuestion];

    // Send the request to the API
    final response = await http.post(
      addQuestionUrl,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(questionList),
    );

    if (response.statusCode == 200) {
      // Handle the success case
    } else {
      print(response.statusCode);
      throw Exception(response.body);
    }
  }


  static Future<List<Map<String, dynamic>>> fetchForms(Status status) async {

    final token=html.window.localStorage['auth_token'];

    final getFormUrl = Uri.parse('$url/api/core/client/view/form/status?status=${status?.toString().split('.').last}');// Replace with your actual authorization token
    final response = await http.get(
      getFormUrl,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.cast<Map<String, dynamic>>();
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



  static  Future<List<Map<String, dynamic>>> getProposalsByFormId(int formId) async {
    final token=html.window.localStorage['auth_token'];
    final getProposalUrl = Uri.parse('$url/api/core/client/view/form/proposal/$formId');
    final response = await http.get(
      getProposalUrl,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.cast<Map<String, dynamic>>();
    } else {
      // If the server did not return a 200 OK response,
      // throw an exception.
      throw Exception('Failed to load proposals');
    }
  }
 static Future<void> acceptProposal(int proposalId) async {
   final token=html.window.localStorage['auth_token'];
    final acceptProposalUrl = Uri.parse('$url/api/core/client/view/form/proposal/accept/$proposalId');
    try {
      final response = await http.post(
        acceptProposalUrl,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Adjust headers if needed
        },
      );

      if (response.statusCode == 200) {
        print('Proposal accepted successfully');
      } else {
        print('Failed to accept proposal. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error accepting proposal: $error');
    }
  }

  static Future<int> getClientJobStatus(int formId) async {
    final token=html.window.localStorage['auth_token'];
    final proggressUrl = Uri.parse('$url/api/core/client/view/form/status/claimed?formId=$formId');

    try {
      final response = await http.get(proggressUrl, headers: {
        'Authorization': 'Bearer $token', // Adjust headers if needed
      },);

      if (response.statusCode == 200) {
        // Assuming the response body contains an integer representing the job status
        return int.parse(response.body);
      } else if (response.statusCode == 403) {
        // Handle access denied
        throw Exception('Access Denied:token');
      } else {
        // Handle other errors
        throw Exception('Failed to get job status');
      }
    } catch (e) {
      // Handle exceptions
      throw Exception('Failed to connect to the server');
    }
  }

}





