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
  const Drafts({super.key, required this.formTitle, required this.formDescription, required this.usage, required this.id});

  @override
  State<Drafts> createState() => _DraftsState();
}

class _DraftsState extends State<Drafts> {
  List<FormQuestion> questions = [];

  @override
  void initState() {
    super.initState();
    _fetchQuestions();
  }

  Future<void> _fetchQuestions() async {
    try {
      List<FormQuestion> fetchedQuestions = await FormApi.getQuestions(widget.id);
      setState(() {
        questions = fetchedQuestions;
      });
    } catch (e) {
      // Handle error
      print('Error: $e');
    }
  }

  int _questionCount=1;
  Widget buttonRow() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Visibility(
        visible: _questionCount > 0,
        child: IconButton(
          onPressed: () {

            setState(() {
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
            if(question.isNotEmpty){
              _questionError= null;
              _questionCount++;
              question='';
            }else{
              _questionError="please fill out this field";
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Please fill out Question'),));
            }


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
  final List<Map<String, String>> dataList = [];

// Add an item to the dataList
  void addItemToDataList(String question, String type, int index) {
    Map<String, String> newItem = {
      'question': question,
      'type': type,
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
                    Text("Create Form", style: GoogleFonts.poppins(textStyle: const TextStyle(
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
                    }, title: widget.formTitle, description: widget.formTitle,),
                    Column(
                      children: List.generate(
                        questions.length, // Adjust the number of items as needed
                            (index) => UpdateQuestionCard(questionNumber: index+1,onDataChange: ( question,  type,) {
                          setState((){
                            print(index);
                            this.question=question;
                            this.type=type;
                            addItemToDataList(question, type, index);
                          },);

                        },questionError: _questionError, question: questions[index].questionText!, type: questions[index].questionType!,),
                      ),
                    ),
                    buttonRow(),
                    Text("title: ${title.isNotEmpty}"),
                    Text("description: ${description.isNotEmpty}"),
                    Text("title error: ${_titleError==null}"),
                    Text("description error: $_descriptionError"),

                    Text("${dataList.indexed}"),


                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: ()async{
                            if(title.isNotEmpty && description.isNotEmpty && _titleError == null && _descriptionError == null && question.isNotEmpty ){
                              try{

                                int? formId= await FormApi.createForm(title, description, 10,Status.Draft);
                                print(formId);
                                try {
                                  for (Map<String, String> questionData in dataList) {
                                    final questionText = questionData['question'];
                                    final questionType = questionData['type'];
                                    await FormApi.addQuestionToForm(formId, questionText, questionType);

                                  }
                                } catch (e) {
                                  // Handle the exception, show an error message, etc.
                                  print('Error: $e');
                                }
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar( content: Text('Form saved as draft'),));

                              }catch(e){
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar( content: Text('There seems to be a problem please try agian'),));
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
                            if(title.isNotEmpty && description.isNotEmpty && _titleError == null && _descriptionError == null && question.isNotEmpty ){
                              try{

                                int? formId= await FormApi.createForm(title, description, 10,Status.Posted);
                                print(formId);
                                try {
                                  for (Map<String, String> questionData in dataList) {
                                    final questionText = questionData['question'];
                                    final questionType = questionData['type'];
                                    await FormApi.addQuestionToForm(formId, questionText, questionType);

                                  }
                                } catch (e) {
                                  // Handle the exception, show an error message, etc.
                                  print('Error: $e');
                                }
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar( content: Text('Form has been created'),));

                              }catch(e){
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar( content: Text('There seems to be a problem please try agian'),));
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