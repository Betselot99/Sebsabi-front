import 'package:flutter/material.dart';
import 'package:sebsabi/ui/completedforms.dart';
import 'package:sebsabi/ui/myforms.dart';
import 'package:sebsabi/ui/postedforms.dart';
import 'package:sebsabi/ui/profile.dart';
import 'package:sebsabi/ui/widgets/description_card.dart';
import 'package:sebsabi/ui/widgets/pagesnavbar.dart';
import 'package:sebsabi/ui/widgets/question_card.dart';
import 'package:side_navigation/side_navigation.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateForm extends StatefulWidget {
  const CreateForm({super.key});

  @override
  State<CreateForm> createState() => _CreateFormState();
}

class _CreateFormState extends State<CreateForm> {
  final List<Widget> _widgetArray = [];
  int _questionCount=0;
  Widget buttonRow() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Visibility(
        visible: _questionCount > 0,
        child: IconButton(
          onPressed: () {
            if (_widgetArray.isNotEmpty) {
              _widgetArray.removeAt(_widgetArray.length - 1);
            }
            setState(() {
              _questionCount--;
            });
          },
          icon: Icon(
            Icons.remove_circle,
          ),
        ),
      ),
      IconButton(
        onPressed: () {
          setState(() => _questionCount++);
        },
        icon: Icon(
          Icons.add_circle,
        ),
      ),
    ],
  );
  String title = '';
  String description ='';
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h= MediaQuery.of(context).size.width;
    return  Scaffold(
        body: Column(
            children:[
              PagesNavBar(),
              Expanded(
                child: Padding(
                  padding:  EdgeInsets.fromLTRB(w/6, 20, w/6, 20),
                  child: ListView(
                    children: [
                      DescriptionCard(onDataChanged: (title, description) {
                        setState(() {
                          this.title = title;
                          this.description = description;
                        });
                      },),
                      Column(
                        children: List.generate(
                          _questionCount, // Adjust the number of items as needed
                              (index) => QuestionCard(questionNumber: index+1),
                        ),
                      ),
                      buttonRow(),
                      Text('Title: $title'),
                      Text('Description: $description'),

                    ],
                  ),
                ),
              )
            ]
        ),
    );
  }

}
