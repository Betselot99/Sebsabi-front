import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:google_fonts/google_fonts.dart';


class LogInForm extends StatefulWidget {
  const LogInForm({super.key});

  @override
  State<LogInForm> createState() => _LogInFormState();



}

class _LogInFormState extends State<LogInForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;
  String? _emailErrorText;
  String? _passwordErrorText;

  void _validatePassword(String value) {
    if (value.isEmpty) {
      setState(() {
        _passwordErrorText = 'Password is required';
      });
    } else if (value.length < 6) {
      setState(() {
        _passwordErrorText = 'Password must be at least 6 characters long';
      });
    } else {
      setState(() {
        _passwordErrorText = null;
      });
    }
  }
  void _validateEmail(String value) {
    if (value.isEmpty) {
      setState(() {
        _emailErrorText = 'Email is required';
      });
    } else if (!isEmailValid(value)) {
      setState(() {
        _emailErrorText = 'Enter a valid email address';
      });
    } else {
      setState(() {
        _emailErrorText = null;
      });
    }
  }
  bool isEmailValid(String email) {
    // Basic email validation using regex
    // You can implement more complex validation if needed
    return RegExp(r'^[\w-\.]+@[a-zA-Z]+\.[a-zA-Z]{2,}$').hasMatch(email);
  }
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  void _submitForm() {
    if (_formKey.currentState!.validate()) {

      if (
            emailController.text.isEmpty ||
            passwordController.text.isEmpty) {
          print('please fill out all forms');
        }
      else{
        print('email: ${emailController.text}');
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      //crossAxisAlignment: CrossAxisAlignment.end,

      children:[
      FittedBox(
      fit: BoxFit.scaleDown,
      child: Text("Log in to Sebsabi", style: GoogleFonts.poppins(textStyle: TextStyle(
        color: Color(0XFF909300),
        fontSize: 20,
      ))),
    ),
        SizedBox(height: 20,),
    Container(

    decoration:  BoxDecoration(
    color: Color(0XFF909300).withOpacity(0.1),
    borderRadius: BorderRadius.all(Radius.circular(20)),),
      child: Form(
    key: _formKey,
    child: Column(
    //crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      SizedBox(height: 20,),
      Padding(
        padding: const EdgeInsets.only(left: 20, right:20),
        child: TextFormField(
          controller: emailController,
          textAlignVertical: TextAlignVertical.bottom,
          keyboardType: TextInputType.emailAddress,
          style: const TextStyle(color: Colors.black),
          decoration:  InputDecoration(
            fillColor:  Colors.white,
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderSide:
              const BorderSide(width: 1, color: Colors.white), //<-- SEE HERE
              borderRadius: BorderRadius.circular(10.0),
            ),
            hintText: 'Email',
            errorText: _emailErrorText,
            focusedBorder:OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white, width: 1.0),
              borderRadius: BorderRadius.circular(25.0),
            ),
          ),
          validator: (value) => _emailErrorText,
          onChanged: _validateEmail,
        ),
      ),
      SizedBox(height: 20,),
      Padding(
        padding: const EdgeInsets.only(left: 20, right:20),
        child: TextFormField(
          obscureText: _obscureText,
          controller: passwordController,
          textAlignVertical: TextAlignVertical.bottom,
          style: const TextStyle(color: Colors.black),
          decoration:  InputDecoration(
            suffixIcon: IconButton(
              icon:_obscureText ? const Icon(Icons.visibility): const Icon(Icons.visibility_off),
              onPressed: _toggle,
            ),
            fillColor:  Colors.white,
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderSide:
              const BorderSide(width: 1, color: Colors.white), //<-- SEE HERE
              borderRadius: BorderRadius.circular(10.0),
            ),
            hintText: 'Password',
            errorText: _passwordErrorText,
            focusedBorder:OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white, width: 1.0),
              borderRadius: BorderRadius.circular(25.0),
            ),
          ),
          validator: (value) => _passwordErrorText,
          onChanged: _validatePassword,
        ),
      ),
      SizedBox(height: 16),
      ElevatedButton(
        onPressed: _submitForm,
        child: Text('Log In'),
      ),
      SizedBox(height: 20,),

    ]))
    )

      ]);
  }
}
