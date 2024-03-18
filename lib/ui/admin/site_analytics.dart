

import 'package:flutter/material.dart';
import 'package:sebsabi/api/Admin_Api.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';




class SiteAnalytics extends StatefulWidget {
  const SiteAnalytics({super.key});

  @override
  State<SiteAnalytics> createState() => _SiteAnalyticsState();
}

class _SiteAnalyticsState extends State<SiteAnalytics> {
  late Future<int> numberOfClients;
  late Future<int> numberOfWorkers;
  late Future<num> formsPerClient;
  late Future<num> proposalPerForm;
  late Future<num> formPerWorker;
  late Future<List<Map<String, dynamic>>> formsByStatus;
  late List<ChartData> chartData=[];
  late Future<num> balance;
  late Future<List<dynamic>> _paymentsFuture;


  List<ChartData> data = [
    ChartData("Jan", 35),
    ChartData("Feb", 42),
    ChartData("Mar", 21),
    ChartData("Apr", 63),
    ChartData("May", 18),
    ChartData("Jun", 50),
    ChartData("Jul", 77),
    ChartData("Aug", 28),
    ChartData("Sep", 45),
    ChartData("Oct", 36),
    ChartData("Nov", 55),
    ChartData("Dec", 68),
  ];

  @override
  void initState() {
    super.initState();
    numberOfClients = AdminApi.fetchNumberofClients();
    numberOfWorkers= AdminApi.fetchNumberofGigWorkers();
    formsPerClient = AdminApi.formsPerClient();
    proposalPerForm = AdminApi.proposalsPerClient();
    formPerWorker =AdminApi.formsAssignedPerWorker();
    formsByStatus = AdminApi.countByStatus();
    setState(() {
      la();
    });
    balance = _fetchBalance();
    _paymentsFuture = AdminApi.getAllPayments();




  }

  Future<num> _fetchBalance() async {
    try {
      Map<String, dynamic> data = await AdminApi.fetchBalance();
      return data['amount'];
    } catch (e) {
      throw Exception('Error fetching balance $e');
    }
  }

  void la() async{
      List<Map<String, dynamic>> fin= await AdminApi.countByStatus();
      setState(() {
        chartData = fin.map((data){
          return ChartData(
            data['status'] as String,
            data['count'] as double,
          );
        }).toList();
      });

      print("chart data: $chartData");
    }


  @override
  Widget build(BuildContext context) {

    return ListView(
      children: [
        Text("Site Analysis", style: GoogleFonts.poppins(textStyle: const TextStyle(
          color: Color(0XFF909300),
          fontSize: 30,
          fontWeight: FontWeight.w500,
        ))),
        Center(
          child: Container(
            child: SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                series: <CartesianSeries>[
                  // Renders line chart
                  LineSeries<ChartData, String>(
                      dataSource: data,
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y,
                      color:Color(0XFF909300),
                  )
                ]
            ),
          ),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildCard("Number of Clients", numberOfClients),
                  buildCard("Number of Gig-Workers", numberOfWorkers),
                  buildCard("Forms per Client", formsPerClient),
                  // Add more cards with other API calls as needed
                ],
              ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildCard("Proposal per Form", proposalPerForm),
              buildCard("Forms Assigned Per Gig-Worker", formPerWorker),
            ]),
            ],
          ),
        ),Column(

          children: [
            Text("Forms per Status", style: GoogleFonts.poppins(textStyle: const TextStyle(
              color: Color(0XFF909300),
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ))),
            Container(

              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                series: <CartesianSeries<ChartData, String>>[
                  // Renders a single column chart with different colors for each bar
                  ColumnSeries<ChartData, String>(
                    dataSource: chartData,
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y,
                    pointColorMapper: (ChartData data, _) {
                      // Define colors based on status or any other condition
                      if (data.x == 'Draft') {
                        return Colors.redAccent;
                      } else if (data.x == 'Claimed') {
                        return Color(0XFF909300);
                      } else if (data.x == 'Posted') {
                        return Colors.orange;
                      }
                      // Add more cases or provide a default color
                      return Colors.grey;
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 40),
        Row(
          children: [

            Text("Walet", style: GoogleFonts.poppins(textStyle: const TextStyle(
              color: Color(0XFF909300),
              fontSize: 30,
              fontWeight: FontWeight.w500,
            ))),
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                _fetchBalance();

                print('Reload button pressed');
              },
              tooltip: 'Reload',
            )
          ],
        ),
        SizedBox(height: 40),
        buildCard("Balance", balance),
        SizedBox(height: 40),
        Text("Transaction", style: GoogleFonts.poppins(textStyle: const TextStyle(
          color: Color(0XFF909300),
          fontSize: 30,
          fontWeight: FontWeight.w500,
        ))),
        FutureBuilder<List<dynamic>>(
          future: _paymentsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return DataTable(
                columns: [
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('Transaction Number')),
                  DataColumn(label: Text('Client Amount')),
                  DataColumn(label: Text('GigWorker Amount')),
                  DataColumn(label: Text('Admin Commission')),

                ],
                rows: snapshot.data!
                    .map((payment) => DataRow(
                  cells: [
                    DataCell(Text(payment['id'].toString())),
                    DataCell(Text(payment['transactionNumber'])),
                    DataCell(Text(payment['amount'].toString())),
                    DataCell(Text('${payment['amount']-payment['adminCommission']}')),
                    DataCell(Text(payment['adminCommission'].toString())),
                  ],
                ))
                    .toList(),
              );
            }
          },
        ),
        SizedBox(height: 40),
        
      ],
    );
  }

  Widget buildCard(String title, Future<num> data) {
    return Card(
      clipBehavior: Clip.hardEdge,
      surfaceTintColor: Colors.white,
      color: Colors.white,
      elevation: 5.0,

      margin: EdgeInsets.all(16.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
    style: GoogleFonts.poppins(textStyle: const TextStyle(
    color:  Color(0XFFC8C8C8),
    fontSize: 15,
            ),)),
            SizedBox(height: 8.0),
            FutureBuilder<num>(
              future: data,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                } else {
                  return Text(
                    title=='Balance'?"${snapshot.data} ETB":"${snapshot.data}",
                    style: GoogleFonts.poppins(textStyle: const TextStyle(
                      color:   Color(0XFF909300),
                      fontSize: 18,
                    ),),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
class ChartData {
  final String x;
  final double y;

  ChartData(this.x, this.y);

  @override
  String toString() {
    return 'ChartData(x: $x, y: $y)';
  }
}
