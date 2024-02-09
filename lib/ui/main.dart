import 'package:flutter/material.dart';
import 'package:sebsabi/provider/form_provider.dart';
import 'package:sebsabi/ui/home.dart';
import 'package:sebsabi/ui/landing.dart';
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
        debugShowCheckedModeBanner: false,
        title: 'ሰብሳቢ',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0XFF909300)),
          useMaterial3: true,
        ),
        home: const Home(),
      ),
    );
  }
}

