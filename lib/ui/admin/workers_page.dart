import 'package:flutter/material.dart';
import 'package:sebsabi/api/Admin_Api.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../model/Status.dart';

class WorkerPage extends StatefulWidget {
  const WorkerPage({super.key});

  @override
  State<WorkerPage> createState() => _WorkerPageState();
}

class _WorkerPageState extends State<WorkerPage> {
  late Future<List<dynamic>> futureWorkers;
  String _selectedFilter = 'All';
  TextEditingController _searchController = TextEditingController();

  int _sortColumnIndex = 0;
  bool _sortAscending = true;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    futureWorkers = AdminApi.searchGigWorker("","", 0);
  }
  void searchWorkers() {
    String searchText = _searchController.text;
    setState(() {
      if(_selectedFilter == "By First Name"){
      futureWorkers = AdminApi.searchGigWorker("firstName",searchText, 0);}else if(_selectedFilter == "All"){
      futureWorkers = AdminApi.searchGigWorker("",searchText, 0);}else if(_selectedFilter == "By Last Name"){
    futureWorkers = AdminApi.searchGigWorker("lastName",searchText, 0);}
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: futureWorkers,
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
                      Text("Workers List", style: GoogleFonts.poppins(textStyle: const TextStyle(
                        color: Color(0XFF909300),
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                      ))),
                      IconButton(
                        icon: Icon(Icons.refresh),
                        onPressed: () {
                          setState(() {

                            searchWorkers();
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
                              searchWorkers();
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
  final List<dynamic> workers;

  _DataSource(this.context, this.workers);

  @override
  DataRow? getRow(int index) {
    if (index >= workers.length) return null;
    final worker = workers[index];
    return DataRow(cells: [
      DataCell(Text(worker['firstName'])),
      DataCell(Text(worker['lastName'])),
      DataCell(Text('${worker['isActive']}')),
      DataCell(ElevatedButton(
        onPressed: () async {
          try {
            print(worker['id']);
            final response = await AdminApi.updateStatusWorker(worker['id'], {
              'isActive': worker['isActive'] == 'Active'
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
  int get rowCount => workers.length;

  @override
  int get selectedRowCount => 0;
}