import 'package:flutter/material.dart';




class SiteAnalytics extends StatefulWidget {
  const SiteAnalytics({super.key});

  @override
  State<SiteAnalytics> createState() => _SiteAnalyticsState();
}

class _SiteAnalyticsState extends State<SiteAnalytics> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.95,
        height: MediaQuery.of(context).size.width * 0.95 * 0.65,
        padding: EdgeInsets.fromLTRB(0, 10, 20, 10),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "bar chart",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            Expanded(
                child: Container(

                ))
          ],
        ),
      ),
    );
  }
}
