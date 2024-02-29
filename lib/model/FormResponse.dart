class ClientResponse {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String? companyName;
  final String? companyType;
  final String? occupation;

  ClientResponse({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    this.companyName,
    this.companyType,
    this.occupation,
  });

  factory ClientResponse.fromJson(Map<String, dynamic> json) {
    return ClientResponse(
      id: json['id'],
      firstName: json['firstName'] ?? "",
      lastName: json['lastName'] ?? "",
      email: json['email'] ?? "",
      password: json['password'] ?? "",
      companyName: json['companyName'],
      companyType: json['companyType'],
      occupation: json['occupation'],
    );
  }
}

class FormResponse {
  final int id;
  final String title;
  final String description;
  final int usageLimit;
  final String status;
  final ClientResponse client;

  FormResponse({
    required this.id,
    required this.title,
    required this.description,
    required this.usageLimit,
    required this.status,
    required this.client,
  });

  factory FormResponse.fromJson(Map<String, dynamic> json) {
    return FormResponse(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      usageLimit: json['usageLimit'],
      status: json['status'],
      client: ClientResponse.fromJson(json['client']),
    );
  }
}