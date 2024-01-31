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
              Icon(Icons.menu),
              Text("hello")

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
                  Text("ሰብሳቢ", style: GoogleFonts.notoSerifEthiopic(textStyle: TextStyle(
                    color: Color(0XFF909300),
                    fontSize: 30,
                  ))),

                  Row(
                    children: [
                      TextButton(onPressed: (){
                        Provider.of<MyModel>(context, listen: false).updateMessage("login");
                      }, child: Text("LogIn", style: GoogleFonts.poppins(textStyle: TextStyle(
                        color: Color(0XFF909300),

                      )))),
                      TextButton(onPressed: (){
                        Provider.of<MyModel>(context, listen: false).updateMessage("signup");
                      }, child: Text("SignUp", style: GoogleFonts.poppins(textStyle: TextStyle(
                        color: Color(0XFF909300),
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
