import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:sebsabi/form_provider.dart';
import 'package:sebsabi/signup.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MyModel()),
      ],
      child: MaterialApp(
        title: 'ሰብሳቢ',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Color(0XFF909300)),
          useMaterial3: true,
        ),
        home: SignUp(),
      ),
    );
  }
}

