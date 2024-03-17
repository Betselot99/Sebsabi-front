import 'package:flutter/material.dart';
import 'package:sebsabi/api/Client_Api.dart';
import 'package:sebsabi/ui/viewCompletedForms.dart';
import 'package:sebsabi/ui/widgets/forms_card.dart';
import 'package:google_fonts/google_fonts.dart';

import '../api/Form_Api.dart';
import '../model/FormResponse.dart';
import '../model/Status.dart';






class CompletedForms extends StatefulWidget {



  CompletedForms({super.key});

  @override
  State<CompletedForms> createState() => _CompletedFormsState();
}

class _CompletedFormsState extends State<CompletedForms> {
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    checkForForm();
  }

  late Future<List<Map<String, dynamic>>> forms;
  late bool formAvailable= false;
  late List<Map<String,dynamic>> formsList;



  Future<void> checkForForm() async {
    List<Status> statusesToFetch = [Status.Completed, Status.Paid];
    List<Map<String, dynamic>> allForms = [];

    for (Status status in statusesToFetch) {
      List<Map<String, dynamic>> forms = await FormApi.fetchForms(status);
      allForms.addAll(forms);
    }

    formsList = allForms;
    print(formsList);

    if (formsList.isEmpty) {
      setState(() {
        formAvailable = false;
      });
    } else {
      setState(() {
        formAvailable = true;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return ListView(
        children: [

          if(formAvailable == false)...[Text("There are no Completed Forms.", style: GoogleFonts.poppins(textStyle: const TextStyle(
            color:  Colors.black,
            fontSize: 20,
          ))),
            const SizedBox(height: 20),
          ]else...[Row(
            children: [
              Text("Completed Forms", style: GoogleFonts.poppins(textStyle: const TextStyle(
                color:  Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ))),
              IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  checkForForm();

                  print('Reload button pressed');
                },
                tooltip: 'Reload',
              )
            ],
          ),
            const SizedBox(height: 20),],
          Wrap(
            children: [

              const SizedBox(width: 20),
              if(formAvailable == true)
                Wrap(
                  children: List.generate(
                    formsList.length, // Adjust the number of items as needed
                        (index) =>  FormsCard(onTap: (){
                          if(formsList[index]['status'] =="Completed"){
                          FormApi.getPaymentInvoice(formsList[index]['id']).then((invoiceData) {
                            // Handle the invoice data here, such as showing it in a dialog
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Column(

                                    children: [
                                      CircleAvatar(
                                        radius: 30,
                                        backgroundImage: AssetImage('assets/logo.png'), // Placeholder image
                                        backgroundColor: Colors.transparent,
                                      ),
                                      Text('Payment Invoice'),
                                    ],
                                  ),
                                  content: Container(
                                    height: 150,
                                    child: Column(
                                        children: [
                                          Text('Amount: ${invoiceData['amount']} ETB',
                                              style: GoogleFonts.poppins()),
                                          Divider(),
                                          Text('Commission: ${invoiceData['commission']} ETB',
                                              style: GoogleFonts.poppins()),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.info_outline,
                                              color: Color(0XFF909300),
                                            ),
                                            SizedBox(width: 8.0),
                                            Text(
                                              'Note that Sebsabi takes a 10% commission from every transaction.',
                                                style: GoogleFonts.poppins(textStyle: const TextStyle(
                                                  color: Color(0XFF909300),
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500,
                                                )),
                                            ),
                                          ],
                                        ),
                                          Divider(),
                                          Text('Total Amount:${invoiceData['totalAmount']} ETB',style: GoogleFonts.poppins()),
                                          Divider(),
                                        ],
                                      ),
                                  ),

                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Close'),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        setState(() {
                                          isLoading=true;
                                        });

                                        var response= await FormApi.pay(formsList[index]['id']);
                                        if(response.isNotEmpty){
                                          setState(() {
                                            isLoading=false;
                                          });
                                          Navigator.of(context).pop();
                                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar( content: Text('Payment Completed.'),));
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>  ViewCompletedForm(formTitle: formsList[index]['title'], formDescription: formsList[index]['description'], usage: formsList[index]['usageLimit'],questions: formsList[index]['questions'], id: formsList[index]['id'], gigWorkerId: formsList[index]['assignedGigWorker']['id'],),
                                          ),
                                        );}else{
                                          setState(() {
                                            isLoading=false;
                                          });
                                          Navigator.of(context).pop();
                                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar( content: Text('Something went wrong. Please try again.'),));

                                        }

                                      },
                                      child: Text('Pay'),
                                    ),
                                  ],
                                );
                              },
                            );
                          }).catchError((error) {
                            // Handle errors or display error message
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Error'),
                                  content: Text('Failed to fetch payment invoice. Error: $error'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Close'),
                                    ),
                                  ],
                                );
                              },
                            );
                          });}else{
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>  ViewCompletedForm(formTitle: formsList[index]['title'], formDescription: formsList[index]['description'], usage: formsList[index]['usageLimit'],questions: formsList[index]['questions'], id: formsList[index]['id'], gigWorkerId: formsList[index]['assignedGigWorker']['id'],),
                              ),
                            );
                          }
                        }, formStatus:formsList[index]['status'], title: formsList[index]['title'], description: formsList[index]['description'], claimed: false, proposalNo: 0,),
                  ),
                ),

            ],
          )

        ]
    );
  }
}