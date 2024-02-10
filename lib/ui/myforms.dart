import 'package:flutter/material.dart';
import 'package:sebsabi/ui/createform.dart';
import 'package:sebsabi/ui/widgets/forms_card.dart';
import 'package:google_fonts/google_fonts.dart';






class MyForms extends StatefulWidget {
   bool formAvailable=false;


   MyForms({super.key});

  @override
  State<MyForms> createState() => _MyFormsState();
}

class _MyFormsState extends State<MyForms> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [

        if(widget.formAvailable == false)...[Text("You have not created any forms yet. Create a new Form.", style: GoogleFonts.poppins(textStyle: const TextStyle(
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
             FormsCard(formStatus: "New",onTap: (){Navigator.push(
               context,
               MaterialPageRoute(
                 builder: (context) => CreateForm(),
               ),
             );},),
            const SizedBox(width: 20),
            if(widget.formAvailable == true)
              Wrap(
                children: List.generate(
                  10, // Adjust the number of items as needed
                      (index) => const FormsCard(formStatus: "Draft"),
                ),
              ),

          ],
        )

        ]
    );
  }
}
