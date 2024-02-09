import 'package:flutter/material.dart';
import 'package:sebsabi/ui/widgets/forms_card.dart';
import 'package:google_fonts/google_fonts.dart';






class PostedForms extends StatefulWidget {
  bool formAvailable=true;


  PostedForms({super.key});

  @override
  State<PostedForms> createState() => _PostedFormsState();
}

class _PostedFormsState extends State<PostedForms> {
  @override
  Widget build(BuildContext context) {
    return ListView(
        children: [

          if(widget.formAvailable == false)...[Text("You have not posted any forms yet.", style: GoogleFonts.poppins(textStyle: const TextStyle(
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
              if(widget.formAvailable == true)
                Wrap(
                  children: List.generate(
                    10, // Adjust the number of items as needed
                        (index) => const FormsCard(formStatus: "Posted"),
                  ),
                ),

            ],
          )

        ]
    );
  }
}