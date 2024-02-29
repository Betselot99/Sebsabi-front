import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController companyTypeController = TextEditingController();
  TextEditingController occupationController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Text("My Profile", style: GoogleFonts.poppins(textStyle: const TextStyle(
          color:  Color(0XFF909300),
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ))),
        Text("Set Your name and other public-facing Information.", style: GoogleFonts.poppins(textStyle: const TextStyle(
          color:  Colors.black,
          fontSize: 13,
        ))),
        SizedBox(height:20),
        Padding(
          padding: const EdgeInsets.only(right:200),
          child: Card(
              child:ClipPath(
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Color(0XFF909300), width: 10),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(right:100,left:100),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20,),
                        Text("First Name", style: GoogleFonts.poppins(textStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w500
                        ))),
                        TextFormField(
                          controller: fnameController,
                          textAlignVertical: TextAlignVertical.bottom,
                          minLines: 1, // Set this
                          maxLines: 1, // and this
                          keyboardType: TextInputType.multiline,
                          style: const TextStyle(color: Colors.black),
                          decoration:  InputDecoration(
                            fillColor:  Colors.white,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                              const BorderSide(width: 1, color: Colors.white), //<-- SEE HERE
                              borderRadius: BorderRadius.circular(0.0),
                            ),
                            hintText: 'First Name',

                            focusedBorder:OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white, width: 1.0),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                          ),

                        ),
                        const SizedBox(height: 20,),
                        Text("Last Name", style: GoogleFonts.poppins(textStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w500
                        ))),
                        TextFormField(
                          controller: lnameController,
                          textAlignVertical: TextAlignVertical.bottom,
                          minLines: 1, // Set this
                          maxLines: 1, // and this
                          keyboardType: TextInputType.multiline,
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

                            focusedBorder:OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white, width: 1.0),

                            ),
                          ),


                        ),
                        const SizedBox(height: 20,),
                        Text("Email", style: GoogleFonts.poppins(textStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w500
                        ))),
                        TextFormField(
                          controller: emailController,
                          textAlignVertical: TextAlignVertical.bottom,
                          minLines: 1, // Set this
                          maxLines: 1, // and this
                          keyboardType: TextInputType.multiline,
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

                            focusedBorder:OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white, width: 1.0),

                            ),
                          ),
                        ),
                        const SizedBox(height: 20,),
                        Text("Company name", style: GoogleFonts.poppins(textStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w500
                        ))),
                        TextFormField(
                          controller: companyNameController,
                          textAlignVertical: TextAlignVertical.bottom,
                          minLines: 1, // Set this
                          maxLines: 1, // and this
                          keyboardType: TextInputType.multiline,
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

                            focusedBorder:OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white, width: 1.0),

                            ),
                          ),
                        ),
                        const SizedBox(height: 20,),
                        Text("Company Type", style: GoogleFonts.poppins(textStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w500
                        ))),
                        TextFormField(
                          controller: companyTypeController,
                          textAlignVertical: TextAlignVertical.bottom,
                          minLines: 1, // Set this
                          maxLines: 1, // and this
                          keyboardType: TextInputType.multiline,
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

                            focusedBorder:OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white, width: 1.0),

                            ),
                          ),
                        ),
                        const SizedBox(height: 20,),
                        Text("Occupation", style: GoogleFonts.poppins(textStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w500
                        ))),
                        TextFormField(
                          controller: occupationController,
                          textAlignVertical: TextAlignVertical.bottom,
                          minLines: 1, // Set this
                          maxLines: 1, // and this
                          keyboardType: TextInputType.multiline,
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

                            focusedBorder:OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white, width: 1.0),

                            ),
                          ),
                        ),
                        const SizedBox(height: 20,),
                    TextButton(
                      onPressed: () {
                        print('TextButton pressed!');
                      },
                      child: Row(
                        children: [
                          Text("Reset Password ", style: GoogleFonts.poppins(textStyle: const TextStyle(
                              color: Color(0XFF909300),
                              fontSize: 15,
                              fontWeight: FontWeight.w500
                          ))),
                          Icon(
                            Icons.info_outline,
                            color: Color(0XFF909300), // Set your desired color
                            size: 15.0, // Set your desired size
                          ),
                        ],
                      ),),
                        SizedBox(height:20),

                        Center(
                          child: ElevatedButton(
                            onPressed: ()async{},
                            child: const Text('Save changes'),
                          ),
                        ),
                        SizedBox(height:20)

                      ],
                    ),
                  ),
                ),
              )
          ),
        ),
      ],
    );
  }
}
