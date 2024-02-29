import 'package:flutter/material.dart';

class DescriptionCard extends StatefulWidget {
  final void Function(String, String,String?, String?) onDataChanged;
  const DescriptionCard({super.key, required this.onDataChanged});

  @override
  State<DescriptionCard> createState() => _DescriptionCardState();

}

class _DescriptionCardState extends State<DescriptionCard> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  String? _descriptionError;
  String? _titleError;

  void _validateDescription(String value) {
    if (value.isEmpty) {
      setState(() {
        _descriptionError = 'This field is required';
      });
    } else {
      setState(() {
        _descriptionError = null;
      });
    }
  }
  void _validateTitle(String value) {
    if (value.isEmpty) {
      setState(() {
        _titleError = 'This field is required';
      });
    } else {
      setState(() {
        _titleError = null;
      });
    }
  }
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
              top: BorderSide(color: Color(0XFF909300), width: 10),
            ),
          ),
          child: Padding(
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
                    errorText: _titleError,
                    focusedBorder:OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white, width: 1.0),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                  validator: (value) => _titleError,
                  onChanged: (value) {
                    _validateTitle(value);
                    widget.onDataChanged(titleController.text, descriptionController.text, _descriptionError,_titleError);
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
                    errorText: _descriptionError,
                    focusedBorder:OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white, width: 1.0),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                  validator: (value) => _descriptionError,
                  onChanged: (value) {
                    _validateDescription(value);
                    widget.onDataChanged(titleController.text, descriptionController.text, _descriptionError,_titleError);
                  },
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
