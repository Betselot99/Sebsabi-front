class Client {
  String firstName;
  String lastName;
  String email;
  String password;
  String? companyName;
  String? companyType;
  int? occupation;
  Status? status;

  Client({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    this.companyName,
     this.companyType,
    this.occupation,
     this.status,
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      firstName: json['firstName'] ?? "",
      lastName: json['lastName'] ?? "",
      email: json['email'] ?? "",
      password: json['password'] ?? "",
      companyName: json['companyName'] ?? "",
      companyType: json['companyType'] ?? "",
      occupation: json['occupation'] ?? 0,
      status: json['status']?? Status.Active, // Change this based on your logic
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'companyName': companyName,
      'companyType': companyType,
      'occupation': occupation,
      'status': status, // Change this based on your logic
    };
  }
}

enum Status {
  Active,
  Inactive,
}
