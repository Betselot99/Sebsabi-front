import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FormsCard extends StatefulWidget {
   final void Function()? onTap;
   final String formStatus;
   final String? title;
   final String? description;
   final bool claimed;
   final int proposalNo;

  const FormsCard({super.key, this.onTap, required this.formStatus,  this.title, this.description, required this.claimed, required this.proposalNo});

  @override
  State<FormsCard> createState() => _FormsCardState();
}

class _FormsCardState extends State<FormsCard> {
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
    return GestureDetector(
      onTap: widget.onTap,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Card(
          clipBehavior: Clip.hardEdge,
          surfaceTintColor: Colors.white,
          color: Colors.white,
          elevation: 5.0,
          child: SizedBox(
            width:200,
            height: 260,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if(widget.formStatus == "New")...[
                    Text("Add new form", style: GoogleFonts.poppins(textStyle: const TextStyle(
                color:  Color(0XFFC8C8C8),
                fontSize: 20,
              ))),
                  const SizedBox(height: 20,),
                  CircleAvatar(
                    radius: w/25,
                    backgroundColor: const Color(0XFFC8C8C8),
                    child: Icon(
                      Icons.add,
                      size: w/25,
                      color: Colors.white,
                    ),
                  ),]else if(widget.formStatus == "Draft")...[
                    Text("Title: ${widget.title}",maxLines: 2,overflow: TextOverflow.ellipsis, style: GoogleFonts.poppins(textStyle: const TextStyle(
                      color:  Color(0XFF909300),
                      fontSize: 20,
                    ))),
                    Wrap(
                      children: [Text("Description: ${widget.description}", maxLines: 5,overflow: TextOverflow.ellipsis, style: GoogleFonts.poppins(textStyle: const TextStyle(
                        color:  Color(0XFFC8C8C8),
                        fontSize: 12,

                      ))),]
                    ),
                    const SizedBox(height:10),
                    Text(widget.formStatus,maxLines: 2,overflow: TextOverflow.ellipsis, style: GoogleFonts.poppins(textStyle: const TextStyle(
                      color:  Colors.red,
                      fontSize: 15,
                    ))),
                  ]else if(widget.formStatus == "Posted")...[
                    Text("Title: ${widget.title}",maxLines: 2,overflow: TextOverflow.ellipsis, style: GoogleFonts.poppins(textStyle: const TextStyle(
                      color:  Colors.grey,
                      fontSize: 20,
                    ))),
                    Wrap(
                        children: [Text("Description: ${widget.description}", maxLines: 5,overflow: TextOverflow.ellipsis, style: GoogleFonts.poppins(textStyle: const TextStyle(
                          color:  Color(0XFFC8C8C8),
                          fontSize: 12,

                        ))),]
                    ),
                    const SizedBox(height:10),
                    Text("Applied People: ${widget.proposalNo}",maxLines: 2,overflow: TextOverflow.ellipsis, style: GoogleFonts.poppins(textStyle: const TextStyle(
                      color:  Color(0XFF909300),
                      fontSize: 15,
                    ))),
                    ]else if(widget.formStatus == "Claimed")...[
                    Text("Title: ${widget.title}",maxLines: 2,overflow: TextOverflow.ellipsis, style: GoogleFonts.poppins(textStyle: const TextStyle(
                      color:  Colors.grey,
                      fontSize: 20,
                    ))),
                    Wrap(
                        children: [Text("Description: ${widget.description}", maxLines: 5,overflow: TextOverflow.ellipsis, style: GoogleFonts.poppins(textStyle: const TextStyle(
                          color:  Color(0XFFC8C8C8),
                          fontSize: 12,

                        ))),]
                    ),
                    const SizedBox(height:10),
                      Text("Claimed",maxLines: 2,overflow: TextOverflow.ellipsis, style: GoogleFonts.poppins(textStyle: const TextStyle(
                        color:  Color(0XFF909300),
                        fontSize: 15,
                      ))),

                  ]else if(widget.formStatus == "Completed")...[
                    Text("Title: ${widget.title}",maxLines: 2,overflow: TextOverflow.ellipsis, style: GoogleFonts.poppins(textStyle: const TextStyle(
                      color:  Colors.grey,
                      fontSize: 20,
                    ))),
                    Wrap(
                        children: [Text("Description: ${widget.description}", maxLines: 5,overflow: TextOverflow.ellipsis, style: GoogleFonts.poppins(textStyle: const TextStyle(
                          color:  Color(0XFFC8C8C8),
                          fontSize: 12,

                        ))),]
                    ),
                    const SizedBox(height:10),
                    Text("Completed: See Results",maxLines: 2,overflow: TextOverflow.ellipsis, style: GoogleFonts.poppins(textStyle: const TextStyle(
                      color:  Colors.green,
                      fontSize: 12,
                    ))),
                  ]
                ],
              ),
            ),
          )
        ),
      ),
    );

  }
}
