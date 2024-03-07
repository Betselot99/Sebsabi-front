import 'package:flutter/material.dart';
import 'package:sebsabi/provider/Client_provider.dart';
import 'package:sebsabi/provider/form_provider.dart';
import 'package:provider/provider.dart';
import 'package:sebsabi/ui/admin/admin_home.dart';
import 'package:sebsabi/ui/home.dart';
import 'package:sebsabi/ui/landing.dart';

import 'api/Client_Api.dart';
import 'package:jwt_decoder/jwt_decoder.dart';


void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {

   MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final storedToken = ClientApi.getTokenFromLocalStorage();
    bool hasExpired = false;
    String ifAdmin='';

    if (storedToken != null) {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(storedToken);
      ifAdmin=decodedToken['sub'];
      hasExpired = JwtDecoder.isExpired(storedToken);
    }
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MyModel()),
        ChangeNotifierProvider(create: (_) => ClientProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Sebsabi',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0XFF909300)),
          useMaterial3: true,
        ),
        home: storedToken != null && !hasExpired ? ifAdmin=='admin'?AdminHome():Home() : Landing(),
      ),
    );
  }
}

