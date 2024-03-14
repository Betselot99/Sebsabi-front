import 'package:flutter/material.dart';
import 'package:sebsabi/api/Admin_Api.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sebsabi/model/Status.dart';

class ClientPage extends StatefulWidget {
  const ClientPage({Key? key}) : super(key: key);

  @override
  State<ClientPage> createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  late Future<List<dynamic>> futureClients;
  String _selectedFilter = 'All';
  TextEditingController _searchController = TextEditingController();

  int _sortColumnIndex = 0;
  bool _sortAscending = true;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    futureClients = AdminApi.searchClients("","", 0);
  }
  void searchClients() {
    String searchText = _searchController.text;
    setState(() {
      if(_selectedFilter == "By First Name"){
      futureClients = AdminApi.searchClients("firstName",searchText, 0);}else if(_selectedFilter == "All"){
        futureClients = AdminApi.searchClients("",searchText, 0);}else if(_selectedFilter == "By Last Name"){
        futureClients = AdminApi.searchClients("lastName",searchText, 0);}
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: futureClients,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final clients = snapshot.data!;
          final rowsPerPage = clients.length < 10 ? clients.length == 0 ? 1:clients.length : PaginatedDataTable.defaultRowsPerPage;

          return SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Text("Client List", style: GoogleFonts.poppins(textStyle: const TextStyle(
                        color: Color(0XFF909300),
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                      ))),
                      IconButton(
                        icon: Icon(Icons.refresh),
                        onPressed: () {
                          setState(() {

                            searchClients();
                          });

                          print('Reload button pressed');
                        },
                        tooltip: 'Reload',
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          onEditingComplete: () {
                            setState(() {
                              print(_searchController.text);
                              searchClients();
                            });

                            // You can put your logic here
                          },
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
                                items: <String>['All', 'By First Name', 'By Last Name']
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
                  PaginatedDataTable(
                    columns: [
                      DataColumn(
                        label: Text('First Name'),
                        onSort: (columnIndex, ascending) {
                          setState(() {
                            _sortColumnIndex = columnIndex;
                            _sortAscending = ascending;
                            clients.sort((a, b) => a['firstName'].compareTo(b['firstName']));
                            if (!_sortAscending) {
                              clients.reversed.toList();
                            }
                          });
                        },
                      ),
                      DataColumn(label: Text('Last Name')),
                      DataColumn(label: Text('isActive')),
                      DataColumn(label: Text('Change Status')),
                    ],
                    source: _DataSource(context, clients),
                    rowsPerPage: rowsPerPage,
                    sortColumnIndex: _sortColumnIndex,
                    sortAscending: _sortAscending,
                    onSelectAll: (value) {},
                    onPageChanged: (index) {},
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}

class _DataSource extends DataTableSource {
  final BuildContext context;
  final List<dynamic> clients;

  _DataSource(this.context, this.clients);

  @override
  DataRow? getRow(int index) {
    if (index >= clients.length) return null;
    final client = clients[index];
    return DataRow(cells: [
      DataCell(Text(client['firstName'])),
      DataCell(Text(client['lastName'])),
      DataCell(Text('${client['isActive']}')),
      DataCell(ElevatedButton(
        onPressed: () async {
          try {
            print(client['id']);
            final response = await AdminApi.updateStatusClient(client['id'], {
              'isActive': client['isActive'] == 'Active'
                  ? Status.InActive.toString().split('.').last
                  : Status.Active?.toString().split('.').last
            });
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('User deactivated')));
            print(response);
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('There seems to be a problem')));
            print('Error: $e');
          }
        },
        child: Text('Change Status'),
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => clients.length;

  @override
  int get selectedRowCount => 0;
}



// Access more fields as needed

// ListView.builder(
// itemCount: snapshot.data!.length,
// itemBuilder: (context, index) {
// return ListTile(
// title: Text(snapshot.data![index]['firstName']),);
// }
// );