import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sisepuh/constant.dart';
import 'package:sisepuh/controller/auth_controller.dart';
import 'package:sisepuh/screens/mastertable/view/formeditview.dart';
import 'package:sisepuh/services/countfirebase_service.dart';
import 'dart:async';

class Streambuilderdata extends StatelessWidget {
  Streambuilderdata({
    super.key,
    this.takes,
  });
  late int? takes;

  var db = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  //var countFirebase = Get.put(CountFirebase());
  bool sort = true;
  var valuesearch;

  // var itemToEdit = FormEditView();
  var itemToEdit = Get.put(FormEditView());
  var countFirebasee = Get.put(CountFirebase());
  var authConfig;

  TextEditingController keywordSearchC = TextEditingController();

  User? loged = AuthController().getCurrentUser();
  var userCollection = AuthController().getCurrentUserCollection();
  var authController = Get.put(AuthController());

  var enableAdd = true; //dikondisikan add button

  //===================Get Collection===========================
//  Stream<List<QuerySnapshot>> combineCollections() {
//     StreamController<List<QuerySnapshot>> controller = StreamController();

//     List<Stream<QuerySnapshot>> streams = [
//       FirebaseFirestore.instance.collection('Data KentolanLor RT02').snapshots(),
//       FirebaseFirestore.instance.collection('Data KentolanLor RT03').snapshots(),
//     ];

//     Future.wait(streams.map((stream) => stream.first)).then((snapshots) {
//       controller.add(snapshots.cast<QuerySnapshot>());
//     });

//     return controller.stream;
//   }
  //==============================================================
  @override
  Widget build(BuildContext context) {
    // userCollection.then((userData) {
    //   print('=> [current user collection] emailss : ${userData['email']}');

    //   if (loged!.email != 'dukuhkentolanlor@gmail.com') {
    //     enableAdd = true;
    //     authConfig = db
    //         .collection("penduduk")
    //         .where("birthdate", whereNotIn: ["T"]).snapshots();
    //   } else {
    //     enableAdd = false;
    //     authConfig = db
    //         .collection("penduduk")
    //         .where("birthdate", whereNotIn: ["T"])
    //         .where("rt", isEqualTo: userData['rt'])
    //         .snapshots();
    //   }
    // });

    // print('==>[stream_builder] user rt: ${authController.userRt}');
    // print('==>[stream_builder] usercol: ${authController.currUserCollection}');
    // print(
    // '==>[stream_builder] usercol 2: ${authController.currUserCollection['rt']}');
    // print('==>[stream_builder] usercurrs: ${authController.currUser}');
    // print('==>[stream_builder] loged: ${loged}');

    if (loged!.email != 'dukuhkentolanlor@gmail.com') {
      enableAdd = true;
      authConfig = db
          .collection("Data KentolanLor ${countFirebasee.selectedRt}")
          .snapshots();
      // print("==>[Stream Builder] kondsi true ini dijalankan ");
    } else {
      // enableAdd = false;
      // authConfig = db
      //     .collection("penduduk")
      //     // .where("rt", isEqualTo: userData['rt'])
      //     .snapshots();
      // // print("==>[Stream Builder] kondsi false ini dijalankan ");
    }

    // print("==> [Stream Builder] data rt : ${countFirebasee.selectedRt}");
    // authConfig = db
    //     .collection("penduduk")
    //     .where("rt", isEqualTo: countFirebasee.selectedRt)
    //     .snapshots();

    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: db
          .collection("Data KentolanLor ${countFirebasee.selectedRt}")
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
                    columns: [
                      DataColumn(
                        label: Text("Nama"),
                      ),
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
                print(
                    "=> [StreamBuilder] keyword yang didapat : ${keywordSearchC.text}");
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    headingRowColor: MaterialStateProperty.all(
                        Color.fromARGB(172, 68, 137, 255)),
                    headingTextStyle: TextStyle(
                        color: Colors.white,
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
                        onLongPress: () async {
                          itemToEdit.selectedValue = item.toString();

                          //itemToEdit.selectedRT = kondisi;
                          // await Get.to(ProductFormView(item: item[index]));

                          print(
                              "=> [stream builder] long press item ${item.toString()}");
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FormEditView(item: item)),
                          );
                          print(
                              "=> [stream builder] long press itemtoedit ${itemToEdit.item}");
                        },
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
