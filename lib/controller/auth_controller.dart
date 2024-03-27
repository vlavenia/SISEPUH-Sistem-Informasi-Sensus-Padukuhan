import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:sisepuh/screens/login/login_screens.dart';
import 'package:sisepuh/services/auth_service.dart';
import 'package:sisepuh/widget/bottomnav_widget.dart';

class AuthController extends GetxController {
  final AuthService _authServices = AuthService();

  var isLoggedIn = false.obs;
  var currUser;
  var currUserCollection;
  var userRt;
  var db = FirebaseFirestore.instance;

  void onInit() {
    super.onInit();
    _authServices.authStateChanges.listen((user) {
      isLoggedIn.value = user != null;
      if (user != null) {
        // user is logged in
        Get.offAll(() => bottomNavbar());
        print("[Auth_Controller] masuk kondisi pertama");
      } else {
        // user is null as in user is not available or not logged in
        Get.offAll(() => LoginScreen());
      }
      print("[Auth_Controller] user value onInit ==> $user");
      print("[Auth_Controller] isLoggedIn value ==> ${isLoggedIn}");
      print("[Auth_Controller] isLoggedIn value 2 ==> ${isLoggedIn.value}");
    });
  }

  Future<void> loginController(
      TextEditingController email, TextEditingController password) async {
    try {
      await _authServices.login(email.text, password.text);
    } catch (e) {
      print("Eror :$e");
    }
  }

  Future<void> signUpController(
      TextEditingController email, TextEditingController password) async {
    try {
      await _authServices.signUp(email.text, password.text).then((value) async {
        User? user = FirebaseAuth.instance.currentUser;
        print("user value Register : $user");

        // await FirebaseFirestore.instance
        //     .collection("users")
        //     .doc(user!.uid)
        //     .set({
        //   'uid': user.uid,
        //   'email': email,
        //   'password': password,
        // });
       
      });
    } catch (e) {
      print("Eror :$e");
    }
  }

  User getCurrentUser() {
    currUser = _authServices.user;
    return currUser;
  }

  void signOut() async {
    await _authServices.signOut();
  }

  // Stream<QuerySnapshot<Map<String, dynamic>>> getCurrentUserCollection() {
  getCurrentUserCollection() async {
    var emailloc;
    currUserCollection =
        await db.collection("users").doc(_authServices.user!.uid).get();
    emailloc = currUserCollection['email'];
    userRt = currUserCollection['email'];
    // print('=>[auth controller] user auth : ${_authServices.currentUser!.uid}');
    // print('=>[auth controller] user coll : ${currUserCollection['email']}');
    // print('=>[auth controller] user coll : ${userRt}');

    return currUserCollection;
  }
}
