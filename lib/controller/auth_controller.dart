import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:sisepuh/services/auth_service.dart';

class AuthController extends GetxController {
  final AuthService _authServices = AuthService();

  var isLoggedIn = false.obs;

  void onInit() {
    super.onInit();
    _authServices.authStateChanges.listen((user) {
      isLoggedIn.value = user != null;
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

        await FirebaseFirestore.instance
            .collection("users")
            .doc(user!.uid)
            .set({
          'uid': user.uid,
          'email': email,
          'password': password,
        });
      });
    } catch (e) {
      print("Eror :$e");
    }
  }

  Future<void> signOutController() async {
    try {
      await _authServices.signOut();
      
    } catch (e) {
      print("Eror :$e");
    }
  }
}
