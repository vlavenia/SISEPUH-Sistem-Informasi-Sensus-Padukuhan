import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';
import 'package:random_string/random_string.dart';
import 'package:sisepuh/model/model_data_firebase.dart';

class FromDataController extends GetxController {
  TextEditingController namaC = TextEditingController();
  TextEditingController birthdateC = TextEditingController();
  TextEditingController genderC = TextEditingController();
  TextEditingController rtC = TextEditingController();
  var formattedDate = DateTime.now().toString();

//model data dibuat tipe RX
  var dataList = RxList<DataModelPenduduk>();
  final db = FirebaseFirestore.instance;
  var NumGenderp;
  var NumGenderl;
  var numData;
  //var countAge;
  var numLansia;
  var numDewasa;
  var numRemaja;
  var numAnak;
  //var counNumLansia;
  //var counNumLansia;
  var presentaseUsia;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getDataMethods();
  }

  //buat func ke firebase
  void addDataMethods({formattedDate, countAge}) async {
    String id = randomAlphaNumeric(10);
    //var onformattedDate = formattedDate;

    //buat variabel untuk mengisi value di model data

    //var formattedDate = DateFormat('yyyy-MM-dd').format(newDateTime);
    var datapenduduk = DataModelPenduduk(
        id: id,
        nama: namaC.text,
        birthdate: formattedDate,
        gender: "laki-laki",
        rt: "02",
        age: countAge);
    //isi variabel tsb ke query firebase
    await db.collection("penduduk").add(datapenduduk.toJson()).whenComplete(
        () => printInfo(info: "Data Penduduk berhasil ditambahkan"));

    update();
  }

  void getDataMethods() async {
    var getdata = await db.collection("penduduk").get();
    for (var data in getdata.docs) {
      dataList.add(DataModelPenduduk.fromJson(data.data()));
    }
    numData = getdata.docs.length;
    update();
  }

  Future getNumGender(String gender) async {
    //Query Firestore
    var getNumGender = await db
        .collection("penduduk")
        .where('gender', isEqualTo: gender)
        .get();
    if (gender == "perempuan") {
      NumGenderp = getNumGender.docs.length;
    } else {
      NumGenderl = getNumGender.docs.length;
    }
    update();
    //print("data == ${getNumGender.docs.length}");
  }

  Future getNumUsia({var countAge}) async {
    var getNum = await db
        .collection("penduduk")
        .where('age', isGreaterThanOrEqualTo: countAge)
        .get();
    if (countAge == 46) {
      var getNum = await db
          .collection("penduduk")
          .where('age', isGreaterThanOrEqualTo: 46)
          .get();
      numLansia = getNum.docs.length;
      print("value countAge == 46 berhasil dijalankan");
    } else if (countAge == 26) {
      var getNum = await db
          .collection("penduduk")
          .where('age', isLessThan: 46, isGreaterThanOrEqualTo: 26)
          .get();
      numDewasa = getNum.docs.length;
      print("value countAge == 26 berhasil dijalankan");
    } else if (countAge == 12) {
      var getNum = await db
          .collection("penduduk")
          .where('age', isLessThan: 26, isGreaterThanOrEqualTo: 12)
          .get();
      numRemaja = getNum.docs.length;
      // print("value countAge == 12 berhasil dijalankan");
    } else if (countAge == 5) {
      var getNum =
          await db.collection("penduduk").where('age', isLessThan: 12).get();
      numAnak = getNum.docs.length;
    } else {
      print("tidak ada");
    }
    // print(
    //     "Jumlah variabel numLansia func GetNumUsia 1 ==== ${numLansia} ==== ");
    // print(
    //     "Jumlah variabel numDewasa func GetNumUsia 2 ==== ${numDewasa} ==== ");
    // print(
    //     "Jumlah variabel numRemaja func GetNumUsia 3 ==== ${numRemaja} ==== ");
    // print("Jumlah variabel numAnak func GetNumUsia 4 ====  ${numAnak} ==== ");
    presentaseUsia = numLansia + numDewasa + numRemaja + numAnak;
    update();
  }

  Future calculateAge(DateTime birth) async {
    DateTime now = DateTime.now();
    Duration age = now.difference(birth);
    int years = age.inDays ~/ 365;
    update();
  }
}
