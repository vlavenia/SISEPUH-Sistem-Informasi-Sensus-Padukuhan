import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sisepuh/constant.dart';
import 'package:sisepuh/services/countfirebase_service.dart';

class Streambuilderdata extends StatelessWidget {
  Streambuilderdata({
    super.key,
    this.takes,
  });
  late int? takes;

  var db = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  var countFirebase = Get.put(CountFirebase());

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: db
          .collection("Data KentolanLor ${countFirebase.selectedRt}")
          .snapshots(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Center(child: Text("Check Connection"));
          case ConnectionState.waiting:
            return Center(
                child: CircularProgressIndicator(
                    backgroundColor: Theme.of(context).primaryColorLight));
          default:
            if (snapshot.hasError) {
              return Center(child: Text("Error occurred!"));
            } else if (snapshot.hasData) {
              var data = snapshot.data!.docs;
              if (takes == 2) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    headingTextStyle: TextStyle(
                        // color: Color.fromARGB(172, 68, 137, 255),
                        color: Color.fromARGB(172, 68, 137, 255),
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                    sortColumnIndex: 0,
                    sortAscending: false,
                    columns: [
                      DataColumn(label: Text("Nama")),
                      DataColumn(label: Text("Tgl Lahir")),
                      DataColumn(label: Text("Gender")),
                    ],
                    rows: data.take(2).map((item) {
                      return DataRow(
                        cells: [
                          DataCell(Text(item["nama"])),
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
                        color: Color.fromARGB(172, 68, 137, 255),
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                    columns: [
                      DataColumn(label: Text("Nama")),
                      DataColumn(label: Text("Tgl Lahir")),
                      DataColumn(label: Text("Gender")),
                    ],
                    rows: data.map((item) {
                      return DataRow(
                        cells: [
                          DataCell(
                            Text(item["nama"]),
                          ),
                          DataCell(
                            Text(item["birthdate"]),
                          ),
                          DataCell(
                            Text(item["gender"]),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                );
              } // Tampilkan widget dengan data
            } else {
              debugPrint("What went wrong");
              return SizedBox();
            }
        }
      },
    );
  }
}
