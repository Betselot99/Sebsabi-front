class ClientAuthRequest {
  final String username;
  final String password;

  ClientAuthRequest({required this.username, required this.password});

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }
}