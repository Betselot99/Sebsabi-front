import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sebsabi/api/Client_Api.dart';
import 'package:sebsabi/ui/admin/admin_home.dart';
import 'package:sebsabi/ui/home.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'dart:html' as html;
import 'package:page_transition/page_transition.dart';

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
  void _submitForm() async{
    if (_formKey.currentState!.validate()) {

      if (
            emailController.text.isEmpty ||
            passwordController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar( content: Text('please fill in all fields'),));
        }
      else{
        try{
          final token = await ClientApi.loginClient(emailController.text, passwordController.text);
          Map<String, dynamic> decodedToken = JwtDecoder.decode(token!);
          bool hasExpired = JwtDecoder.isExpired(token);
          if (decodedToken.containsKey('sub') && !hasExpired) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('client is logged in'),));
            Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
            print(decodedToken['sub']);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Home()),
            );
          } else {
            // Token is invalid, handle accordingly (e.g., show an error)
            html.window.localStorage.remove('auth_token');
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar( content: Text('wrong password and email'),));
            print(token);
          }

        }catch(e){
          html.window.localStorage.remove('auth_token');
          print('Error: $e');
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar( content: Text('wrong password and email'),));
        }
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
      child: Text("Log in to Sebsabi", style: GoogleFonts.poppins(textStyle: const TextStyle(
        color: Color(0XFF909300),
        fontSize: 20,
      ))),
    ),
        const SizedBox(height: 20,),
    Container(

    decoration:  BoxDecoration(
    color: const Color(0XFF909300).withOpacity(0.1),
    borderRadius: const BorderRadius.all(Radius.circular(20)),),
      child: Form(
    key: _formKey,
    child: Column(
    //crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      const SizedBox(height: 20,),
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
      const SizedBox(height: 20,),
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
      TextButton(
        onPressed: null,
        child:  Text("Forgot password?", style: GoogleFonts.poppins(textStyle: const TextStyle(
            color: Color(0XFF909300),
            fontSize: 14,
            fontWeight: FontWeight.w500
        ))),
      ),
      const SizedBox(height: 16),
      ElevatedButton(
        onPressed:(){ Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft, child: AdminHome()));}, //_submitForm,
        child: const Text('Log In'),
      ),
      const SizedBox(height: 20,),

    ]))
    )

      ]);
  }
}
