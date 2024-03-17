import 'package:flutter/material.dart';
import 'package:sebsabi/api/Form_Api.dart';
import 'package:sebsabi/model/Status.dart';
import 'package:sebsabi/ui/home.dart';
import 'package:sebsabi/ui/widgets/description_card.dart';
import 'package:sebsabi/ui/widgets/pagesnavbar.dart';
import 'package:sebsabi/ui/widgets/question_card.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateForm extends StatefulWidget {
  const CreateForm({super.key});

  @override
  State<CreateForm> createState() => _CreateFormState();
}

class _CreateFormState extends State<CreateForm> {
 bool isloading =false;
 bool loading= false;

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
  List<String?> choices =[];
  int rate=0;
  final List<Map<String, dynamic>> dataList = [];
  TextEditingController usageLimitController = TextEditingController();

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
                      Text("Create Form", style: GoogleFonts.poppins(textStyle: const TextStyle(
                        color: Color(0XFF909300),
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                      ))),
                      DescriptionCard(onDataChanged: (title, description,_descriptionError,_titleError) {
                        setState(() {
                          this.title = title;
                          this.description = description;
                          this._descriptionError=_descriptionError;
                          this._titleError=_titleError;
                        });
                      },),
                      Column(
                        children: List.generate(
                          _questionCount, // Adjust the number of items as needed
                              (index) => QuestionCard(questionNumber: index+1,onDataChange: ( question,  type, choices,rate) {
                                setState((){
                                  print(index);
                                  this.question=question;
                                  this.type=type;
                                  this.choices=choices;
                                  this.rate=rate;
                                  addItemToDataList(question, type, index,choices,rate);
                               },);

                              },questionError: _questionError,),
                        ),
                      ),
                      buttonRow(),
                      // Text("title: ${title.isNotEmpty}"),
                      // Text("description: ${description.isNotEmpty}"),
                      // Text("title error: ${_titleError==null}"),
                      // Text("description error: $_descriptionError"),
                      //
                      // Text("${dataList.indexed}"),


                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: ()async{
                              if(title.isNotEmpty && description.isNotEmpty && _titleError == null && _descriptionError == null && question.isNotEmpty ){
                                try{
                                  setState(() {
                                    isloading=true;
                                  });

                                  int? formId= await FormApi.createForm(title, description, 10,Status.Draft);
                                  print(formId);
                                  try {
                                    for (Map<String, dynamic> questionData in dataList) {
                                      final questionText = questionData['question'];
                                      final questionType = questionData['type'];
                                      final multipleChoiceOptions = questionData['choices'];
                                      final ratingScale = questionData['rate'];
                                      print(multipleChoiceOptions);

                                      await FormApi.addQuestionToForm(formId, questionText, questionType, multipleChoiceOptions,ratingScale);


                                    }
                                  } catch (e) {
                                    // Handle the exception, show an error message, etc.
                                    print('Error: $e');
                                  }
                                  setState(() {
                                    isloading=false;
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar( content: Text('Form saved as draft'),));
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) => Home()));

                                }catch(e){
                                  setState(() {
                                    isloading=false;
                                  });
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
                            child:  isloading
                                ? const CircularProgressIndicator(
                              strokeWidth: 2,  // Adjust the thickness of the indicator
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ) // Show loading indicator if _isLoading is true
                                : const Text('Save as Draft'),
                          ),
                          const SizedBox(width:20),
                          ElevatedButton(

                            onPressed: () async{

                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Collection Limit'),
                                    content: TextField(
                                      controller: usageLimitController,
                                      decoration: InputDecoration(
                                        hintText: 'Please enter how many people you want to collect from.',
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () async{
                                          // Close the dialog and do something with the entered password
                                          if(title.isNotEmpty && description.isNotEmpty && _titleError == null && _descriptionError == null && question.isNotEmpty ){
                                            try{
                                              setState(() {
                                                loading = true;
                                              });

                                              int? formId= await FormApi.createForm(title, description, int.parse(usageLimitController.text),Status.Posted);
                                              print(formId);
                                              try {
                                                for (Map<String, dynamic> questionData in dataList) {
                                                  final questionText = questionData['question'];
                                                  final questionType = questionData['type'];
                                                  final multipleChoiceOptions = questionData['choices'];
                                                  final ratingScale = questionData['rate'];
                                                  await FormApi.addQuestionToForm(formId, questionText, questionType,multipleChoiceOptions, ratingScale);

                                                }
                                              } catch (e) {
                                                // Handle the exception, show an error message, etc.
                                                print('Error: $e');
                                                setState(() {
                                                  loading = false;
                                                });
                                              }
                                              setState(() {
                                                loading = false;
                                              });
                                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar( content: Text('Form has been created'),));

                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(builder: (context) => Home()));

                                            }catch(e){
                                              setState(() {
                                                loading = false;
                                              });
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
                                        child: Text('Save'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          // Close the dialog without saving
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Cancel'),
                                      ),
                                    ],
                                  );
                                },
                              );

                            },
                            child: loading
                                ? const CircularProgressIndicator(
                              strokeWidth: 2,  // Adjust the thickness of the indicator
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ) // Show loading indicator if _isLoading is true
                                : const Text('Post as Job'),
                          ),

                          SizedBox(height:50)
                        ],
                      )

                    ],
                  ),
                ),
              ),


            ]
        ),
    );
  }

}
