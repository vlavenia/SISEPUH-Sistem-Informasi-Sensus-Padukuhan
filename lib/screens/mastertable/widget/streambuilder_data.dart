import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sisepuh/constant.dart';
import 'package:sisepuh/controller/auth_controller.dart';
import 'package:sisepuh/controller/formdata_controller.dart';
import 'package:sisepuh/screens/Home/widget/text_search.dart';
import 'package:sisepuh/screens/mastertable/view/formeditview.dart';
import 'package:sisepuh/screens/mastertable/view/formview.dart';
import 'package:sisepuh/services/countfirebase_service.dart';
import 'dart:async';

class Streambuilderdata extends StatelessWidget {
  final Function() refreshCallback;
  Streambuilderdata({super.key, required this.refreshCallback, this.takes});

  late int? takes;
  int no = 0;
  TextEditingController keywordSearchC2 = TextEditingController();

  var db = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  bool sort = true;
  var valuesearch;
  var currUserCollection;
  var currUserCollectionRT;
  var itemToEdit = Get.put(FormEditView());
  var countFirebasee = Get.put(CountFirebase());
  var authConfig;
  TextEditingController keywordSearchC = TextEditingController();
  User? loged = AuthController().getCurrentUser();
  var userCollection = AuthController().getCurrentUserCollection();
  var authController = Get.put(AuthController());
  var enableAdd = true;

  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> getDatas() async {
    currUserCollection = await db.collection("users").doc(loged!.uid).get();
    currUserCollectionRT = currUserCollection.data()!['rt'];

    print('##=> data from auth curr : $keywordSearchC.text}');

    Stream<QuerySnapshot<Map<String, dynamic>>> stream;
    if (currUserCollectionRT != '00') {
      if (keywordSearchC.text == '') {
        print("###=> keywoard empty ${keywordSearchC.text}");
        stream = await db
            .collection("penduduk")
            .where("rt", isEqualTo: currUserCollectionRT)
            .snapshots();
      } else {
        stream = await db
            .collection("penduduk")
            .where("rt", isEqualTo: currUserCollectionRT)
            .where("gender", isEqualTo: "${keywordSearchC.text}")
            .snapshots();

        print("###=> keywoard exist : ${keywordSearchC.text}");
        // .where("nama", isGreaterThanOrEqualTo: ["Vega"]).snapshots();
      }
    } else {
      stream = await db.collection("penduduk").snapshots();
    }

    return stream;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Stream<QuerySnapshot<Map<String, dynamic>>>>(
      future: getDatas(),
      builder: (context, snapshot) {
        print("==> value Snapshot : ${snapshot.data}");
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.connectionState == snapshot.hasError) {
          return Center(child: Text("Error occurred!"));
        } else if (snapshot.connectionState == ConnectionState.done) {
          return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: snapshot.data,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.none) {
                return Center(child: Text("Check Connection"));
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text("Error occurred!"));
              } else if (snapshot.hasData) {
                var data = snapshot.data!.docs;
                if (takes == 2) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      headingTextStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      columns: [
                        DataColumn(label: Text("No")),
                        DataColumn(label: Text("Nama")),
                        DataColumn(label: Text("Tgl Lahir")),
                        DataColumn(label: Text("Gender")),
                      ],
                      rows: data.take(2).map((item) {
                        no++;
                        return DataRow(
                          cells: [
                            DataCell(Text(no.toString())),
                            DataCell(Text(item["nama"])),
                            DataCell(Text(item["birthdate"])),
                            DataCell(Text(item["gender"])),
                          ],
                        );
                      }).toList(),
                    ),
                  );
                } else {
                  print(
                      "=> [StreamBuilder] keyword yang didapat : ${keywordSearchC.text}");
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      dataTextStyle: TextStyle(
                          fontFamily: 'Open Sans',
                          color: Colors.black,
                          fontSize: 14),
                      headingTextStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      columns: [
                        DataColumn(label: Text("No")),
                        DataColumn(label: Text("Nama")),
                        DataColumn(label: Text("Tgl Lahir")),
                        DataColumn(label: Text("Gender")),
                      ],
                      rows: data.map((item) {
                        no++;
                        return DataRow(
                          cells: [
                            DataCell(Text(no.toString())),
                            DataCell(Text(item["nama"])),
                            DataCell(Text(item["birthdate"])),
                            DataCell(Text(item["gender"])),
                          ],
                          onLongPress: () async {
                            itemToEdit.selectedValue = item.toString();
                            // print(
                            //     "=> [stream builder] long press item ${item.toString()}");
                            // print(
                            //     "=> [stream builder] long press item  IDs${item.id}");
                            await Get.to(FormView(item: item));
                            // await Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => FormEditView(item: item),
                            //   ),
                            // );
                            // print(
                            //     "=> [stream builder] long press itemtoedit ${itemToEdit.item}");
                          },
                        );
                      }).toList(),
                    ),
                  );
                }
              } else {
                debugPrint("What went wrong");
                return SizedBox();
              }
            },
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}
