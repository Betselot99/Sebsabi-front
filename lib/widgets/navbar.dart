import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../form_provider.dart';


class NavBar extends StatefulWidget {

  const NavBar({super.key});


  @override
  State<NavBar> createState() => _NavBarState();



}

class _NavBarState extends State<NavBar> {
  FontWeight button = FontWeight.bold;
  FontWeight button1 = FontWeight.normal;
  @override
  Widget build(BuildContext context) {

    var w = MediaQuery.of(context).size.width;
    var h= MediaQuery.of(context).size.width;
    return ScreenTypeLayout(
      mobile:MobileNavBar(),
      desktop:DesktopNavBar(),


    );
  }

  Widget MobileNavBar(){

    return Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        height:70,
        child:Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:[
              Text("Sebsabi", style: GoogleFonts.poppins(textStyle: TextStyle(
                color: Color(0XFF909300),
                fontSize: 30,
              ))),


            ]
        )
    );
  }
  Widget DesktopNavBar(){
    return Material(
      elevation: 20,
      child: Container(

          //margin: EdgeInsets.symmetric(horizontal: 20, vertical:10),
          height:70,

          child:Padding(
            padding: const EdgeInsets.only(left:40, right: 70),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:[
                  Text("Sebsabi", style: GoogleFonts.poppins(textStyle: TextStyle(
                    color: Color(0XFF909300),
                    fontSize: 30,
                    fontWeight: FontWeight.w500
                  ))),

                  Row(
                    children: [
                      TextButton(onPressed: (){
                        Provider.of<MyModel>(context, listen: false).updateMessage("login");
                        setState(() {
                           // Change the color to red (or any other color you want)
                          button1 = FontWeight.bold;
                          button= FontWeight.normal;// Change the font weight when clicked
                        });
                      }, child: Text("LogIn", style: GoogleFonts.poppins(textStyle: TextStyle(
                        color: Color(0XFF909300),
                        fontWeight: button1
                      ))),
                      ),
                      TextButton(onPressed: (){
                        Provider.of<MyModel>(context, listen: false).updateMessage("signup");
                        setState(() {
                          // Change the color to red (or any other color you want)
                          button= FontWeight.bold;
                          button1 = FontWeight.normal; // Change the font weight when clicked
                        });

                      }, child: Text("SignUp", style: GoogleFonts.poppins(textStyle: TextStyle(
                        color: Color(0XFF909300),
                          fontWeight: button
                      ))))
                    ],
                  )

                ]
            ),
          )
      ),
    );
  }
}
