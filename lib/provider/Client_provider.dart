

import 'package:flutter/cupertino.dart';
import 'package:sebsabi/api/Client_Api.dart';
import 'package:sebsabi/model/Client.dart';


class UserProvider extends ChangeNotifier{
  bool loading = false;
  Future<int> RegisterUser(String firstName,String lastName,String email,String password,String? companyName,String? companyType,int? occupation,Status? status) async {
    loading = true;
    notifyListeners();

    try {
      Client client = Client(firstName: firstName, lastName: lastName, email: email, password: password,companyName:companyName,companyType: companyType,occupation:occupation,status:status);
      var registered = await ClientApi.register(client);
      if(registered == 1){
        print("Data saved successfully");
        return 1;
      }else{
        return 0;
      }
    } catch (e) {
      print("Failed to send data: $e");
      return 0;
    }

    loading = false;
    notifyListeners();
  }
}