import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:random_string/random_string.dart';
import 'package:sisepuh/model/model_data_firebase.dart';

class FromDataController extends GetxController {
  TextEditingController namaC = TextEditingController();
  TextEditingController birthdateC = TextEditingController();
  TextEditingController genderC = TextEditingController();
  TextEditingController rtC = TextEditingController();

//model data dibuat tipe RX
  var dataList = RxList<DataModelPenduduk>();
  final db = FirebaseFirestore.instance;
  var NumGenderp;
  var NumGenderl;
  var numData;
  var numlansia;
  //var counNumLansia;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getDataMethods();
  }

  //buat func ke firebase
  void addDataMethods({var formattedDate}) async {
    String id = randomAlphaNumeric(10);
    //buat variabel untuk mengisi value di model data
    var datapenduduk = DataModelPenduduk(
        id: id,
        nama: namaC.text,
        birthdate: DateTime.now(),
        gender: "laki-laki",
        rt: "02");
    //isi variabel tsb ke query firebase
    await db.collection("penduduk").add(datapenduduk.toJson()).whenComplete(
        () => printInfo(info: "Data Penduduk berhasil ditambahkan"));
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

  Future getNumLansia(String gender) async {
    //Query Firestore
    var getNumLansia =
        await db.collection("penduduk").where('age', isEqualTo: gender).get();

    numlansia = getNumLansia.docs.length;
    update();
    //print("data == ${getNumGender.docs.length}");
  }
}
