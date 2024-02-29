import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:sebsabi/api/Client_Api.dart';
import 'package:sebsabi/provider/form_provider.dart';
import 'package:sebsabi/ui/widgets/frontui.dart';
import 'package:sebsabi/ui/widgets/login_form.dart';
import 'package:sebsabi/ui/widgets/navbar.dart';
import 'package:provider/provider.dart';
import 'package:sebsabi/ui/widgets/signup_form.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart' show FaIcon, FontAwesomeIcons;
import 'package:google_fonts/google_fonts.dart';


import 'home.dart';


class Landing extends StatefulWidget {
  const Landing({super.key});

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
    ..addStatusListener((status) {
    if (status == AnimationStatus.completed) {
    _controller.reverse();
    } else if (status == AnimationStatus.dismissed) {
    _controller.forward();
    }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h= MediaQuery.of(context).size.width;
    return ScreenTypeLayout(
      mobile: MobileLanding(context,w,h),
      desktop: DesktopLanding(context,w,h),
    );
  }
  Widget MobileLanding(context,w,h){
    return Scaffold(
      body: Column(
        children: [
          const NavBar(),
          Expanded(
            child: ListView(
              children: [Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,

                  //crossAxisAlignment: CrossAxisAlignment.center,

                  children: [
                    SizedBox(
                        width: w*2,
                        height: h/3,child: const FrontUI()),
                    SizedBox(
                      width: w*2,

                      child: Padding(
                        padding: const EdgeInsets.only(left: 40, right:40),
                        child: Consumer<MyModel>(
                          builder:(context,myModel, child){
                            String status = myModel.message;
                            if(status=="login"){
                              return const LogInForm();
                            }else{
                              return const SignUpForm();
                            }

                          }
                        ),
                      ),
                    ),

                  ],
                ),
              ),]
            ),
          )
        ],
      ),
    );
  }
  Widget DesktopLanding(context,w,h){
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const NavBar(),
          Expanded(
            child: ListView(
                children: [Center(
                  child: Row(

                    children: [
                      Stack(
                        children: [
                          Positioned(
                            top: -h / 10,
                            left: -w / 4,
                            child: Container(
                              width: w / 3,
                              height: h / 3,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                  color: const Color(0XFF909300).withOpacity(0.5),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: -h / 3,
                            right: -w / 4,
                            child: Container(
                              width: w / 2,
                              height: h / 2,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                  color: const Color(0XFF909300).withOpacity(0.5),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: w/2,



                              child: const Padding(
                                padding: EdgeInsets.only(top: 200,),
                                child: FrontUI(),
                              )),
                        ],
                      ),
                      SizedBox(
                        width: w/2,

                        child: Padding(
                          padding: const EdgeInsets.only(top:120,right:120,left:120, bottom: 100),
                          child: Consumer<MyModel>(
                              builder:(context,myModel, child){
                                String status = myModel.message;
                                if(status=="login"){
                                  return const LogInForm();
                                }else{
                                  return const SignUpForm();
                                }

                              }
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
                  SizedBox(height:50),
                  Padding(
                    padding: const EdgeInsets.only(right:200, left:200,),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0XFF909300).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),

                      height:70,
                      child:Center(
                        child: Column(

                          children: [
                            Text("About Us",style: GoogleFonts.poppins(textStyle: const TextStyle(
                              color: Color(0XFF909300),
                              fontSize: 25,
                            ))),
                            Text("Welcome to Sebsabi, your trusted partner in data collection and survey solutions!",style: GoogleFonts.poppins(textStyle: const TextStyle(
                              fontSize: 13,
                            ))),
                          ],


                        ),
                      )
                    ),
                  ),
                  SizedBox(height:50),
                  Padding(
                    padding:  EdgeInsets.only(right:w/6, left:w/6),
                    child: Container(
                      height:300,
                      child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),

                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, // Number of columns in the grid
                          //crossAxisSpacing: 8.0, // Spacing between columns
                         // mainAxisSpacing: 8.0, // Spacing between rows
                        ),
                        itemCount: 3, // Number of items in the grid
                        itemBuilder: (context, index) {
                          if(index==0){
                          return Container(

                            decoration:
                            const BoxDecoration(border: Border(

                              right: BorderSide(width: 2.0, color: Color(0XFF909300)),

                            ),

                            ),
                            child: Column(

                              children: [
                                Icon(Icons.track_changes_outlined,size: 100,color: Color(0XFF909300),), // Replace with your desired icon
                                SizedBox(height: 8.0), // Adjust the space between icon and text
                                Text('Mission',style: GoogleFonts.poppins(textStyle: const TextStyle(
                                  color: Color(0XFF909300),
                                  fontSize: 23,
                                ))),
                                Padding(
                                  padding: const EdgeInsets.only(right:20),
                                  child: Text(textAlign: TextAlign.justify,'  We are dedicated to providing a seamless platform for clients to effortlessly conduct surveys and gather valuable insights while connecting with a network of skilled data collection professionals.',style: GoogleFonts.poppins(textStyle: const TextStyle(

                                    fontSize: 13,
                                  ))),
                                ),
                                // Replace with your text
                              ],
                            ),
                          );}else if(index==1){
                            return Container(
                              decoration:
                              const BoxDecoration(border: Border(

                                right: BorderSide(width: 2.0, color: Color(0XFF909300)),

                              ),

                              ),
                              child: Column(

                                children: [
                                  Icon(Icons.visibility_outlined,size: 100,color: Color(0XFF909300),), // Replace with your desired icon
                                  SizedBox(height: 8.0), // Adjust the space between icon and text
                                  Text('Vision',style: GoogleFonts.poppins(textStyle: const TextStyle(
                                    color: Color(0XFF909300),
                                    fontSize: 23,
                                  ))),
                                  Padding(
                                    padding: const EdgeInsets.only(left:20,right:20),
                                    child: Text(textAlign: TextAlign.justify,'  We aim to bridge the gap between clients seeking accurate information and skilled data collectors capable of delivering high-quality results.',style: GoogleFonts.poppins(textStyle: const TextStyle(

                                      fontSize: 13,
                                    ))),
                                  ), // Replace with your text
                                ],
                              ),
                            );
                          }else if(index==2){
                           return Container(
                              child: Column(

                                children: [
                                Icon(Icons.diamond_outlined,size: 100,color: Color(0XFF909300),), // Replace with your desired icon
                             SizedBox(height: 8.0), // Adjust the space between icon and text
                             Text('Value',style: GoogleFonts.poppins(textStyle: const TextStyle(
                               color: Color(0XFF909300),
                               fontSize: 23,
                             ))),
                             Padding(
                               padding: const EdgeInsets.only(left:10),
                               child: Text(textAlign: TextAlign.justify,'  Whether you${"'"}re conducting market research, academic surveys, or any other data collection endeavor, our platform accommodates various survey types to meet your specific needs.',style: GoogleFonts.poppins(textStyle: const TextStyle(

                                 fontSize: 13,
                               ))),
                             ), // Replace with your text
                                ],
                              ),
                            );

                          }

                        },
                      ),
                    ),
                  ),
                  SizedBox(height:50),
                  Column(
                    children: [
                      Text("Download our Worker-Side App!",style: GoogleFonts.poppins(textStyle: const TextStyle(
                        color: Color(0XFF909300),
                        fontSize: 25,
                      ))),
                      SizedBox(height:50),
                      Center(
                        child: AnimatedBuilder(
                          animation: _animation,
                          builder: (context, child) {
                            return Transform(
                              transform: Matrix4.identity()
                                ..setEntry(3, 2, 0.002) // Perspective
                                ..rotateY(3.141592653589793 * _animation.value), // Rotate around Y-axis
                              child: _animation.value < 0.5
                                  ? SizedBox(
                                height: h/4,
                                    width: w/4,
                                    child: Image.asset(
                                'assets/deviceone.png', // Replace with your first image
                                width: 200,
                                height: 200,
                              ),
                                  )
                                  : SizedBox(
                                height: h/4,
                                width: w/4,
                                    child: Image.asset(
                                'assets/devicetwo.png', // Replace with your second image
                                width: 200,
                                height: 200,
                              ),
                                  ),
                              alignment: FractionalOffset.center,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height:50),
                  Padding(
                    padding:  EdgeInsets.only(left:w/2.3, right:w/2.3),
                    child: Container(
                      height:60,
                      decoration: BoxDecoration(
                        color: Color(0XFF909300),
                        borderRadius: BorderRadius.circular(10),

                      ),


                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(FontAwesomeIcons.googlePlay,size: 24,color: Colors.white,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('GET IT ON',style: GoogleFonts.poppins(textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ))),
                              Text('Google Play',style: GoogleFonts.poppins(textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                              )))
                            ],
                          )

                        ],
                      )
                    ),
                  ),
                  SizedBox(height:50),
                  Container(
                      decoration: BoxDecoration(
                        color: Color(0XFF909300),

                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      width: w,
                      height:50,

                      child: Padding(
                        padding: const EdgeInsets.only(left:20, top: 10,right:10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("© 2024 Sebsabi Inc. All rights reserved.",style: GoogleFonts.poppins(textStyle: const TextStyle(
                              fontSize: 13,
                            ))),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            IconButton(
                              iconSize: 20,

                            icon: FaIcon(FontAwesomeIcons.instagram),
                          onPressed: () { print("Pressed"); }
                      ),
                                IconButton(
                                    iconSize: 20,
                                  // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                                    icon: FaIcon(FontAwesomeIcons.facebook),
                                    onPressed: () { print("Pressed"); }
                                ),
                                IconButton(
                                    iconSize: 20,

                                    icon: FaIcon(FontAwesomeIcons.linkedin),
                                    onPressed: () { print("Pressed"); }
                                ),
                              ],
                            )
                          ],
                        ),
                      )),
                ]
            ),
          ),


        ],
      ),
    );
  }

}

