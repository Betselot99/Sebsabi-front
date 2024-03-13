import 'package:flutter/material.dart';
import 'package:sebsabi/api/Admin_Api.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sebsabi/model/Status.dart';

class ClientPage extends StatefulWidget {
  const ClientPage({super.key});

  @override
  State<ClientPage> createState() => _ClientPageState();

}

class _ClientPageState extends State<ClientPage> {
  String _selectedFilter = 'All';
  TextEditingController _searchController = TextEditingController();
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
              Row(
                children: [
                  Text("Clients List", style: GoogleFonts.poppins(textStyle: const TextStyle(
                    color: Color(0XFF909300),
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  ))),

                ],
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _searchController,
                      textAlignVertical: TextAlignVertical.bottom,
                      keyboardType: TextInputType.name,
                      style: const TextStyle(color: Colors.black),
                      decoration:  InputDecoration(
                        fillColor:  Color(0XFF909300).withOpacity(0.2),
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                          const BorderSide(width: 1, color: Colors.white), //<-- SEE HERE
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        hintText: 'Search...',
                        focusedBorder:OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white, width: 1.0),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right:20),
                          child: DropdownButton<String>(
                            value: _selectedFilter,
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedFilter = newValue!;
                              });
                            },
                            items: <String>['All', 'Option 1', 'Option 2', 'Option 3']
                                .map<DropdownMenuItem<String>>(
                                  (String value) => DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              ),
                            )
                                .toList(),
                          ),
                        ),
                      ),

                    ),
                  ),
                  SizedBox(width: 10),

                ],
              ),
              SizedBox(height: 20,),

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
                        onPressed: () async{
                          try {
                            print(snapshot.data![index]['id']);
                            final response = await AdminApi.updateStatusClient(snapshot.data![index]['id'], {'isActive': snapshot.data![index]['isActive']=='Active'? Status.InActive?.toString().split('.').last : Status.Active?.toString().split('.').last});
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar( content: Text('User deactivated'),));
                            setState(() {
                              AdminApi.fetchClients();
                            });
                            print(response);
                          } catch (e) {

                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar( content: Text('There seems to be a problem'),));
                            setState(() {
                              AdminApi.fetchClients();
                            });
                            print('Error: $e');
                          }
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