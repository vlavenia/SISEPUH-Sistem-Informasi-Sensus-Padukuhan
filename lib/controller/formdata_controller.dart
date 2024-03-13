import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random_string/random_string.dart';
// import 'package:sisepuh/controller/auth_controller.dart';
import 'package:sisepuh/model/model_data_firebase.dart';
import 'package:sisepuh/services/countfirebase_service.dart';
// import 'package:sisepuh/services/auth_service.dart';
// import 'package:sisepuh/services/countfirebase_service.dart';
import 'package:sisepuh/services/firebase_service.dart';

class FromDataController extends GetxController {
  final FirebaseService _firebaseService = FirebaseService();
  var countFirebase = Get.put(CountFirebase());
  // final CountFirebase _countFirebase = CountFirebase();
  // final AuthService _authService = AuthService();
  // final AuthController _authController = AuthController();

  var Rt;
  int ids = 1;
  final List<String> rtUser = [
    'RT01',
    'RT02',
    'RT03',
    'RT04',
    'RT05',
    'RT06',
    'Pak Dukuh',
  ];

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
  var numAllData;
  //var countAge;
  var numLansia;
  var numDewasa;
  var numRemaja;
  var numAnak;
  //var counNumLansia;
  //var counNumLansia;
  var presentaseUsia;
  var role;
  var namaRole;
  var selectedgender;
  var isLoggedIn = false.obs;

  //User? user = FirebaseAuth.instance.currentUser;
  @override
  void onInit() {
    super.onInit();

    FirebaseAuth.instance.authStateChanges().listen((user) {
      isLoggedIn.value = user != null;
    });
    //getRole();
    // _countFirebase.getallCollection();
    //getDataMethods();
  }

  // void getRole() {
  //   if (user!.email == 'testkentolan2@gmail.com') {
  //     Rt = rtUser[1];
  //   } else if (user!.email == "testkentolan3@gmail.com") {
  //     Rt = rtUser[2];
  //   } else if (user!.email == "PadukuhankentolanLor@gmail.com") {
  //     Rt = rtUser[6];
  //   } else {
  //     print("Rt Tidak ditemukan");
  //   }
  // }

  //==================== Create Data ===============================//

  void AddDataMethod({formattedDate, countAge}) async {
    String id = randomAlphaNumeric(10);
    Rt = countFirebase.selectedRt;

    var datapenduduk = DataModelPenduduk(
        id: id,
        nama: namaC.text,
        birthdate: formattedDate,
        gender: selectedgender,
        rt: Rt,
        age: countAge,
        dateTime: DateTime.now());

    _firebaseService.AddProduct(datapenduduk.toJson(), id, Rt);

    update();
  }
  //===========================================================//

  //buat func ke firebase
  // void addDataMethods({formattedDate, countAge}) async {
  //   //var onformattedDate = formattedDate;
  //   //buat variabel untuk mengisi value di model data
  //   //var formattedDate = DateFormat('yyyy-MM-dd').format(newDateTime);

  //   var getDoc = await db.collection("users").doc(user!.uid).get();
  //   var currRole = getDoc['role']; //get role dari user
  //   var currRT = getDoc['rt']; // get rt dari user
  //   var RTs = ''; // pembuatan variable

  //   // Ketika Role pedukuhan, rt berdasarkan input di inputform
  //   // Semangat :)
  //   if (currRole == 1) {
  //     //RT = formRT.text //misal, tergantung dari inputform
  //     RTs = '99';
  //   } else {
  //     // ketika yang login bukan dukuh, maka rt diambil berdasarkan ketua rt tersebut
  //     RTs = currRT;
  //   }

  //   // var datapenduduk = DataModelPenduduk(
  //   //     id: id,
  //   //     nama: namaC.text,
  //   //     birthdate: formattedDate,
  //   //     gender: selectedgender,
  //   //     rt: RT,
  //   //     age: countAge);
  //   //isi variabel tsb ke query firebase

  //   // await db
  //   //     .collection("users")
  //   //     .doc(user!.uid)
  //   //     .collection("penduduk")
  //   //     .add(datapenduduk.toJson())
  //   //     .whenComplete(() => printInfo(
  //   //         info: "Data Penduduk ${namaC.text} berhasil ditambahkan"));

  //   // await db.collection("penduduk").add(datapenduduk.toJson()).whenComplete(
  //   //     () => printInfo(info: "Data Penduduk berhasil ditambahkan"));

  //   update();
  // }

  //==================== Read Data ===============================//
  void getDataMethods() async {
    // _countFirebase.getallCollection();

    // // var getDoc = await db.collection("users").doc(user!.uid).get();
    // // var currRole = getDoc['role'];
    // // // print('Data User  currentUser => $currRole');
    // // // print('Data Role  currentUser => $getDoc');
    // // for (var data in getdata.docs) {
    // //   dataList.add(DataModelPenduduk.fromJson(data.data()));
    // // }
    // update();

    //untuk display pak dukuh
  }
  //===========================================================//

  // Future getNumGender(String gender) async {
  //   //Query Firestore
  //   // Cek user apakah acc pak dukuh atau bukan
  //   var getNumGender = await db
  //       .collection("users")
  //       .doc(user!.uid)
  //       .collection("penduduk")
  //       .where('gender', isEqualTo: gender) // betul
  //       .get();
  //   if (gender == "perempuan") {
  //     NumGenderp = getNumGender.docs.length;
  //   } else {
  //     NumGenderl = getNumGender.docs.length;
  //   }
  //   update();
  //   //print("data == ${getNumGender.docs.length}");
  // }

  // Future getNumUsia({var countAge}) async {
  //   // var getNum = await db
  //   //     .collection("users")
  //   //     .doc(user!.uid)
  //   //     .collection("penduduk")
  //   //     .where('age', isGreaterThanOrEqualTo: countAge)
  //   //     .get();
  //   if (countAge == 46) {
  //     var getNum = await db
  //         .collection("users")
  //         .doc(user!.uid)
  //         .collection("penduduk")
  //         .where('age', isGreaterThanOrEqualTo: 46)
  //         .get();
  //     numLansia = getNum.docs.length;
  //     print("value countAge == 46 berhasil dijalankan");
  //   } else if (countAge == 26) {
  //     var getNum = await db
  //         .collection("users")
  //         .doc(user!.uid)
  //         .collection("penduduk")
  //         .where('age', isLessThan: 46, isGreaterThanOrEqualTo: 26)
  //         .get();
  //     numDewasa = getNum.docs.length;
  //     print("value countAge == 26 berhasil dijalankan");
  //   } else if (countAge == 12) {
  //     var getNum = await db
  //         .collection("users")
  //         .doc(user!.uid)
  //         .collection("penduduk")
  //         .where('age', isLessThan: 26, isGreaterThanOrEqualTo: 12)
  //         .get();
  //     numRemaja = getNum.docs.length;
  //     // print("value countAge == 12 berhasil dijalankan");
  //   } else if (countAge == 5) {
  //     var getNum = await db
  //         .collection("users")
  //         .doc(user!.uid)
  //         .collection("penduduk")
  //         .where('age', isLessThan: 12)
  //         .get();
  //     numAnak = getNum.docs.length;
  //   } else {
  //     print("tidak ada");
  //   }
  //   // print(
  //   //     "Jumlah variabel numLansia func GetNumUsia 1 ==== ${numLansia} ==== ");
  //   // print(
  //   //     "Jumlah variabel numDewasa func GetNumUsia 2 ==== ${numDewasa} ==== ");
  //   // print(
  //   //     "Jumlah variabel numRemaja func GetNumUsia 3 ==== ${numRemaja} ==== ");
  //   // print("Jumlah variabel numAnak func GetNumUsia 4 ====  ${numAnak} ==== ");
  //   presentaseUsia = numLansia + numDewasa + numRemaja + numAnak;
  //   update();
  // }

  Future calculateAge(DateTime birth) async {
    DateTime now = DateTime.now();
    Duration age = now.difference(birth);
    int years = age.inDays ~/ 365;
    update();
  }

  // Future getUserRole() async {
  //   // Ambil informasi peran pengguna dari objek User
  //   // Misalnya, Anda memiliki objek User yang disimpan dalam variabel currentUser
  //   var getRole = await db.collection("users").doc(user!.uid).get();
  //   print('debugs=> user $user');
  //   print('debugs=> Role $getRole');

  //   //role = getRole['email'];
  //   if (getRole.exists) {
  //     // Mengambil atribut 'nama_atribut' dari dokumen
  //     role = getRole['rt'];
  //     namaRole = getRole['nama'];

  //     // Gunakan atribut sesuai kebutuhan Anda
  //     print('Nilai atribut: $role');
  //   } else {
  //     print('Dokumen tidak ditemukan.');
  //   }

  //   update();
  // }

  // Future getAllData() async {
  //   // Ini dynamics
  //   var getNum = await db
  //       .collection("users")
  //       .doc(user!.uid)
  //       .collection("penduduk")
  //       .where('age', isLessThan: 12)
  //       .get();
  // }
  // Kalau buat pembeda gtu biasanya pake role, cuma kalau misalkan cuma satu akun aja(Pak dukuh A), mkanya klo kek gtu langsung aja ditanem hardcode spesifics ke akun gpp
}
