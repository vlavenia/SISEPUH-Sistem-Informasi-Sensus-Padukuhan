import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sisepuh/constant.dart';

class Streambuilderdata extends StatelessWidget {
  Streambuilderdata({
    super.key,
    required this.db,
    this.takes,
  });
  late int? takes;
  final FirebaseFirestore db;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: db.collection("penduduk").snapshots(),
      builder: (context, snapshot) {
        var data = snapshot.data!.docs;
        if (takes == 2) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingTextStyle: TextStyle(
                  color: Color(0xFF50E4FF),
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
              columns: [
                DataColumn(label: Text("Nama")),
                DataColumn(label: Text("Tgl Lahir")),
                DataColumn(label: Text("Gender")),
              ],
              rows: data.take(2).map((item) {
                return DataRow(
                  cells: [
                    DataCell(Text(item["name"])),
                    DataCell(Text(item["birthdate"])),
                    DataCell(Text(item["gender"])),
                  ],
                );
              }).toList(),
            ),
          );
        } else {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingTextStyle: TextStyle(
                  color: Color(0xFF50E4FF),
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
              columns: [
                DataColumn(label: Text("Nama")),
                DataColumn(label: Text("Tgl Lahir")),
                DataColumn(label: Text("Gender")),
              ],
              rows: data.map((item) {
                return DataRow(
                  cells: [
                    DataCell(Text(item["name"])),
                    DataCell(Text(item["birthdate"])),
                    DataCell(Text(item["gender"])),
                  ],
                );
              }).toList(),
            ),
          );
        }
      },
    );
  }
}
