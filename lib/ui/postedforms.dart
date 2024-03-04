import 'package:flutter/material.dart';
import 'package:sebsabi/ui/viewPostedForms.dart';
import 'package:sebsabi/ui/widgets/forms_card.dart';
import 'package:google_fonts/google_fonts.dart';

import '../api/Form_Api.dart';
import '../model/FormResponse.dart';
import '../model/Status.dart';






class PostedForms extends StatefulWidget {



  PostedForms({super.key});

  @override
  State<PostedForms> createState() => _PostedFormsState();
}

class _PostedFormsState extends State<PostedForms> {
  @override
  void initState() {
    super.initState();
    checkForForm();
  }

  late Future<List<Map<String, dynamic>>> forms;
  late bool formAvailable= false;
  late List<Map<String,dynamic>> formsList;


  Future<void> checkForForm() async {
    forms = FormApi.fetchForms(Status.Posted);
    //print(forms);
    formsList = await forms;
    for (var form in formsList) {
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
  }
  @override
  Widget build(BuildContext context) {
    return ListView(
        children: [

          if(formAvailable == false)...[Text("You have not posted any forms yet.", style: GoogleFonts.poppins(textStyle: const TextStyle(
            color:  Colors.black,
            fontSize: 20,
          ))),
            const SizedBox(height: 20),
          ]else...[Text("Posted Forms", style: GoogleFonts.poppins(textStyle: const TextStyle(
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
                        (index) =>  FormsCard(onTap: (){Navigator.push(
                            context,
                            MaterialPageRoute(
                            builder: (context) =>ViewPostedForms(formTitle: formsList[index]['title'], formDescription: formsList[index]['description'], usage: formsList[index]['usageLimit'], id: formsList[index]['id'], claimed: formsList[index]['assignedGigWorker']==null?false:true, assignedGigWorkerId: formsList[index]['assignedGigWorker']['id'], assignedGigWorkername: '${formsList[index]['assignedGigWorker']['firstName']} ${formsList[index]['assignedGigWorker']['lastName']}',)));}, formStatus:formsList[index]['status'].toString(), title: formsList[index]['title'], description: formsList[index]['description'], claimed:formsList[index]['assignedGigWorker']==null?false:true, proposalNo: formsList[index]['proposals'].length,),
                  ),
                ),

            ],
          )

        ]
    );
  }
}