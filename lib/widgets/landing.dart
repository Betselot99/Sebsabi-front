import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:google_fonts/google_fonts.dart';


class Landing extends StatelessWidget {
  const Landing({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h= MediaQuery.of(context).size.width;
    return ScreenTypeLayout(
      mobile:MobileLanding(),
      desktop:DesktopLanding(),
    );
  }

  Widget MobileLanding(){
    return Container();
  }
  Widget DesktopLanding(){
    return Container(
      child: Stack(

        children:[
          Positioned(
            top:40,
            child: CircleAvatar(
                radius: 90,
                backgroundColor: Colors.white,

              ),),
          Text("Hello")


        ],
      ),
    );
  }
}
