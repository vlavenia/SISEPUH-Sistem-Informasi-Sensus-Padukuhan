import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sisepuh/constant.dart';
import 'package:sisepuh/controller/auth_controller.dart';
import 'package:sisepuh/screens/dashboard/view/dashboard_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sisepuh/screens/Home/View/home_screen.dart';
import 'package:sisepuh/screens/login/login_screens.dart';
import 'package:sisepuh/screens/mastertable/widget/form_view.dart';
import 'package:sisepuh/services/countfirebase_service.dart';
import 'package:sisepuh/widget/bottomnav_widget.dart';
import 'firebase_options.dart';

var AuthDataController = Get.put(AuthController());
var db = FirebaseFirestore.instance.collection('penduduk');
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  // @override
  // void initState() {
  //   Get.put(CountFirebase().getCountBirth());
  // }

  @override
  Widget build(BuildContext context) {
    print(
        " [main.dart] AuthDataController.isLoggedIn.value : ${AuthDataController.isLoggedIn.value}");
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SI-Sepuh',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            // ···
            brightness: Brightness.light,
          ),
          textTheme: GoogleFonts.urbanistTextTheme(Theme.of(context).textTheme),
        ),
        // theme: ThemeData.light().copyWith(
        //   textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
        //       .apply(bodyColor: Colors.white),
        //   canvasColor: secondaryColor,
        // ),

        home: Obx(() => AuthDataController.isLoggedIn.value
            ? bottomNavbar()
            : LoginScreen()));
  }
}
