import 'package:flutter/material.dart';

class UpdateQuestionCard extends StatefulWidget {
  final String type;
  final String question;
  final void Function(String, String) onDataChange;
  final int questionNumber;
  late final String? questionError;



  UpdateQuestionCard({super.key,required this.questionNumber, required this.onDataChange, this.questionError, required this.type, required this.question, });

  @override
  State<UpdateQuestionCard> createState() => _UpdateQuestionCardState();

}

class _UpdateQuestionCardState extends State<UpdateQuestionCard> {
  TextEditingController questionController = TextEditingController();
  late String? type;

  @override
  void initState() {
    super.initState();
    type= widget.type;
    questionController.text=widget.question;
  }

  int _multipleCount=0;
  final List<String?> _dataArray = [];    //add this
  final String _data = '';

  Widget multipleQ(int key) => Padding(
    padding: const EdgeInsets.only(bottom: 10.0),
    child: TextFormField(
      decoration: InputDecoration(hintText: 'Option ${key + 1}'),
    ),
  );
  Widget buttonRow() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Visibility(
        visible: _multipleCount > 0,
        child: IconButton(
          onPressed: () {
            // if (_dataArray.isNotEmpty) {
            //   _dataArray.removeAt(_dataArray.length - 1);
            // }
            setState(() {
              //_data = _dataArray.toString();
              _multipleCount--;
            });
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
        child:Padding(
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
                        widget.onDataChange(questionController.text,type!);
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
                        widget.onDataChange(questionController.text,type!);
                      },

                      items: <String>['TEXT','TRUE_FALSE', 'MULTIPLE_CHOICE']
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
                //Visibility(visible: _dataArray.isNotEmpty, child: Text(_data!)),
                const SizedBox(height: 30),
                //Text("${_dataArray}")
              ]
            ],
          ),
        )
    );
  }
}