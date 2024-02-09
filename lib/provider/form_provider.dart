import 'package:flutter/material.dart';

class MyModel extends ChangeNotifier {
  String _message = "signup";

  String get message => _message;

  void updateMessage(String newMessage) {
    _message = newMessage;
    notifyListeners();
  }
}