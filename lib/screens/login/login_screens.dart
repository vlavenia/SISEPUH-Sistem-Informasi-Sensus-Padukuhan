import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:sisepuh/controller/auth_controller.dart';
import 'package:sisepuh/controller/formdata_controller.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var Auth = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Login / Sign Up"),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(hintText: "Email "),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(hintText: "Password "),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    final String email = emailController.text.trim();
                    final String password = passwordController.text.trim();

                    if (email.isEmpty) {
                      print("Email Is Empty");
                    } else if (password.isEmpty) {
                      print("Password is Empty");
                    } else {
                      // context.read<AuthService>().login(
                      //       email,
                      //       password,
                      //     );
                      Auth.loginController(email, password);
                      print(
                          "Login_Screen () => data email yang login : ${email}");
                    }
                  },
                  child: Text("Login"),
                ),
                const SizedBox(
                  width: 20.0,
                ),
                ElevatedButton(
                    onPressed: () async {
                      final String email = emailController.text.trim();
                      final String password = passwordController.text.trim();

                      if (password.isEmpty) {
                        print("Email Is Empty");
                      } else if (password.isEmpty) {
                        print("Password is Empty");
                      } else {
                        await Auth.signUpController(email, password);

                        // User? user = FirebaseAuth.instancse.currentUser;
                        var user = Auth.getUser;
                        await FirebaseFirestore.instance
                            .collection("users")
                            .doc(user!.uid)
                            .set({
                          'uid': user.uid,
                          'email': email,
                          'password': password, // ini dynamics
                          'rt': 02 //betul
                        });
                      }
                    },
                    child: Text("Register")),
              ],
            )
          ],
        ),
      ),
    );
  }
}
