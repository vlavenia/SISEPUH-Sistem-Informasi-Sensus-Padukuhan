import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
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
  int NumLength = 0;
  var NumLengthGenderP;
  var NumLengthGenderL;
  var selectedRt;
  final List<String> rtUser = [
    'RT01',
    'RT02',
    'RT03',
    'RT04',
    'RT05',
    'RT06',
  ];

  Future getRtUser() async {
    switch (AuthServices.currentUser!.email) {
      case 'testkentolan2@gmail.com':
        selectedRt = rtUser[1];
        break;
      case 'testkentolan3@gmail.com':
        selectedRt = rtUser[2];
        break;
      default:
        selectedRt = "Pak Dukuh";
        break;
    }
    update();
    print("[CountFirebase] data selectedRT : $selectedRt");
  }

  //======================== Get All Data ================================
  Future getallCollection() async {
    if (AuthServices.currentUser!.email != "dukuhh@gmail.com") {
      getdata = await _firebaseService.db
         .collection("Data KentolanLor $selectedRt")
          .get();
    } else {
      getdata = await _firebaseService.db.collection("penduduk").get();
    }

    // switch (AuthServices.currentUser!.email) {
    //   case 'testkentolan2@gmail.com':
    //     getdata = await _firebaseService.db
    //         .collection("Data KentolanLor ${rtUser[1]}")
    //         .get();
    //     break;
    //   case 'testkentolan3@gmail.com':
    //     getdata = await _firebaseService.db
    //         .collection("Data KentolanLor ${rtUser[2]}")
    //         .get();
    //     break;
    // }
    NumLength = getdata.docs.length;
    print("ini NumLength nya$NumLength");
    update();

    //  Future getallCollection() async {
    // if (AuthServices.currentUser!.email != 'dukuhkentolanlor@gmail.com') {
    //    getdata = await _firebaseService.db
    //       .collection("penduduk")
    //       .get();
    // }else{

    //}
  }

  //======================== Get jmlh Count Gender ================================
  Future getCountGender(String gender) async {
    // switch (AuthServices.currentUser!.email) {
    //   case 'testkentolan2@gmail.com':
    //     selectedRt = rtUser[1];
    //     break;
    //   case 'testkentolan3@gmail.com':
    //     selectedRt = rtUser[2];
    //     break;
    //   default:
    //     for (var i = 0; i < rtUser.length; i++) {
    //       var item = rtUser[i];
    //       getdata = await _firebaseService.db
    //           .collection("Data KentolanLor $item")
    //           .get();
    //       //NumLength += getdata.docs.length;
    //     }
    //     break;
    // }

    getGender = await db
        // .collection("Data KentolanLor $selectedRt")
        .collection("Data KentolanLor $selectedRt")
        .where('gender', isEqualTo: gender)
        .where('rt', isEqualTo: selectedRt)
        .get();
    if (gender == "laki-laki") {
      NumLengthGenderL = getGender.docs.length;
    } else {
      NumLengthGenderP = getGender.docs.length;
    }

    //getGender = await _firebaseService.db
    //     .collection("Data KentolanLor ${_authController.selectedRt}")
    //     .where('gender', isEqualTo: gender)
    //     .get();
    // if (gender == "laki-laki") {
    //   NumLengthGenderL = getGender.docs.length;
    // } else {
    //   NumLengthGenderP = getGender.docs.length;
    // }
    update();
  }

  //======================== Get jmlh Count Usia ================================
  Future getCountBirth(var countAge) async {
    if (countAge == 46) {
      getNum = await await _firebaseService.db
          .collection("Data KentolanLor $selectedRt")
         
          .where('age', isGreaterThanOrEqualTo: 46)
          .get();
      numLansia = getNum.docs.length;
      print("==>value countAge == 46 berhasil dijalankan");
      print("==> [Count Firebase] value NumLansia : $numLansia");
    } else if (countAge == 26) {
      var getNum = await _firebaseService.db
          .collection("Data KentolanLor $selectedRt")
          .where('age', isLessThan: 46, isGreaterThanOrEqualTo: 26)
          .get();
      numDewasa = getNum.docs.length;
      print("value countAge == 26 berhasil dijalankan");
      print(" [Count Firebase] value NumDewasa : $numDewasa");
    } else if (countAge == 12) {
      var getNum = await _firebaseService.db
          .collection("Data KentolanLor $selectedRt")
          .where('age', isLessThan: 26, isGreaterThanOrEqualTo: 12)
          .get();
      numRemaja = getNum.docs.length;
      print(" [Count Firebase] value NumRemaja : $numRemaja");
    } else if (countAge == 6) {
      var getNum = await _firebaseService.db
          .collection("Data KentolanLor $selectedRt")
          .where('age', isLessThan: 12, isGreaterThanOrEqualTo: 6)
          .get();
      numAnak = getNum.docs.length;
      print(" [Count Firebase] value NumAnak : $numAnak");
    } else if (countAge == 5) {
      var getNum = await _firebaseService.db
          .collection("Data KentolanLor $selectedRt")
          .where('age', isLessThanOrEqualTo: 5)
          .get();
      numBalita = getNum.docs.length;
      print(" [Count Firebase] value NumAnak : $numBalita");
    } else {
      print("tidak ada");
    }
    presentaseUsia = numLansia + numDewasa + numRemaja + numAnak;
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

