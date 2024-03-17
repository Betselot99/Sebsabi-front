import 'package:flutter/material.dart';
import 'package:sebsabi/api/Form_Api.dart';
import 'package:sebsabi/model/Status.dart';
import 'package:sebsabi/ui/home.dart';
import 'package:sebsabi/ui/myforms.dart';
import 'package:sebsabi/ui/widgets/description_card.dart';
import 'package:sebsabi/ui/widgets/pagesnavbar.dart';
import 'package:sebsabi/ui/widgets/question_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sebsabi/ui/widgets/updateDescription_card.dart';
import 'package:sebsabi/ui/widgets/updateQuestion_card.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../model/FormQuestion.dart';

class ViewCompletedForm extends StatefulWidget {
  final int id;
  final int gigWorkerId;
  final String formTitle;
  final String formDescription;
  final int usage;
  List<dynamic> questions;
  ViewCompletedForm({super.key, required this.formTitle, required this.formDescription, required this.usage,  required this.questions, required this.id, required this.gigWorkerId});

  @override
  State<ViewCompletedForm> createState() => _ViewCompletedFormState();
}

class _ViewCompletedFormState extends State<ViewCompletedForm> {
  TextEditingController questionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
            children:[
              const PagesNavBar(),
              Text("Form Analytics", style: GoogleFonts.poppins(textStyle: const TextStyle(
                color: Color(0XFF909300),
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ))),
              SizedBox(height: 50,),
              Row(
                children: [
                  Column(children:[
                  Padding(
                      padding: EdgeInsets.fromLTRB(w/6, 20, 0, 20),
                    child: Container(
                        width: w/1.9,

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
                  ),
                  SizedBox(height: 20,),
                  Padding(

                        padding: EdgeInsets.fromLTRB(w/6, 20, 0, 20),
                    child: Container(
                        width: w/1.9,
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
                  ),]),
                  SizedBox(width:w/12),
                  SizedBox(height:10),
                  Container(
                    width: w/5,
                    decoration: BoxDecoration(
                      color: Color(0xFFFFFBEE), // Egg color
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Please leave a testimonial for your Gig-Worker.", style: GoogleFonts.poppins(textStyle: const TextStyle(
                          color: Color(0XFF909300),
                          fontSize: 15,
                          //fontWeight: FontWeight.w500,
                        ))),
                        TextField(
                          controller: questionController,
                          minLines: 4, // Set this
                          maxLines: 4, // and this
                          keyboardType: TextInputType.multiline,
                          onChanged: (value) {
                              questionController.text=value;
                          },
                          decoration: InputDecoration(
                            hintText: 'Enter your testimonial',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                print(questionController.text);
                                try{
                                  FormApi.giveTestimonialForGigWorker(widget.id, widget.gigWorkerId, questionController.text);
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar( content: Text('Testimonial Submitted '),));
                                }catch(e){
                                  print(e);
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar( content: Text('There seems to be a problem, please try again.'),));
                                }
                              },
                              child: Text('Submit'),
                            ),
                           // Text(questionController.text)
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              Padding(
                padding: EdgeInsets.fromLTRB(w/6, 20, w/6, 20),
                child: FutureBuilder<dynamic>(
                  future: FormApi.fetchAnswerAnalysis(widget.id), // Pass your formId here
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}', style: GoogleFonts.poppins(),)); // Apply Google Fonts
                    } else {
                      final List<dynamic> result = snapshot.data;

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: result.length,
                        itemBuilder: (context, index) {
                          final item = result[index];
                          int i=1;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      initialValue: '${item['questionText']}',
                                      textAlignVertical: TextAlignVertical.bottom,
                                      minLines: 1, // Set this
                                      maxLines: 2,
                                      readOnly: true,// and this
                                      keyboardType: TextInputType.multiline,
                                      style: const TextStyle(color: Colors.black),
                                      decoration:  InputDecoration(
                                        fillColor:  Colors.white,
                                        filled: true,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide:
                                          const BorderSide(width: 1, color: Color(0XFF909300)), //<-- SEE HERE
                                          borderRadius: BorderRadius.circular(10.0),
                                        ),

                                        focusedBorder:OutlineInputBorder(
                                          borderSide: const BorderSide(color: Colors.white, width: 1.0),
                                          borderRadius: BorderRadius.circular(25.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width:20),
                                  Container(
                                    width:170,
                                    height: 50,
                                    //padding: const EdgeInsets.all(8),
                                    decoration: const BoxDecoration(
                                      color: Color(0XFF909300),
                                      borderRadius: BorderRadius.all(Radius.circular(5)),
                                    ),
                                    child: Center(
                                      child: Text('${item['questionType']}', style: GoogleFonts.poppins(textStyle: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ))),
                                    ),
                                  ),
                                ],
                              ),

                              if(item['questionType']=='MULTIPLE_CHOICE')...[
                                if (item['multipleChoiceOptions'] != null)
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Multiple Choice Options:', style: GoogleFonts.poppins(),), // Apply Google Fonts
                                          for (var option in item['multipleChoiceOptions'])
                                            Text('${option['id']}) ${option['optionText']}', style: GoogleFonts.poppins(),), // Apply Google Fonts
                                        ],
                                      ),
                                      if (item['optionSelectionCount'] != null)
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                             // Apply Google Fonts
                                            Container(
                                              height: 200, // Adjust height according to your needs
                                              child: SfCircularChart(
                                                series: <CircularSeries>[
                                                  PieSeries<Map<String, dynamic>, String>(
                                                    dataSource: (item['optionSelectionCount'].entries.toList() as List<MapEntry<String, dynamic>>)
                                                        .map((entry) => {'label': entry.key, 'value': entry.value})
                                                        .toList(),
                                                    xValueMapper: (data, _) => data['label'],
                                                    yValueMapper: (data, _) => data['value'],
                                                    dataLabelSettings: DataLabelSettings(
                                                      isVisible: true,
                                                      labelPosition: ChartDataLabelPosition.outside,

                                                    ),
                                                    dataLabelMapper: (data, _) {
                                                      final total = item['optionSelectionCount'].values.fold(0, (prev, element) => prev + element);
                                                      final percentage = (data['value'] / total) * 100;
                                                      return '${data['label']} (${percentage.toStringAsFixed(2)}%)';
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                    ],
                                  ),
                              ] else if(item['questionType']=='TEXT')...[
                                if (item['textAnswersWithResponseId'] != null)
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Text Answers:', style: GoogleFonts.poppins(),), // Apply Google Fonts
                                      for (var entry in item['textAnswersWithResponseId'].entries)
                                        Text('Response ${i++}) ${entry.value}', style: GoogleFonts.poppins(),), // Apply Google Fonts
                                    ],
                                  ),
                              ] else if(item['questionType']=='TRUE_FALSE')...[
                                 // Apply Google Fonts
                                if (item['trueCount'] != null && item['falseCount'] != null)
                                  Container(
                                    height: 200, // Adjust height according to your needs
                                    child: SfCircularChart(
                                      series: <CircularSeries>[
                                        PieSeries<Map<String, dynamic>, String>(
                                          dataSource: [
                                            {'label': 'True', 'value': item['trueCount']},
                                            {'label': 'False', 'value': item['falseCount']},
                                          ],
                                          xValueMapper: (data, _) => data['label'],
                                          yValueMapper: (data, _) => data['value'],
                                          pointColorMapper: (data, _) => data['label'] == 'True' ? Colors.green : Colors.orange,

                                          dataLabelSettings: DataLabelSettings(
                                            isVisible: true,
                                            labelPosition: ChartDataLabelPosition.outside,

                                          ),
                                          dataLabelMapper: (data, _) {
                                            final total = item['trueCount'] + item['falseCount'];
                                            final percentage = (data['value'] / total) * 100;
                                            return '${data['label']} (${percentage.toStringAsFixed(2)}%)';
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                              ] else if(item['questionType']=='RATING_SCALE')...[
                                SizedBox(height:20),
                                Center(child: Text('Average Rating: ${item['averageRating'].toStringAsFixed(1)}', style: GoogleFonts.poppins(),)
                                ),
                                SizedBox(height:10),
                                Center(
                                  child: Row(
                                   mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(width:10),
                                      RatingBar.builder(
                                        initialRating: item['averageRating'],
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemSize: 30,
                                        itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                                        itemBuilder: (context, _) => const Icon(
                                          Icons.circle,
                                          color: Colors.amber,


                                        ), onRatingUpdate: (double value) {  },

                                      ),

                                    ],
                                  ),
                                ),// Apply Google Fonts
                              ],
                              Divider(), // Separator between items
                            ],
                          );
                        },
                      );
                    }
                  },
                ),
              )
            ]
        ),
      ),
    );
  }
}





