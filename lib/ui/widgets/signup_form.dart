import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sebsabi/ui/home.dart';


class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});


  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool ifCompany = false;

  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController companyTypeController = TextEditingController();
  TextEditingController occupationController = TextEditingController();

  bool _obscureText = true;
  String? _firstNameErrorText;
  String? _lastNameErrorText;
  String? _emailErrorText;
  String? _passwordErrorText;
  String? _confirmPasswordErrorText;
  String? _nameError;

  void _validateName(String value) {
    if (value.isEmpty) {
      setState(() {
        _nameError = 'This field is required';
      });
    } else {
      setState(() {
        _nameError = null;
      });
    }
  }

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

  void _validateConfirmPassword(String value) {
    if (value.isEmpty) {
      setState(() {
        _confirmPasswordErrorText = 'Confirm Password is required';
      });
    } else if (value != passwordController.text) {
      setState(() {
        _confirmPasswordErrorText = 'Passwords do not match';
      });
    } else {
      setState(() {
        _confirmPasswordErrorText = null;
      });
    }
  }

  bool isPasswordValid(String password) {
    // You can add more complex password validation if needed
    return password.isNotEmpty && password.length >= 6;
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


  void _validateFirstName(String value) {
    if (value.isEmpty) {
      setState(() {
        _firstNameErrorText = 'First name is required';
      });
    } else if (!isNameValid(value)) {
      setState(() {
        _firstNameErrorText = 'First name cannot contain numbers';
      });
    } else {
      setState(() {
        _firstNameErrorText = null;
      });
    }
  }
  void _validateLastName(String value) {
    if (value.isEmpty) {
      setState(() {
        _lastNameErrorText = 'Last name is required';
      });
    } else if (!isNameValid(value)) {
      setState(() {
        _lastNameErrorText = 'Last name cannot contain numbers';
      });
    } else {
      setState(() {
        _lastNameErrorText= null;
      });
    }
  }

  bool isNameValid(String name) {
    // Check if the first name is not empty and does not contain numbers
    return name.isNotEmpty && !RegExp(r'\d').hasMatch(name);
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }


  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Form is valid, proceed with your logic here
      // For this example, we will simply print the email
        if(ifCompany) {
          if (fnameController.text.isEmpty ||
              lnameController.text.isEmpty ||
              emailController.text.isEmpty ||
              passwordController.text.isEmpty ||
              confirmPasswordController.text.isEmpty ||
              companyTypeController.text.isEmpty ||
              companyNameController.text.isEmpty ||
              occupationController.text.isEmpty) {
            print('please fill out all forms');
          } else {
            print('First Name: ${fnameController.text}');
          }
        }else if(fnameController.text.isEmpty ||
              lnameController.text.isEmpty ||
              emailController.text.isEmpty ||
              passwordController.text.isEmpty ||
              confirmPasswordController.text.isEmpty){print('please fill out all forms');}
        else{
        print('First Name: ${fnameController.text}');
      }
    }
  }




  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h= MediaQuery.of(context).size.width;


    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      //crossAxisAlignment: CrossAxisAlignment.end,

      children:[
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text("Join Sebsabi as a Client", style: GoogleFonts.poppins(textStyle: const TextStyle(
            color: Color(0XFF909300),
            fontSize: 20,
          ))),
        ),
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
                  FittedBox(
                    fit:BoxFit.scaleDown,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Text("Here From a Company?",style: GoogleFonts.poppins(textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ))),
                        Checkbox(value: ifCompany, onChanged: (bool? ifCompanyvalue){
                          setState((){
                            ifCompany= ifCompanyvalue!;

                          });
                        })
                      ],
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right:20),
                    child: TextFormField(
                      controller: fnameController,
                      textAlignVertical: TextAlignVertical.bottom,
                      keyboardType: TextInputType.name,
                      style: const TextStyle(color: Colors.black),
                      decoration:  InputDecoration(
                        fillColor:  Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                          const BorderSide(width: 1, color: Colors.white), //<-- SEE HERE
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        hintText: 'First Name',
                        errorText: _firstNameErrorText,
                        focusedBorder:OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white, width: 1.0),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                      validator: (value) => _firstNameErrorText,
                      onChanged: _validateFirstName,
                    ),
                  ),

                  //last Name
                  const SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right:20),
                    child: TextFormField(
                      controller: lnameController,
                      textAlignVertical: TextAlignVertical.bottom,
                      keyboardType: TextInputType.name,
                      style: const TextStyle(color: Colors.black),
                      decoration:  InputDecoration(
                        fillColor:  Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                          const BorderSide(width: 1, color: Colors.white), //<-- SEE HERE
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        hintText: 'Last Name',
                        errorText: _lastNameErrorText,
                        focusedBorder:OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white, width: 1.0),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                      validator: (value) => _lastNameErrorText,
                      onChanged: _validateLastName,
                    ),
                  ),
                  //Email
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
                  //password
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

                  // confirm password
                  const SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right:20),
                    child: TextFormField(
                      obscureText: _obscureText,
                      controller: confirmPasswordController,
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
                        hintText: 'Confirm Password',
                        errorText: _confirmPasswordErrorText,
                        focusedBorder:OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white, width: 1.0),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                      validator: (value) => _confirmPasswordErrorText,
                      onChanged: _validateConfirmPassword,
                    ),
                  ),



                  if(ifCompany)...[
                    //company name
                    const SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right:20),
                      child: TextFormField(
                        controller: companyNameController,
                        textAlignVertical: TextAlignVertical.bottom,
                        keyboardType: TextInputType.name,
                        style: const TextStyle(color: Colors.black),
                        decoration:  InputDecoration(
                          fillColor:  Colors.white,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                            const BorderSide(width: 1, color: Colors.white), //<-- SEE HERE
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          hintText: 'Company Name',
                          errorText: _nameError,
                          focusedBorder:OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white, width: 1.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                        validator: (value) => _nameError,
                        onChanged: _validateName,
                      ),
                    ),
                    //company Type
                    const SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right:20),
                      child: TextFormField(
                        controller: companyTypeController,
                        textAlignVertical: TextAlignVertical.bottom,
                        keyboardType: TextInputType.name,
                        style: const TextStyle(color: Colors.black),
                        decoration:  InputDecoration(
                          fillColor:  Colors.white,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                            const BorderSide(width: 1, color: Colors.white), //<-- SEE HERE
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          hintText: 'Company Type',
                          errorText: _nameError,
                          focusedBorder:OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white, width: 1.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                        validator: (value) => _nameError,
                        onChanged: _validateName,
                      ),
                    ),
                    //Ocupation
                    const SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right:20),
                      child: TextFormField(
                        controller: occupationController,
                        textAlignVertical: TextAlignVertical.bottom,
                        keyboardType: TextInputType.name,
                        style: const TextStyle(color: Colors.black),
                        decoration:  InputDecoration(
                          fillColor:  Colors.white,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                            const BorderSide(width: 1, color: Colors.white), //<-- SEE HERE
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          hintText: 'Occupation',
                          errorText: _nameError,
                          focusedBorder:OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white, width: 1.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                        validator: (value) => _nameError,
                        onChanged: _validateName,
                      ),
                    ),
                  ],
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: (){_submitForm;  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const Home()));},
                    child: const Text('Sign Up'),
                  ),
                  const SizedBox(height: 16)
                ],
              ),
            )

        )
      ],
    );
  }




}
