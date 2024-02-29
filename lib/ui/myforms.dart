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

  late Future<List<FormResponse>> forms;
  late bool formAvailable= false;
  late List<FormResponse> formsList;


  Future<void> checkForForm() async {
    forms = FormApi.fetchForms(Status.Draft);
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
             );}),
            const SizedBox(width: 20),
            if(formAvailable == true)
              Wrap(
                children: List.generate(
                  formsList.length, // Adjust the number of items as needed
                      (index) =>  FormsCard(onTap: (){Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>  Drafts(formTitle: formsList[index].title, formDescription: formsList[index].description, usage: formsList[index].usageLimit, id: formsList[index].id,),
                        ),
                      );},formStatus:formsList[index].status.toString(), title: formsList[index].title, description: formsList[index].description,),
                ),
              ),

          ],
        )

        ]
    );
  }
}
