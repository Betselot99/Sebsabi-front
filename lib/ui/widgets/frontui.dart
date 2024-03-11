import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class FrontUI extends StatelessWidget {
  const FrontUI({super.key});


  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h= MediaQuery.of(context).size.width;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,

      children:[

        CircleAvatar(
          radius: w/12,
          backgroundImage:const AssetImage('logo.png'),
          backgroundColor: Colors.white,
        ),
        Text("Sebsabi", style: GoogleFonts.poppins(textStyle: TextStyle(
          color: const Color(0XFF909300),
          fontSize: w/16,
        ))),



      ],
    );
  }



}
