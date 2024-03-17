

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
  bool claimed;
  final int? assignedGigWorkerId;
  String? assignedGigWorkername;
   ViewPostedForms({super.key, required this.formTitle, required this.formDescription, required this.usage, required this.id, required this.claimed, required this.assignedGigWorkerId, required this.assignedGigWorkername});

  @override
  State<ViewPostedForms> createState() => _ViewPostedFormsState();
}

class _ViewPostedFormsState extends State<ViewPostedForms> {
  @override
  void initState() {
    super.initState();
    checkForForm();
    checkForProgress();
  }

  late Future<List<Map<String, dynamic>>> forms;
  late bool formAvailable= false;
  late List<Map<String,dynamic>> formsList=[];
  late int progress=-1;

  int assignedGigWorkerId=0;
  String gigWorkerName="";
  String gigWorkerLName="";


  Future<void> checkForForm() async {

    forms = FormApi.getProposalsByFormId(widget.id);
    //print(forms);
    formsList = await forms;


    for (var form in formsList) {


      if (formsList.isEmpty) {
        setState(() {
          formAvailable = false;
        });
      } else {
        setState(() {
          formAvailable = true;
        });
      }
    }
  }
  Future<void> checkForProgress() async {

    try {
      var prog = await FormApi.getClientJobStatus(widget.id);
      setState(() {
        progress=prog;
      });
      print(progress);
    }catch(e){
      print(e);
    }
  }
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
                    if(widget.claimed==false)...[
                    Text("Applications", style: GoogleFonts.poppins(textStyle: const TextStyle(
                      color: Color(0XFF909300),
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                    ))),
                    if(formsList.isNotEmpty)...[
                    DataTable(
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0XFF909300), width: 2,), // Table border color
                      ),
                      columns: [
                        DataColumn(label: Text('First Name')),
                        DataColumn(label: Text('Last Name')),
                        DataColumn(label: Text('View Proposal')),
                        DataColumn(label: Text('Price')),
                        DataColumn(label: Text('View Profile')),
                        DataColumn(label: Text('Accept')),

                      ],
                      rows: List.generate(
                        formsList.length, // Number of dynamic rows
                            (index) => DataRow(
                          cells: [
                            DataCell(Text('${formsList[index]['gigWorker']['firstName']}')),
                            DataCell(Text('${formsList[index]['gigWorker']['lastName']}')),
                            DataCell(
                              ElevatedButton(
                                onPressed: () {
                                  // Handle view proposal button click
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Proposal'),
                                        content: Text('${formsList[index]['proposalText']}'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              // Close the dialog when the button is pressed
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('Close'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },

                                child: Text('View Proposal'),
                              ),
                            ),
                            DataCell(Text('${formsList[index]['ratePerForm']}')),
                            DataCell(
                              ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        content: SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              CircleAvatar(
                                                radius: 30,
                                                backgroundImage: AssetImage('assets/logo.png'), // Placeholder image
                                                backgroundColor: Colors.transparent,
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                '${formsList[index]['gigWorker']['firstName']} ${formsList[index]['gigWorker']['lastName']}',
                                                style: GoogleFonts.poppins(
                                                  textStyle: const TextStyle(
                                                    color: Color(0XFF909300),
                                                    fontSize: 30,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              Text(
                                                '${formsList[index]['gigWorker']['email']}',
                                                style: GoogleFonts.poppins(
                                                  textStyle: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              SizedBox(height: 20),
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.transparent, // Transparent background
                                                  borderRadius: BorderRadius.circular(15),
                                                  border: Border.all(color: Colors.white, width: 1),
                                                ),
                                                padding: EdgeInsets.all(10),
                                                child:
                                                    Row(
                                                      children: [
                                                        CircleAvatar(
                                                          radius: 14,
                                                          backgroundColor: Colors.white,
                                                          child: Icon(
                                                            Icons.face, // Replace this with your logo icon or image
                                                            size: 14,
                                                            color: Color(0XFF909300), // Color of the logo
                                                          ),
                                                        ),
                                                        SizedBox(width:10),
                                                        Text(
                                                          'Qualification: ${formsList[index]['gigWorker']['qualification']}',
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ],
                                                    ),),
                                                    SizedBox(height: 10),
                                                    Text(
                                                      'Testimonials',
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        color: Color(0XFF909300),
                                                      ),
                                                    ),
                                                    SizedBox(height: 5),
                                                    // Iterate over the testimonials and add Text widgets
                                                    for (var testimonial in formsList[index]['gigWorker']['testimonials'])
                                                      Column(
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [

                                                              SizedBox(width: 10),
                                                              Text(
                                                                '${testimonial['client']['firstName']} ${testimonial['client']['lastName']}: ',
                                                                style: GoogleFonts.poppins(
                                                                  textStyle: TextStyle(
                                                                    fontSize: 14,
                                                                    color: Color(0XFF909300),
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Text(
                                                                  testimonial['content'],
                                                                  style: GoogleFonts.poppins(
                                                                    textStyle: TextStyle(
                                                                      fontSize: 14,
                                                                      color: Colors.black,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Divider(),
                                                        ],
                                                      ),



                                            ],
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              // Close the dialog when the button is pressed
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('Close'),
                                          ),
                                        ],
                                      );



                                    },
                                  );
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
                                        setState(() {
                                          var id=formsList[index]['id'];
                                          try{
                                            FormApi.acceptProposal(id);
                                            assignedGigWorkerId=formsList[index]['gigWorker']['id'];
                                            widget.assignedGigWorkername='${formsList[index]['gigWorker']['firstName']} ${formsList[index]['gigWorker']['lastName']}';

                                            widget.claimed=true;
                                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar( content: Text('Proposal has been accepted'),));
                                          }catch(e){
                                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar( content: Text('There seems to be a problem'),));
                                          }

                                        });


                                        print('Accept: ✓');
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),]else...[
                      Text("No Applications yet!")
                    ]
    ]else...[
      SizedBox(height:50),
      Card(
        margin: EdgeInsets.all(16.0),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Assigned To ${widget.assignedGigWorkername}',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {

              checkForProgress();
              // Add your reload logic here
              print('Reload button pressed');
            },
            tooltip: 'Reload',
          )
                ],
              ),
              SizedBox(height: 16.0),

              if(progress.isNegative)...[
                LinearProgressIndicator(
                  minHeight: 10.0,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0XFF909300)),
                ),
              ]else...[
                LinearProgressIndicator(
                  value: progress/100,
                  minHeight: 10.0,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0XFF909300)),
                ),
              ]
            ],
          ),
        ),
      )
    ]
                  ],
                ),
              ),
            )
          ]
      ),
    );
  }

}