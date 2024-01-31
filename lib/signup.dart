import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:sebsabi/form_provider.dart';
import 'package:sebsabi/widgets/landing.dart';
import 'package:sebsabi/widgets/navbar.dart';
import 'package:provider/provider.dart';


class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                NavBar(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Landing(),
                    Consumer<MyModel>(
                      builder:(context,myModel, child){
                        String status = myModel.message;
                        if(status=="login"){
                          return Text("login form");
                        }else{
                          return Text("sign up");
                        }

                      }
                    ),

                  ],
                )
              ],
            )

          )),
    );
  }
}

