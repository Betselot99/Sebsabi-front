import 'package:flutter/material.dart';
import 'package:sebsabi/ui/myforms.dart';
import 'package:sebsabi/ui/profile.dart';
import 'package:side_navigation/side_navigation.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:google_fonts/google_fonts.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<Widget> views = const [
    Center(
      child: MyForms(),
    ),
    Center(
      child: Text('posted Forms'),
    ),
    Center(
      child: Text('completed forms'),
    ),
    Center(
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


  Widget Notification(){
    return Stack(
      children: [
        IconButton(
          icon: Icon(Icons.notifications, color: Color(0XFF909300),size: 30,),
          onPressed: (){},
        ),
        Positioned(
          right: 0,
          top: 0,
          child: Container(
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(8),
            ),
            constraints: BoxConstraints(
              minWidth: 16,
              minHeight: 16,
            ),
            child: Text(
              '2',
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

  Widget MobileHome(context,w,h){
    return Scaffold(
      appBar: AppBar(
        title: Text("Sebsabi", style: GoogleFonts.poppins(textStyle: TextStyle(
          color:  Color(0XFF909300),
          fontSize: 30,
        ))),
        actions: [ Notification(),]
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('John Doe'),
              accountEmail: Text('john.doe@example.com'),
              currentAccountPicture: CircleAvatar(
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
              title: Text('My Forms'),
              onTap: () {
                _selectPage(0);
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              title: Text('Posted Forms'),
              onTap: () {
                _selectPage(1);
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              title: Text('Completed Forms'),
              onTap: () {
                _selectPage(2);
                Navigator.pop(context); // Close the drawer
              },
            ),

          ],
        ),
      ),
      body: views[selectedIndex],

    );
  }


    Widget DesktopHome(context,w,h){
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            right: 50,
            top: 20,
            child: Notification()),
          Row(
            children: [
              SideNavigationBar(
                toggler: SideBarToggler(
                ),
                theme: SideNavigationBarTheme(
                  togglerTheme: SideNavigationBarTogglerTheme(
                    expandIconColor: Color(0XFF909300),
                    shrinkIconColor: Color(0XFF909300)
                  ),
                  itemTheme: SideNavigationBarItemTheme(
                    selectedItemColor: Color(0XFF909300),
                    labelTextStyle: GoogleFonts.poppins()
                  ),
                  dividerTheme:SideNavigationBarDividerTheme.standard()


                ),
                header:  SideNavigationBarHeader(
                    image: const CircleAvatar(
                      backgroundImage: AssetImage("logo.png"),
                      backgroundColor: Colors.white,
                    ),
                    title: Text("Sebsabi", style: GoogleFonts.poppins(textStyle: TextStyle(
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
                child: true?views.elementAt(selectedIndex):const Text("profile"),
              )
            ],
          ),
        ],
      ),
    );
  }


}
