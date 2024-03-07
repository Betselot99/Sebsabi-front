import 'package:flutter/material.dart';
import 'package:sebsabi/api/Admin_Api.dart';
import 'package:google_fonts/google_fonts.dart';

class ClientPage extends StatefulWidget {
  const ClientPage({super.key});

  @override
  State<ClientPage> createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: AdminApi.fetchClients(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          // Display the list of clients
          return ListView(
            children: [
              Text("Clients List", style: GoogleFonts.poppins(textStyle: const TextStyle(
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
                    DataColumn(label: Text('isActive')),
                    DataColumn(label: Text('Change Status')),
                  ], rows: List.generate(snapshot.data!.length, (index) => DataRow(
                  cells: [
                    DataCell(Text(snapshot.data![index]['firstName'])),
                    DataCell(Text(snapshot.data![index]['lastName'])),
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
                // Access more fields as needed

// ListView.builder(
// itemCount: snapshot.data!.length,
// itemBuilder: (context, index) {
// return ListTile(
// title: Text(snapshot.data![index]['firstName']),);
// }
// );