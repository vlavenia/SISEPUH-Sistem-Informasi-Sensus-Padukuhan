import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get_state_manager/get_state_manager.dart';
import 'dart:async' show future;
import 'package:random_string/random_string.dart';
import 'package:sisepuh/controller/formdata_controller.dart';

List<List<dynamic>> data = [];
String id = randomAlphaNumeric(10);

class ImportCsv extends GetxController {
  void importData() async {
    final CollectionReference datapenduduk =
        FirebaseFirestore.instance.collection("penduduk");

    // final myData = await rootBundle.loadString("assets/csv/datapenduduk.csv");
    final myData = await rootBundle.loadString("assets/csv/datapenduduk.csv");

    List<List<dynamic>> csvTable = CsvToListConverter().convert(myData);
    // trs dimasukin ke list data
    data = csvTable;
    print("sudah sampai sini 1 ${data}");
    print("sudah sampai sini 2 csv  ${csvTable}");

    for (var i = 0; i < data.length; i++) {
      print("masuk num  loop ke - ${i}");
      print("[ImportCSV] masuk num  loop No - ${data[i][0]}");
      var record = {
        'id': id,
        'nama': data[i][1],
        'birthdate': data[i][2],
        'gender': data[i][3],
        'rt': "0${data[i][4]}",
        // age: countAge,
        'dateTime': DateTime.now()
      };
      datapenduduk.add(record);
      print("[ImportCSV] sudah sampai sini ${data[i][0]} =>  ${record}");
    }
  }
}
