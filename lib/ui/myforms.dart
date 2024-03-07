import 'package:flutter/material.dart';
import 'package:sebsabi/api/Form_Api.dart';
import 'package:sebsabi/model/FormResponse.dart';
import 'package:sebsabi/model/Status.dart';
import 'package:sebsabi/ui/createform.dart';
import 'package:sebsabi/ui/drafts.dart';
import 'package:sebsabi/ui/widgets/forms_card.dart';
import 'package:google_fonts/google_fonts.dart';






class MyForms extends StatefulWidget {



   MyForms({super.key});

  @override
  State<MyForms> createState() => _MyFormsState();
}

class _MyFormsState extends State<MyForms> {


  @override
  void initState() {
    super.initState();
    checkForForm();
  }

  late Future<List<Map<String, dynamic>>> forms;
  late bool formAvailable= false;
  late List<Map<String,dynamic>> formsList;


  Future<void> checkForForm() async {
    forms = FormApi.fetchForms(Status.Draft);
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

        if(formAvailable == false)...[Text("You have not created any forms yet. Create a new Form.", style: GoogleFonts.poppins(textStyle: const TextStyle(
          color:  Colors.black,
          fontSize: 20,
        ))),
          const SizedBox(height: 20),
        ]else...[Text("My Forms", style: GoogleFonts.poppins(textStyle: const TextStyle(
          color:  Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ))),
          const SizedBox(height: 20),],
        Wrap(
          children: [
             FormsCard(formStatus: "New",onTap: (){

               Navigator.push(
               context,
               MaterialPageRoute(
                 builder: (context) => const CreateForm(),
               ),
             );}, claimed: false, proposalNo: 0,),
            const SizedBox(width: 20),
            if(formAvailable == true)
              Wrap(
                children: List.generate(
                  formsList.length, // Adjust the number of items as needed
                      (index) =>  FormsCard(onTap: (){Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>  Drafts(formTitle: formsList[index]['title'], formDescription: formsList[index]['description'], usage: formsList[index]['usageLimit'],questions: formsList[index]['questions'], id: formsList[index]['id'],),
                        ),
                      );},formStatus:formsList[index]['status'], title: formsList[index]['title'], description: formsList[index]['description'], claimed: false, proposalNo: 0,),
                ),
              ),

          ],
        )

        ]
    );
  }
}
