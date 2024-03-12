import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sisepuh/screens/login/login_screens.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:sisepuh/services/auth_service.dart';
import 'package:sisepuh/widget/bottomnav_widget.dart';

class AuthController extends GetxController {
  var getEmailUser;
    var selectedRt;
  var isLoggedIn = false.obs;
  var getUser;
   var _authServices = AuthService();
  //User? user = FirebaseAuth.instance.currentUser;
  // late Rx<User?> firebaseUser;

  void onInit() {
    super.onInit();
    _authServices.authStateChanges.listen((user) {
      isLoggedIn.value = user != null;
    });
  }

  // void onInit() {
  //   getUser = _authServices.user;
  //   super.onInit();
  //   _authServices.authStateChanges.listen((user) {
  //     isLoggedIn.value = user != null;
  //   });

  //   FirebaseAuth.instance.authStateChanges().listen((User? users) {
  //     this.user = users;
  //   });

  //   print("=> [auth controller] on init  user : ${user}");
  // // }
  //   Future<void> login(String email, String password) async {
  //   await _auth.signInWithEmailAndPassword(email: email, password: password);
  //   print("=> data Current User saat login : $user");
  // }

  void loginController(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      // await _authServices.login(email, password);
      // getEmailUser = email;
      Fluttertoast.showToast(
          msg: "Succes Login",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
        print('=> [auth_Controller] login current user : ${_authServices.currentUser}');
    } catch (firebaseAuthException) {}
  }

  Future<void> signUpController(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print("Eror :$e");
    }
    update();
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}



