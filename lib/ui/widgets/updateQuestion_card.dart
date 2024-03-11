import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class UpdateQuestionCard extends StatefulWidget {

  String? question;
  String? type;
  List<String?> choices;

  final void Function(String, String, List<String?>, int) onDataChange;
  final int questionNumber;
  late final String? questionError;



  UpdateQuestionCard({super.key, required this.choices, this.type, this.question, required this.questionNumber, required this.onDataChange, this.questionError, });

  @override
  State<UpdateQuestionCard> createState() => _UpdateQuestionCardState();

}

class _UpdateQuestionCardState extends State<UpdateQuestionCard> {

  @override
  void initState() {
    super.initState();
    questionController.text = widget.question!;
    type = widget.type!;
    _multipleCount= widget.choices.length;
    for (String? choice in widget.choices) {
      TextEditingController controller = TextEditingController();
      controller.text = choice ?? ""; // Set the initial text for the controller
      _choiceControllers.add(controller);
      _dataArray=widget.choices;
    }

  }
  List<TextEditingController> _choiceControllers = [];
  TextEditingController questionController = TextEditingController();
  TextEditingController maxNumberController = TextEditingController();

  double rating = 1;
  int i=0;
  String type='TEXT';
  int _multipleCount=0;
   List<String?> _dataArray = [];    //add this






  Widget multipleQ(int key) => Padding(
    padding: const EdgeInsets.only(bottom: 10.0),
    child: TextFormField(
      controller: _getControllerForKey(key),
      decoration: InputDecoration(hintText: 'Option ${key + 1}'),

      onChanged: (value) {
        print(key);

        if (_choiceControllers.length <= key) {
          _choiceControllers.add(
              TextEditingController.fromValue(
                TextEditingValue(
                  text: value,
                  selection: TextSelection.collapsed(offset: value.length),
                ),));
        } else {
          // Get the current selection position
          final selection = _choiceControllers[key].selection;

          // Update the controller's value with the new text and selection
          _choiceControllers[key].value = TextEditingValue(
            text: value,
            selection: selection,
          );
        }

        print(_choiceControllers);

        if (_dataArray.length == key) {
          _dataArray.add(value);
          widget.onDataChange(
            questionController.text,
            type,
            type == 'MULTIPLE_CHOICE' ? _dataArray:[],
            type == 'RATING_SCALE' ? 5 : 0,
          );
        } else {
          _dataArray[key] = value;
          widget.onDataChange(
            questionController.text,
            type,
            type == 'MULTIPLE_CHOICE' ? _dataArray:[],
            type == 'RATING_SCALE' ? 5 : 0,
          );
        }
      },
    ),
  );

  TextEditingController _getControllerForKey(int key) {
    if (_choiceControllers.length <= key) {
      return TextEditingController();
    } else {
      return _choiceControllers[key];
    }
  }

  Widget buttonRow() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Visibility(
        visible: _multipleCount > 0,
        child: IconButton(
          onPressed: () {
            if(_multipleCount == _choiceControllers.length){
              if (_dataArray.isNotEmpty) {
                _dataArray.removeAt(_dataArray.length - 1);
                _choiceControllers.removeLast();

                setState(() {
                  //_data = _dataArray.toString();
                  _multipleCount--;
                });
                widget.onDataChange(
                  questionController.text,
                  type,
                  type == 'MULTIPLE_CHOICE' ? _dataArray:[],
                  type == 'RATING_SCALE' ? 5 : 0,
                );
              }
            }else{
              setState(() {
                //_data = _dataArray.toString();
                _multipleCount--;
              });
            }
          },

          icon:const Icon(
            Icons.remove_circle,
          ),
        ),
      ),
      IconButton(
        onPressed: () {
          setState(() => _multipleCount++);
        },
        icon:const Icon(
          Icons.add_circle,
        ),
      ),
    ],
  );
  TextEditingController descriptionController = TextEditingController();
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
    return Card(
        child:ClipPath(
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(color: Color(0XFF909300).withOpacity(0.5), width: 10),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const SizedBox(height: 20,),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: questionController,
                          textAlignVertical: TextAlignVertical.bottom,
                          minLines: 1, // Set this
                          maxLines: 2, // and this
                          keyboardType: TextInputType.multiline,
                          style: const TextStyle(color: Colors.black),
                          decoration:  InputDecoration(
                            fillColor:  Colors.white,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                              const BorderSide(width: 1, color: Colors.white), //<-- SEE HERE
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            hintText: 'Question ${widget.questionNumber}',

                            focusedBorder:OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white, width: 1.0),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                          ),

                          onChanged: (value) {
                            widget.onDataChange(questionController.text,type,type == 'MULTIPLE_CHOICE' ? _dataArray:[],type=='RATING_SCALE'?5:0);
                          },
                        ),
                      ),
                      const SizedBox(width:20),
                      Container(
                        width:150,
                        height: 50,
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: Color(0XFF909300),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: DropdownButton<String>(
                          elevation: 20,
                          isExpanded: true,
                          underline: Container(
                            height: 0, //<-- SEE HERE
                          ),
                          value: type,
                          dropdownColor: const  Color(0XFF909300),
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black,
                            size: 30,

                          ),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize:17,),
                          onChanged: (String? roleValue,) {
                            setState(() {
                              type = roleValue!;

                            });
                            widget.onDataChange(questionController.text,type,type == 'MULTIPLE_CHOICE' ? _dataArray:[],type=='RATING_SCALE'?5:0);
                          },

                          items: <String>['TEXT','TRUE_FALSE', 'MULTIPLE_CHOICE', 'RATING_SCALE']
                              .map<DropdownMenuItem<String>>((String rolevalue2) {
                            return DropdownMenuItem<String>(
                              value: rolevalue2,
                              child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(rolevalue2)),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  if(type == 'MULTIPLE_CHOICE')...[...List.generate(_multipleCount, (index) => multipleQ(index)),
                    buttonRow(),
                    const SizedBox(height: 10),
                    const SizedBox(height: 30),
                    Text("$_dataArray"),
                    Text("${_choiceControllers.length}"),
                    Text("$_multipleCount")

                  ],
                  if(type == 'RATING_SCALE')...[

                    const SizedBox(height:20),
                    Row(
                      children: [
                        const SizedBox(width:10),
                        RatingBar.builder(
                          initialRating: 1,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 20,
                          itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => const Icon(
                            Icons.circle,
                            color: Colors.amber,

                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                            setState(() {
                              i=5;
                            });

                          },
                        ),

                      ],
                    ),

                  ]
                ],
              ),
            ),
          ),
        )
    );
  }
}