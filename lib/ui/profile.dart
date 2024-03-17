import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sebsabi/api/Client_Api.dart';

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
  TextEditingController passwordController = TextEditingController();
  late Future<num> balance;
  @override
  void initState() {
    super.initState();
    checkForProfile();
  }
  late Future<Map<String, dynamic>> forms;
  late bool formAvailable= false;
  late Map<String,dynamic> formsList;




  Future<void> checkForProfile() async {
    forms = ClientApi.getClientById();
    //print(forms);
    formsList = await forms;
    setState(() {
      fnameController.text=formsList['firstName'];
      lnameController.text =formsList['lastName'];
      emailController.text=formsList['email'];
      companyNameController.text=formsList['companyName'];
      companyTypeController.text=formsList['companyType'];
      occupationController.text=formsList['occupation'];
    });

  }
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
                          minLines: 1,
                          maxLines: 1,
                          keyboardType: TextInputType.multiline,
                          style: const TextStyle(color: Colors.black),
                          readOnly: true, // Set this to make it uneditable
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(width: 1, color: Colors.white),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            hintText: 'Email',
                            focusedBorder: OutlineInputBorder(
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
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Enter New Password'),
                              content: TextField(
                                controller: passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: 'New Password',
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    // Close the dialog and do something with the entered password
                                    Navigator.of(context).pop(passwordController.text);
                                  },
                                  child: Text('Save'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    // Close the dialog without saving
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Cancel'),
                                ),
                              ],
                            );
                          },
                        );
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
                            onPressed: ()async{
                              final clientRequest={
                                'firstName':fnameController.text,
                                'lastName':lnameController.text,
                                'companyName':companyNameController.text,
                                'companyType':companyTypeController.text,
                                'occupation':occupationController.text,
                                'password':passwordController.text==null? formsList['password']:passwordController.text,
                              };
                              try{
                                ClientApi.UpdateClient(clientRequest);
                              }catch(e){
                                print(e);
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                  content: Text('Something seems to be wrong, try again.'),));
                              }finally{
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                  content: Text('Profile has been updated'),));
                                setState(() {
                                  //initState();
                                });
                              }
                            },
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
        SizedBox(height: 50),
        Text("Your Walet", style: GoogleFonts.poppins(textStyle: const TextStyle(
          color:  Color(0XFF909300),
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ))),
        Text("Manage payments and financial resources.", style: GoogleFonts.poppins(textStyle: const TextStyle(
          color:  Colors.black,
          fontSize: 13,
        ))),
        SizedBox(height: 50),
      ],
    );
  }
  Widget buildCard(String title, Future<num> data) {
    return Card(
      clipBehavior: Clip.hardEdge,
      surfaceTintColor: Colors.white,
      color: Colors.white,
      elevation: 5.0,

      margin: EdgeInsets.all(16.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
                title,
                style: GoogleFonts.poppins(textStyle: const TextStyle(
                  color:  Color(0XFFC8C8C8),
                  fontSize: 15,
                ),)),
            SizedBox(height: 8.0),
            FutureBuilder<num>(
              future: data,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                } else {
                  return Text(
                    title=='Balance'?"${snapshot.data} ETB":"${snapshot.data}",
                    style: GoogleFonts.poppins(textStyle: const TextStyle(
                      color:   Color(0XFF909300),
                      fontSize: 18,
                    ),),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
