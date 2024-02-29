// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables
import 'package:flutter/material.dart';
import 'package:sisepuh/main.dart';
import 'package:sisepuh/screens/mastertable/widget/form_view.dart';
import 'package:sisepuh/widget/header_nav.dart';
import 'package:sisepuh/screens/Home/widget/line_chart.dart';
import 'package:sisepuh/screens/Home/widget/navigation_drawer.dart';
import 'package:sisepuh/screens/Home/widget/pie_chart.dart';
import 'package:sisepuh/screens/Home/widget/recent_data.dart';
import 'package:sisepuh/screens/mastertable/widget/streambuilder_data.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: headerNav(title: "Dashboard"),
      drawer: NavigationDrawerCustom(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // cardtotalpenduduk(),
            // const SizedBox(
            //   height: 4.0,
            // ),
            PieChartSample2(),
            const SizedBox(
              height: 45.0,
            ),
            Streambuilderdata(
              takes: 2,
            ),
            //recentData(),
            const SizedBox(
              height: 30.0,
            ),
            Text(
              "Statistika bulanan",
              style: TextStyle(fontSize: 20),
            ),

            const SizedBox(
              height: 16.0,
            ),
            LineChartSample2(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FormView()),
          );
        },
      ),
    );
  }
}
