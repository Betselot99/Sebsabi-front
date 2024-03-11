import 'package:flutter/material.dart';
import 'package:sebsabi/ui/admin/client_page.dart';
import 'package:sebsabi/ui/admin/site_analytics.dart';
import 'package:sebsabi/ui/admin/workers_page.dart';
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


class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {

  List<Widget> views = [
    Padding(
      padding: const EdgeInsets.only(top: 50, left: 100,right:100),
      child: ClientPage(),
    ),
    Padding(
      padding: const EdgeInsets.only(top: 50, left: 100,right:100),
      child: WorkerPage(),
    ),
    Padding(
      padding: const EdgeInsets.only(top: 50, left: 100,right:100),
      child: SiteAnalytics(),
    ),

  ];

  List<Widget> pages = [
    Padding(
      padding: const EdgeInsets.all(10.0),
      child: ClientPage(),
    ),
    Padding(
      padding: const EdgeInsets.all(10.0),
      child: WorkerPage(),
    ),
    Padding(
      padding: const EdgeInsets.all(10.0),
      child: SiteAnalytics(),
    ),
  ];
  int selectedIndex = 0;

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


  Widget MobileHome(context, w, h) {
    String textToShow;

    if (selectedIndex == 0) {
      textToShow = "Client List";
    } else if (selectedIndex == 1) {
      textToShow = "Workers List";
    } else if (selectedIndex == 2) {
      textToShow = "Site analytics";
    }else {
      textToShow = "Sebsabi";
    }

    return Scaffold(
      appBar: AppBar(
          title: Text(
              textToShow, style: GoogleFonts.poppins(textStyle: const TextStyle(
            color: Color(0XFF909300),
            fontSize: 30,
          ))),
          actions: [ TextButton(onPressed: () {
            html.window.localStorage.remove('auth_token');
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Landing()),
            );
          },
            child: Text("Log Out",
                style: GoogleFonts.poppins(textStyle: const TextStyle(
                  color: Color(0XFF909300),

                ))),
          ),
            const SizedBox(width: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MyNotification(),
            ),
          ]
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: const Text('Admin'),
              accountEmail: const Text('Admin@gmail.com'),
              currentAccountPicture: const CircleAvatar(
                child: Icon(
                  Icons.person,
                  size: 40.0,
                ),
              ),

              onDetailsPressed: () {
                // Handle the click on the header here

              },
            ),
            ListTile(
              title: const Text('Client List'),
              onTap: () {
                _selectPage(0);
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              title: const Text('Worker List'),
              onTap: () {
                _selectPage(1);
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              title: const Text('Site Analytics'),
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


  Widget DesktopHome(context, w, h) {
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
                  TextButton(onPressed: () {
                    html.window.localStorage.remove('auth_token');
                    Navigator.push(context, PageTransition(
                        type: PageTransitionType.leftToRight,
                        child: Landing()));
                  },
                    child: Text("Log Out",
                        style: GoogleFonts.poppins(textStyle: const TextStyle(
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
                    dividerTheme: const SideNavigationBarDividerTheme(
                        mainDividerThickness: 2,
                        showHeaderDivider: true,
                        showMainDivider: true,
                        showFooterDivider: true,
                        mainDividerColor: Color(0XFFEAEAEA)

                    )


                ),
                header: SideNavigationBarHeader(
                  image: const CircleAvatar(
                    backgroundImage: AssetImage("logo.png"),
                    backgroundColor: Colors.white,
                  ),
                  title: Text("Sebsabi",
                      style: GoogleFonts.poppins(textStyle: const TextStyle(
                        color: Color(0XFF909300),
                        fontSize: 30,
                      ))),
                  subtitle: Text(
                      'Admin Dashboard', style: GoogleFonts.poppins()),

                ),

                selectedIndex: selectedIndex,
                items: const [
                  SideNavigationBarItem(
                    icon: Icons.post_add_sharp,
                    label: 'Client List',
                  ),
                  SideNavigationBarItem(
                    icon: Icons.my_library_books_rounded,
                    label: 'Workers List',
                  ),
                  SideNavigationBarItem(
                    icon: Icons.fact_check,
                    label: 'Site Analytics',
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