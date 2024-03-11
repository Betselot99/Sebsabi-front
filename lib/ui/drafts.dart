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

class Drafts extends StatefulWidget {
final int id;
  final String formTitle;
  final String formDescription;
  final int usage;
   List<dynamic> questions;
   Drafts({super.key, required this.formTitle, required this.formDescription, required this.usage,  required this.questions, required this.id});

  @override
  State<Drafts> createState() => _DraftsState();
}

class _DraftsState extends State<Drafts> {

  @override
  void initState() {
    super.initState();
    print(widget.questions.length);
    _questionCount=widget.questions.length;

   dataList = widget.questions.map((question) {
      List<String> choices = [];

      if (question['multipleChoiceOptions'] is List<dynamic>) {
        // Cast to the correct type if it's a list of dynamic
        choices = (question['multipleChoiceOptions'] as List<dynamic>)
            .map((option) => option['optionText'] as String)
            .toList();
      }

      return {
        'question': question['questionText'], // Assuming 'questionText' is the correct property name
        'type': question['questionType'], // Assuming 'questionType' is the correct property name
        'choices': choices, // Extracted optionText values
        'rate': question['ratingScale'] // Assuming 'ratingScale' is the correct property name
      };
    }).toList();

  }





  int _questionCount=0;
  Widget buttonRow() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Visibility(
        visible: _questionCount > 0,
        child: IconButton(
          onPressed: () {

            setState(() {
              widget.questions.removeLast();
              dataList.removeLast();
              _questionCount--;
            });
          },
          icon: const Icon(
            Icons.remove_circle,
          ),
        ),
      ),
      IconButton(
        onPressed: () {
          setState(() {

              _questionError= null;
              _questionCount++;
              question='';



          });
        },
        icon: const Icon(
          Icons.add_circle,
        ),
      ),
    ],
  );
  String title = '';
  String description ='';
  String? _descriptionError;
  String? _titleError;
  String? _questionError;
  String question='' ;
  String type= '';
  List<String?> choices =[];
  int rate=0;
   List<Map<String, dynamic>> dataList = [];

// Add an item to the dataList
  void addItemToDataList(String question, String type, int index, List<String?> choices, int rate) {
    Map<String, dynamic> newItem = {
      'question': question,
      'type': type,
      'choices': choices,
      'rate':rate
    };
    if(dataList.length==index){
      //dataList.removeAt(index);
      dataList.insert(index, newItem);
    }else{
      dataList.removeAt(index);
      dataList.insert(index, newItem);
    }

  }
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
                    Text("Update Form", style: GoogleFonts.poppins(textStyle: const TextStyle(
                      color: Color(0XFF909300),
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                    ))),
                    UpdateDescriptionCard(onDataChanged: (title, description,_descriptionError,_titleError) {
                      setState(() {
                        this.title = title;
                        this.description = description;
                        this._descriptionError=_descriptionError;
                        this._titleError=_titleError;
                      });
                    }, title: widget.formTitle, description: widget.formDescription,),
                    Column(
                      children: List.generate(
                        _questionCount, // Adjust the number of items as needed
                            (index) => UpdateQuestionCard(questionNumber: index+1,onDataChange: ( question,  type,choices, rate) {
                          setState((){
                            print(index);
                            this.question=question;
                            this.type=type;
                            this.choices=choices;
                            this.rate=rate;
                            addItemToDataList(question, type, index, choices, rate);
                          },);

                        },questionError: _questionError, question: _questionCount > widget.questions.length? "" : widget.questions[index]['questionText'],
                              type: _questionCount > widget.questions.length? "TEXT" : widget.questions[index]['questionType'],
                              choices:_questionCount > widget.questions.length? []: (widget.questions[index]['multipleChoiceOptions'] as List<dynamic>)
                                  .map((option) => option['optionText'] as String)
                                  .toList(),
                            ),
                      ),
                    ),
                    buttonRow(),
                    Text("title: ${title}"),
                    Text("description: ${description}"),
                    Text("title error: ${_titleError}"),
                    Text("description error: $_descriptionError"),

                    Text("new questionsss ${dataList.indexed}"),


                    Text(" question count ${_questionCount}"),



                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: ()async{
                            if(title.isNotEmpty && description.isNotEmpty && _titleError == null && _descriptionError == null ){
                              try {
                                final response = await FormApi.updateForm(
                                    widget.id, title, description, 10,
                                    Status.Draft);
                                if(response.isNotEmpty){
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text(
                                          'Form has been updated '),));

                                }else{
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text(
                                          'Form has not been updated '),));
                                }
                              }catch(e){
                                print(e);
                              }
                            }else{
                              if(question.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text(
                                        'Please fill out Questions'),));
                              }else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text(
                                        'Please fill out Description and Title '),));
                              }
                            }
                          },
                          child: const Text('Update as draft'),
                        ),
                        const SizedBox(width:20),
                        ElevatedButton(
                          onPressed: ()async{
                              try {
                                final response = await FormApi.updateForm(
                                    widget.id, title, description, 10,
                                    Status.Posted);
                                if(response.isNotEmpty){
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text(
                                          'Form has been updated '),));

                                }else{
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text(
                                          'Form has not been updated '),));
                                }
                              }catch(e){
                                print(e);
                              }

                          },
                          child: const Text('Post as Job'),
                        ),
                        SizedBox(height:50)
                      ],
                    )

                  ],
                ),
              ),
            )
          ]
      ),
    );
  }

}