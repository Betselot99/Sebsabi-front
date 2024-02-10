import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DescriptionCard extends StatefulWidget {
  final void Function(String, String) onDataChanged;
  const DescriptionCard({super.key, required this.onDataChanged});

  @override
  State<DescriptionCard> createState() => _DescriptionCardState();

}

class _DescriptionCardState extends State<DescriptionCard> {
  TextEditingController titleController = TextEditingController();
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
            TextFormField(
              controller: titleController,
              textAlignVertical: TextAlignVertical.bottom,
              minLines: 3, // Set this
              maxLines: 6, // and this
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
                hintText: 'Title',
                focusedBorder:OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 1.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
              onChanged: (value) {
                widget.onDataChanged(titleController.text, descriptionController.text);
              },
            ),
            const SizedBox(height: 20,),
            TextFormField(
              controller: descriptionController,
              textAlignVertical: TextAlignVertical.bottom,
              minLines: 3, // Set this
              maxLines: 6, // and this
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
                hintText: 'Description',
                focusedBorder:OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 1.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
              onChanged: (value) {
                widget.onDataChanged(titleController.text, descriptionController.text);
              },
            ),
          ],
        ),
      )
    );
  }
}
