import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';
import 'package:sisepuh/controller/auth_controller.dart';
import 'package:sisepuh/services/auth_service.dart';
import 'package:sisepuh/services/firebase_service.dart';

class CountFirebase extends GetxController {
  // final AuthController _authController = AuthController();
  final FirebaseService _firebaseService = FirebaseService();

  var AuthServices = AuthService();

  var db = FirebaseFirestore.instance;

  var getdata;
  var getNum;
  var numLansia;
  var numDewasa;
  var numRemaja;
  var numAnak;
  var numBalita;
  var presentaseUsia;
  var getGender;
  var NumLengthGenderP;
  var NumLengthGenderL;
  var selectedRt;

  var currUserCollectionRT;
  var Coll;
  var getCol;
  var currUserCollection;
  var NumLength;
  var GetGenderColl;
  var selectedrt;
  var currentrt;
  var NumLengthAge;
  DateTime now = DateTime.now();

  final List<String> rtUser = [
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
  ];

  var NumColData;

  //============== code di bawah ini di Comment ============
  // Future getRtUser() async {
  //   switch (AuthServices.currentUser!.email) {
  //     case 'testkentolan2@gmail.com':
  //       selectedRt = rtUser[1];
  //       break;
  //     case 'testkentolan3@gmail.com':
  //       selectedRt = rtUser[2];
  //       break;
  //     default:
  //       selectedRt = "Pak Dukuh";
  //       break;
  //   }
  //   update();
  //   print("[CountFirebase] data selectedRT : $selectedRt");
  // }
  Future getNumCol() async {
    var getNumColData = await db.collection("penduduk").get();
    NumColData = getNumColData.docs.length;
  }

  //======================== Get All Data ================================
  Future getallCollection() async {
    User? loged = AuthController().getCurrentUser();
    currUserCollection = await db.collection("users").doc(loged!.uid).get();
    currUserCollectionRT = currUserCollection.data()!['rt'];
    if (currUserCollectionRT != '00') {
      getCol = await db
          .collection("penduduk")
          .where("rt", isEqualTo: currUserCollectionRT)
          .get();
      NumLength = getCol.docs.length;
    } else {
      getCol = await db.collection("penduduk").get();
    }
    NumLength = getCol.docs.length;
    update();
  }

  var dataRt;
  num? total;
  var getLength;
  Map<int, int> results = {};
  Future getAllColection2({int? rt}) async {
    total = 0;
    var data = [];
    for (var i = 1; i <= rtUser.length; i++) {
      var rtlop = "0$i";
      print("debugs ==> i value RT : 0$i");
      dataRt =
          await db.collection("penduduk").where("rt", isEqualTo: rtlop).get();
      getLength = dataRt.docs.length;
      results[i] = getLength;
      print("debugs ==> result value :  ${getLength}");

      // tambah semua data
      total = total! + getLength;
      // total = total + int.parse(getLength);
    }
    print("debugs ==> results all value :  ${results}");
    print("debugs ==> results all total :  ${total}");
    //total = 0;

    return results;
  }

  //========================================================================
  //============ Get jmlh Count Gender(Harus pke builder/Stream) =======================
  Future getCountGender({String? gender}) async {
    if (currUserCollectionRT != '00') {
      getGender = await db
          .collection("penduduk")
          .where("rt", isEqualTo: currUserCollectionRT)
          .where('gender', isEqualTo: gender)
          .get();
      print("CountFirebase Gender ==> masuk sini != 00");
      print("#%==> GetGender $getGender");
    } else {
      getGender = await db
          .collection("penduduk")
          .where('gender', isEqualTo: gender)
          .get();
      print("CountFirebase Gender ==> masuk sini == 00");
    }
    // NumLength = getGender.docs.length;
    print("CountFirebase Gender ==> $NumLength");

    if (gender == 'perempuan') {
      NumLengthGenderP = getGender.docs.length;
    } else {
      NumLengthGenderL = getGender.docs.length;
    }

    update();
  }

  //========================================================================
//====================== Get jmlh Count Usia =============================
  Future getCountBirth({num? countAge}) async {
    //Lansia
    if (countAge == 46) {
      DateTime Date1 = now.subtract(Duration(days: 46 * 365));
      String dateFormat = DateFormat('yyyy-MM-dd').format(Date1);
      if (currUserCollectionRT != "00") {
        getNum = await db
            .collection("penduduk")
            .where("rt", isEqualTo: currUserCollectionRT)
            .where("birthdate", isLessThanOrEqualTo: dateFormat)
            .get();
      } else {
        getNum = await db
            .collection("penduduk")
            .where("birthdate", isLessThanOrEqualTo: dateFormat)
            .get();
      }
      numLansia = getNum.docs.length;
    }
    //====================Dewasa==============================

    else if (countAge == 26) {
      DateTime Date1 = now.subtract(Duration(days: 26 * 365));
      DateTime Date2 = now.subtract(Duration(days: 46 * 365));
      if (currUserCollectionRT != "00") {
        getNum = await db
            .collection("penduduk")
            .where("rt", isEqualTo: currUserCollectionRT)
            .where("birthdate", isLessThanOrEqualTo: "${Date1}")
            .where("birthdate", isGreaterThan: "${Date2}")
            .get();
      } else {
        getNum = await db
            .collection("penduduk")
            .where("birthdate", isLessThanOrEqualTo: "${Date1}")
            .where("birthdate", isGreaterThan: "${Date2}")
            .get();
      }
      numDewasa = getNum.docs.length;

      // print("value countAge #==> 26 berhasil dijalankan");
      // print(" [Count Firebase]#==> value NumDewasa : $numDewasa");
    }
    //====================== Remaja ==========================

    else if (countAge == 12) {
      DateTime Date1 = now.subtract(Duration(days: 12 * 365));
      DateTime Date2 = now.subtract(Duration(days: 26 * 365));
      if (currUserCollectionRT != "00") {
        getNum = await db
            .collection("penduduk")
            .where("rt", isEqualTo: currUserCollectionRT)
            .where("birthdate", isLessThanOrEqualTo: "${Date1}")
            .where("birthdate", isGreaterThan: "${Date2}")
            .get();
      } else {
        getNum = await db
            .collection("penduduk")
            .where("birthdate", isLessThanOrEqualTo: "${Date1}")
            .where("birthdate", isGreaterThan: "${Date2}")
            .get();
      }
      numRemaja = getNum.docs.length;

      // print(" [Count Firebase]#==> value NumRemaja : $numRemaja");
    }

    //=================== Anak ===============================

    else if (countAge == 6) {
      DateTime Date1 = now.subtract(Duration(days: 6 * 365));
      DateTime Date2 = now.subtract(Duration(days: 12 * 365));
      if (currUserCollectionRT != "00") {
        getNum = await db
            .collection("penduduk")
            .where("rt", isEqualTo: currUserCollectionRT)
            .where("birthdate", isLessThanOrEqualTo: "${Date1}")
            .where("birthdate", isGreaterThan: "${Date2}")
            .get();
      } else {
        getNum = await db
            .collection("penduduk")
            .where("birthdate", isLessThanOrEqualTo: "${Date1}")
            .where("birthdate", isGreaterThan: "${Date2}")
            .get();
      }
      numAnak = getNum.docs.length;
    }

    // Balita
    else {
      DateTime now = DateTime.now();
      DateTime Date1 = now.subtract(Duration(days: 6 * 365));
      if (currUserCollectionRT != "00") {
        getNum = await db
            .collection("penduduk")
            .where("rt", isEqualTo: currUserCollectionRT)
            .where("birthdate", isGreaterThan: "${Date1}")
            .get();
      } else {
        getNum = await db
            .collection("penduduk")
            .where("birthdate", isGreaterThanOrEqualTo: "${Date1}")
            .get();
      }
      numBalita = getNum.docs.length;
    }
    presentaseUsia = numLansia + numDewasa + numRemaja + numAnak + numBalita;
    update();
  }
}

//     if (countAge == 46) {
//     var getNum = await db
//         .collection("Data KentolanLor $selectedRt")

//         .where('age', isGreaterThanOrEqualTo: 46)
//         .get();
//     numLansia = getNum.docs.length;
//     print("value countAge == 46 berhasil dijalankan");
//   } else if (countAge == 26) {
//     var getNum = await db
//         .collection("users")
//         .doc(_authUser.selectedRt)
//         .collection("penduduk")
//         .where('age', isLessThan: 46, isGreaterThanOrEqualTo: 26)
//         .get();
//     numDewasa = getNum.docs.length;
//     print("value countAge == 26 berhasil dijalankan");
//   } else if (countAge == 12) {
//     var getNum = await db
//         .collection("users")
//         .doc(_authUser.selectedRt)
//         .collection("penduduk")
//         .where('age', isLessThan: 26, isGreaterThanOrEqualTo: 12)
//         .get();
//     numRemaja = getNum.docs.length;
//     // print("value countAge == 12 berhasil dijalankan");
//   } else if (countAge == 5) {
//     var getNum = await db
//         .collection("users")
//         .doc(_authUser.selectedRt)
//         .collection("penduduk")
//         .where('age', isLessThan: 12)
//         .get();
//     numAnak = getNum.docs.length;
//   } else {
//     print("tidak ada");
//   }

//  }
