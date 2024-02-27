import 'package:flutter/material.dart';

class recentData extends StatelessWidget {
  const recentData({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Recent History", style: TextStyle(fontSize: 20)),
        const SizedBox(
          height: 16.0,
        ),
        DataTable(columns: [
          DataColumn(label: Text("Nama")),
          DataColumn(label: Text("Tgl Lahir")),
          DataColumn(label: Text("Gender")),
        ], rows: [
          DataRow(cells: [
            DataCell(Text("Vega Lavenia")),
            DataCell(Text("2001-02-19")),
            DataCell(Text("P")),
          ]),
          DataRow(cells: [
            DataCell(Text("Ahmad Akbar Hizbullah")),
            DataCell(Text("2000-10-11")),
            DataCell(Text("P")),
          ]),
        ])
      ],
    );
  }
}
