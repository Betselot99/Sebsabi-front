import 'package:flutter/material.dart';
import 'package:sebsabi/api/Admin_Api.dart';
import 'package:google_fonts/google_fonts.dart';

class WorkerPage extends StatefulWidget {
  const WorkerPage({super.key});

  @override
  State<WorkerPage> createState() => _WorkerPageState();
}

class _WorkerPageState extends State<WorkerPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
        future: AdminApi.fetchWorkers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            // Display the list of clients
            return ListView(
              children: [
                Text("Workers List", style: GoogleFonts.poppins(textStyle: const TextStyle(
                  color: Color(0XFF909300),
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                ))),
                DataTable(
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0XFF909300), width: 2,), // Table border color
                    ),

                    columns: [
                      DataColumn(label: Text('First Name')),
                      DataColumn(label: Text('Last Name')),
                      DataColumn(label: Text('qualification')),
                      DataColumn(label: Text('isActive')),
                      DataColumn(label: Text('Change Status')),
                    ], rows: List.generate(snapshot.data!.length, (index) => DataRow(
                    cells: [
                      DataCell(Text(snapshot.data![index]['firstName'])),
                      DataCell(Text(snapshot.data![index]['lastName'])),
                      DataCell(Text(snapshot.data![index]['qualification'])),
                      DataCell(Text('${snapshot.data![index]['isActive']}')),
                      DataCell(
                        ElevatedButton(
                          onPressed: () {
                            // Handle view proposal button click
                          },
                          child: Text('Change Status'),
                        ),
                      ),
                    ])))
              ],
            );

          }
        }
    );
  }
}
