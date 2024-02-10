import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FormsCard extends StatefulWidget {
   final void Function()? onTap;
   final String formStatus;
   final String text="Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus vel tortor cursus augue iaculis scelerisque. Aenean finibus mi pretium odio lacinia, nec aliquam mi malesuada. Phasellus sed sem dictum, consectetur tortor et, aliquet neque. Nam sed diam sed lacus tristique efficitur scelerisque et erat. Nunc non fermentum est, a ullamcorper justo. Vivamus sapien nisi, rutrum vel libero et, semper lobortis sem. Vestibulum enim mi, porta a lobortis ut, maximus non tellus. Ut facilisis massa vel accumsan sollicitudin. Fusce non quam vel ligula sagittis interdum. Sed urna nisi, viverra tempus mattis non, maximus nec erat. Nunc ullamcorper feugiat maximus. Ut imperdiet metus at rhoncus accumsan. Cras consequat ornare odio eget dignissim. Donec imperdiet, nibh in porta imperdiet, sapien nibh venenatis libero, sed feugiat libero lorem vel massa. Sed maximus sollicitudin lacinia.";

  const FormsCard({super.key, this.onTap, required this.formStatus});

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
                    Text("Title: health form jeitjeritjiefor masters student",maxLines: 2,overflow: TextOverflow.ellipsis, style: GoogleFonts.poppins(textStyle: const TextStyle(
                      color:  Colors.grey,
                      fontSize: 20,
                    ))),
                    Wrap(
                      children: [Text("Description: ${widget.text}", maxLines: 5,overflow: TextOverflow.ellipsis, style: GoogleFonts.poppins(textStyle: const TextStyle(
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
                    Text("Title: health form jeitjeritjiefor masters student",maxLines: 2,overflow: TextOverflow.ellipsis, style: GoogleFonts.poppins(textStyle: const TextStyle(
                      color:  Colors.grey,
                      fontSize: 20,
                    ))),
                    Wrap(
                        children: [Text("Description: ${widget.text}", maxLines: 5,overflow: TextOverflow.ellipsis, style: GoogleFonts.poppins(textStyle: const TextStyle(
                          color:  Color(0XFFC8C8C8),
                          fontSize: 12,

                        ))),]
                    ),
                    const SizedBox(height:10),
                    Text("People Applied: 4",maxLines: 2,overflow: TextOverflow.ellipsis, style: GoogleFonts.poppins(textStyle: const TextStyle(
                      color:  Color(0XFF909300),
                      fontSize: 15,
                    ))),
                  ]else if(widget.formStatus == "Completed")...[
                    Text("Title: health form jeitjeritjiefor masters student",maxLines: 2,overflow: TextOverflow.ellipsis, style: GoogleFonts.poppins(textStyle: const TextStyle(
                      color:  Colors.grey,
                      fontSize: 20,
                    ))),
                    Wrap(
                        children: [Text("Description: ${widget.text}", maxLines: 5,overflow: TextOverflow.ellipsis, style: GoogleFonts.poppins(textStyle: const TextStyle(
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
