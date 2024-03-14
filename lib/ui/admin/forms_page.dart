import 'package:flutter/material.dart';
import 'package:sebsabi/api/Admin_Api.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sebsabi/model/Status.dart';

class FormsPage extends StatefulWidget {
  const FormsPage({Key? key}) : super(key: key);

  @override
  State<FormsPage> createState() => _FormsPageState();
}

class _FormsPageState extends State<FormsPage> {
  late Future<List<dynamic>> futureForms;
  String _selectedFilter = 'All';
  TextEditingController _searchController = TextEditingController();

  int _sortColumnIndex = 0;
  bool _sortAscending = true;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    futureForms = AdminApi.searchForms("", 0);

  }
  void searchForms() {
    String searchText = _searchController.text;
    setState(() {
      futureForms = AdminApi.searchForms(searchText, 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: futureForms,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final forms = snapshot.data!;
          final rowsPerPage = forms.length < 10 ? forms.length == 0 ? 1:forms.length : PaginatedDataTable.defaultRowsPerPage;

          return SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Text("Forms List", style: GoogleFonts.poppins(textStyle: const TextStyle(
                        color: Color(0XFF909300),
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                      ))),
                      IconButton(
                        icon: Icon(Icons.refresh),
                        onPressed: () {
                          setState(() {

                            searchForms();
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
                              searchForms();
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
                                items: <String>['All', 'By Title', ]
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
                        label: Text('title'),
                        onSort: (columnIndex, ascending) {
                          setState(() {
                            _sortColumnIndex = columnIndex;
                            _sortAscending = ascending;
                            forms.sort((a, b) => a['title'].compareTo(b['title']));
                            if (!_sortAscending) {
                              forms.reversed.toList();
                            }
                          });
                        },
                      ),
                      DataColumn(label: Text('description')),
                      DataColumn(label: Text('Limit')),
                      DataColumn(label: Text('Status')),
                      DataColumn(label: Text('Number of Questions')),
                      DataColumn(label: Text('Number of Responses')),
                      DataColumn(label: Text('Number of proposals')),
                      DataColumn(label: Text('Assigned')),


                    ],
                    source: _DataSource(context, forms),
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
      DataCell(Text(client['title'])),
      DataCell(Text(client['description'])),
      DataCell(Text('${client['usageLimit']}')),
      DataCell(Text('${client['status']}')),
      DataCell(Text('${client['questions'].length}')),
      DataCell(Text('${client['userResponses'].length}')),
      DataCell(Text('${client['proposals'].length}')),
      DataCell(Text(client['assignedGigWorker']== null ? "No":"Yes")),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => clients.length;

  @override
  int get selectedRowCount => 0;
}