import 'package:flutter/material.dart';

class NotificationDrawer extends StatelessWidget {
  const NotificationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child:Padding(
        padding:const EdgeInsets.fromLTRB(0.0, 85, 0.0, 0.0),
        child:Drawer(
          elevation: 0.0,
          backgroundColor: Colors.white70,
          child:Container(
            padding:const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withOpacity(0.3),
                    const Color(0XFF909300).withOpacity(1),

                  ],
                )
            ),
            child:Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: 15,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              child: Icon(
                                Icons.notifications,
                                size: 10,// Replace with your desired icon
                              ),
                              radius: 10,

                              backgroundColor: Colors.white,
                            ),
                            title: Text('Notification${[index]}'),
                            subtitle: Text('This is a Notification'),
                          ),
                          Divider(
                            height: 0.5, // Set the height of the divider
                            color: Colors.grey,
                          ),

                        ],

                      );
                    },
                  ),
                ),
              ],
            ),

          )
        )
      )
    );
  }
}
