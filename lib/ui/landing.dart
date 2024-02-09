import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:sebsabi/provider/form_provider.dart';
import 'package:sebsabi/ui/widgets/frontui.dart';
import 'package:sebsabi/ui/widgets/login_form.dart';
import 'package:sebsabi/ui/widgets/navbar.dart';
import 'package:provider/provider.dart';
import 'package:sebsabi/ui/widgets/signup_form.dart';


class Landing extends StatefulWidget {
  const Landing({super.key});

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
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
                        height: h/2,child: const FrontUI()),
                    SizedBox(
                      width: w*2,
                      height: h*2.5,
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
                      SizedBox(
                        width: w/2,
                          height:h,


                          child: const Padding(
                            padding: EdgeInsets.only(top: 200),
                            child: FrontUI(),
                          )),
                      SizedBox(
                        width: w/2,
                        height:h,
                        child: Padding(
                          padding: const EdgeInsets.all(120.0),
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

}

