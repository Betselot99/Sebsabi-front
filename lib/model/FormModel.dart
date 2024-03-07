import 'package:sebsabi/model/Status.dart';

class FormModel {
   String title;
   String description;
   int usageLimit;
   Status status;



  FormModel({
    required this.title,
    required this.description,
    required this.usageLimit,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'usageLimit': usageLimit,
      'status': status?.toString().split('.').last
    };
  }

  factory FormModel.fromJson(Map<String, dynamic> json) {
    return FormModel(title:json['title'] ?? "" , description: json['description'] ?? "", usageLimit: json['usageLimit'], status:json['status'] ?? Status.Active,);
  }
}
