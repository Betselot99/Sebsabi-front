import 'package:flutter/material.dart';
import 'package:sebsabi/ui/completedforms.dart';
import 'package:sebsabi/ui/landing.dart';
import 'package:sebsabi/ui/myforms.dart';
import 'package:sebsabi/ui/postedforms.dart';
import 'package:sebsabi/ui/profile.dart';
import 'package:sebsabi/ui/widgets/notification.dart';
import 'package:sebsabi/ui/widgets/notification_drawer.dart';
import 'package:side_navigation/side_navigation.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:html' as html;
import 'package:page_transition/page_transition.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<Widget> views =  [
    Padding(
      padding: const EdgeInsets.only(top: 50, left: 100),
      child: MyForms(),
    ),
    Padding(
      padding: const EdgeInsets.only(top: 50, left: 100),
      child: PostedForms(),
    ),
    Padding(
      padding: const EdgeInsets.only(top: 50, left: 100),
      child: CompletedForms(),
    ),
    const Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 50, left: 100),
        child: Profile(),
      ),
    ),
  ];

  List<Widget> pages =  [
    Padding(
      padding: const EdgeInsets.all(10.0),
      child: MyForms(),
    ),
    Padding(
      padding: const EdgeInsets.all(10.0),
      child: PostedForms(),
    ),
    Padding(
      padding: const EdgeInsets.all(10.0),
      child: CompletedForms(),
    ),
    const Center(
      child: Profile(),
    ),
  ];
  int selectedIndex= 0;

  void _selectPage(int index) {
    setState(() {
      selectedIndex = index;
    });
  }




  @override
  Widget build(BuildContext context) {
    var w = MediaQuery
        .of(context)
        .size
        .width;
    var h = MediaQuery
        .of(context)
        .size
        .width;
    return ScreenTypeLayout(
      mobile: MobileHome(context, w, h),
      desktop: DesktopHome(context, w, h),
    );
  }




  Widget MobileHome(context,w,h){
    String textToShow;

    if (selectedIndex == 0) {
      textToShow = "My Forms";
    } else if (selectedIndex==1) {
      textToShow = "Posted Forms";
    } else if (selectedIndex==2) {
      textToShow = "Completed Forms";
    } else if (selectedIndex==3){
      textToShow = "Profile";
    }else{
      textToShow = "Sebsabi";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(textToShow, style: GoogleFonts.poppins(textStyle: const TextStyle(
          color:  Color(0XFF909300),
          fontSize: 30,
        ))),
        actions: [ TextButton(onPressed: (){
          html.window.localStorage.remove('auth_token');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Landing()),
          );
        }, child: Text("Log Out", style: GoogleFonts.poppins(textStyle: const TextStyle(
          color: Color(0XFF909300),

        ))),
        ),
          const SizedBox(width:20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyNotification(),
          ),]
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: const Text('John Doe'),
              accountEmail: const Text('john.doe@example.com'),
              currentAccountPicture: const CircleAvatar(
                child: Icon(
                  Icons.person,
                  size: 40.0,
                ),
              ),

              onDetailsPressed: () {
                // Handle the click on the header here
                _selectPage(3);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('My Forms'),
              onTap: () {
                _selectPage(0);
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              title: const Text('Posted Forms'),
              onTap: () {
                _selectPage(1);
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              title: const Text('Completed Forms'),
              onTap: () {
                _selectPage(2);
                Navigator.pop(context); // Close the drawer
              },
            ),

          ],
        ),
      ),

      body: pages[selectedIndex],

    );
  }


    Widget DesktopHome(context,w,h){
    return Scaffold(
      backgroundColor: const Color(0XFFFAFBFF),
      endDrawer: NotificationDrawer(),
      drawerScrimColor: Colors.transparent,
      endDrawerEnableOpenDragGesture: false,
      body: Stack(
        children: [
          Positioned(
            right: 50,
            top: 20,
            child: Row(
              children: [
                TextButton(onPressed: (){
                  html.window.localStorage.remove('auth_token');
                  Navigator.push(context, PageTransition(type: PageTransitionType.leftToRight, child: Landing()));
                }, child: Text("Log Out", style: GoogleFonts.poppins(textStyle: const TextStyle(
                    color: Color(0XFF909300),

                ))),
                ),
                MyNotification(),
              ],
            )),
          Row(
            children: [
              SideNavigationBar(
                toggler: const SideBarToggler(
                ),
                theme: SideNavigationBarTheme(
                  backgroundColor: const Color(0XFFFFFFFF),
                  togglerTheme: const SideNavigationBarTogglerTheme(
                    expandIconColor: Color(0XFF909300),
                    shrinkIconColor: Color(0XFF909300)
                  ),
                  itemTheme: SideNavigationBarItemTheme(
                    selectedItemColor: const Color(0XFF909300),
                    labelTextStyle: GoogleFonts.poppins()
                  ),
                  dividerTheme:const SideNavigationBarDividerTheme(
                    mainDividerThickness: 2, showHeaderDivider: true, showMainDivider: true, showFooterDivider: true,mainDividerColor:Color(0XFFEAEAEA)

                  )


                ),
                header:  SideNavigationBarHeader(
                    image: const CircleAvatar(
                      backgroundImage: AssetImage("assets/logo.png"),
                      backgroundColor: Colors.white,
                    ),
                    title: Text("Sebsabi", style: GoogleFonts.poppins(textStyle: const TextStyle(
                      color:  Color(0XFF909300),
                      fontSize: 30,
                    ))),
                    subtitle: Text('Client Dashboard', style: GoogleFonts.poppins()),

                ),

                selectedIndex: selectedIndex,
                items:  const [
                  SideNavigationBarItem(
                    icon: Icons.post_add_sharp,
                    label: 'My Forms',
                  ),
                  SideNavigationBarItem(
                    icon: Icons.my_library_books_rounded,
                    label: 'Posted Forms',
                  ),
                  SideNavigationBarItem(
                    icon:Icons.fact_check,
                    label: 'Completed Forms',
                  ),
                  SideNavigationBarItem(
                    icon: Icons.person,
                    label: 'Profile',
                  ),
                ],
                onTap: (index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
              ),
              Expanded(
                child: views.elementAt(selectedIndex),
              )
            ],
          ),

        ],

      ),
    );
  }


}
