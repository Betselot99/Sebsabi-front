import 'package:flutter/material.dart';
import 'package:sebsabi/api/Form_Api.dart';
import 'package:sebsabi/model/Status.dart';
import 'package:sebsabi/ui/widgets/description_card.dart';
import 'package:sebsabi/ui/widgets/pagesnavbar.dart';
import 'package:sebsabi/ui/widgets/question_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sebsabi/ui/widgets/updateDescription_card.dart';
import 'package:sebsabi/ui/widgets/updateQuestion_card.dart';

import '../model/FormQuestion.dart';

class ViewPostedForms extends StatefulWidget {
  final int id;
  final String formTitle;
  final String formDescription;
  final int usage;
  const ViewPostedForms({super.key, required this.formTitle, required this.formDescription, required this.usage, required this.id});

  @override
  State<ViewPostedForms> createState() => _ViewPostedFormsState();
}

class _ViewPostedFormsState extends State<ViewPostedForms> {
  static const int numItems = 20;
  List<bool> selected = List<bool>.generate(numItems, (int index) => false);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h= MediaQuery.of(context).size.width;
    return  Scaffold(
      body: Column(
          children:[
            const PagesNavBar(),
            Expanded(
              child: Padding(
                padding:  EdgeInsets.fromLTRB(w/6, 20, w/6, 20),
                child: ListView(
                  children: [
                    Text("Posted Form", style: GoogleFonts.poppins(textStyle: const TextStyle(
                      color: Color(0XFF909300),
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                    ))),
                    SizedBox(height: 50,),

                    Container(

                        decoration: BoxDecoration(
                          color: Color(0XFFFFFBEE), // Cream color
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Title:", style: GoogleFonts.poppins(textStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ))),
                              Text(widget.formTitle),
                            ],
                          ),
                        )),
                    SizedBox(height: 20,),
                    Container(

                        decoration: BoxDecoration(
                          color: Color(0XFFFFFBEE), // Cream color
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Description:", style: GoogleFonts.poppins(textStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ))),
                          Text(widget.formDescription),
                            ],
                          ),
                        )),
                    Text("Applications", style: GoogleFonts.poppins(textStyle: const TextStyle(
                      color: Color(0XFF909300),
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                    ))),
                    DataTable(
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0XFF909300), width: 2,), // Table border color
                      ),
                      columns: [
                        DataColumn(label: Text('First Name')),
                        DataColumn(label: Text('Last Name')),
                        DataColumn(label: Text('Rating')),
                        DataColumn(label: Text('View Proposal')),
                        DataColumn(label: Text('View Profile')),
                        DataColumn(label: Text('Accept')),

                      ],
                      rows: List.generate(
                        10, // Number of dynamic rows
                            (index) => DataRow(
                          cells: [
                            DataCell(Text('First Name $index')),
                            DataCell(Text('Last Name $index')),
                            DataCell(Text('Rating $index')),
                            DataCell(
                              ElevatedButton(
                                onPressed: () {
                                  // Handle view proposal button click
                                  print('View Proposal $index');
                                },
                                child: Text('View Proposal'),
                              ),
                            ),
                            DataCell(
                              ElevatedButton(
                                onPressed: () {
                                  // Handle view profile button click
                                  print('View Profile $index');
                                },
                                child: Text('View Profile'),
                              ),
                            ),
                            DataCell(
                              Container(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.check),
                                      color: Colors.green,
                                      onPressed: () {
                                        print('Accept: ✓');
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.close),
                                      color: Colors.red,
                                      onPressed: () {
                                        print('Accept: ✗');
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ]
      ),
    );
  }

}