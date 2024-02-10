import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sebsabi/ui/home.dart';
import 'package:sebsabi/ui/widgets/notification.dart';


class PagesNavBar extends StatefulWidget {

  const PagesNavBar({super.key});


  @override
  State<PagesNavBar> createState() => _PagesNavBarState();



}

class _PagesNavBarState extends State<PagesNavBar> {

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
        margin: const EdgeInsets.symmetric(horizontal: 20),
        height:70,
        child:Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:[
              Text("Sebsabi", style: GoogleFonts.poppins(textStyle: const TextStyle(
                color: Color(0XFF909300),
                fontSize: 30,
              ))),
              Row(
                children: [
                  IconButton(onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Home(),
                      ),
                    );
                  }, icon: Icon(Icons.home)
                  ),
                  MyNotification()
                ],
              )


            ]
        )
    );
  }
  Widget DesktopNavBar(){
    return Material(
      elevation: 20,
      child: SizedBox(

        //margin: EdgeInsets.symmetric(horizontal: 20, vertical:10),
          height:70,

          child:Padding(
            padding: const EdgeInsets.only(left:40, right: 70),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:[
                  Text("Sebsabi", style: GoogleFonts.poppins(textStyle: const TextStyle(
                      color: Color(0XFF909300),
                      fontSize: 30,
                      fontWeight: FontWeight.w500
                  ))),

                  Row(
                    children: [
                      TextButton(onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Home(),
                          ),
                        );
                      }, child: Text("Home", style: GoogleFonts.poppins(textStyle: TextStyle(
                          color: const Color(0XFF909300),
                      ))),
                      ),
                      MyNotification()
                    ],
                  )

                ]
            ),
          )
      ),
    );
  }
}