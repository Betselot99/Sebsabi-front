import 'package:flutter/material.dart';
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
  @override
  void initState() {
    super.initState();
    checkForForm();
  }

  late Future<List<FormResponse>> forms;
  late bool formAvailable= false;
  late List<FormResponse> formsList;


  Future<void> checkForForm() async {
    //forms = FormApi.fetchForms(Status.Completed);
    //print(forms);
    formsList = await forms;
    for (var form in formsList) {
      print("Form ID: ${form.id}");
      print("Title: ${form.title}");
      print("Description: ${form.description}");
      print("Usage Limit: ${form.usageLimit}");
      print("Status: ${form.status}");}
    if (formsList.isEmpty) {
      setState(() {
        formAvailable=false;
      });

    }else{
      setState(() {
        formAvailable=true;
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
          ]else...[Text("Completed Forms", style: GoogleFonts.poppins(textStyle: const TextStyle(
            color:  Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ))),
            const SizedBox(height: 20),],
          Wrap(
            children: [

              const SizedBox(width: 20),
              if(formAvailable == true)
                Wrap(
                  children: List.generate(
                    formsList.length, // Adjust the number of items as needed
                        (index) =>  FormsCard(formStatus:formsList[index].status.toString(), title: formsList[index].title, description: formsList[index].description, claimed: false, proposalNo: 0,),
                  ),
                ),

            ],
          )

        ]
    );
  }
}