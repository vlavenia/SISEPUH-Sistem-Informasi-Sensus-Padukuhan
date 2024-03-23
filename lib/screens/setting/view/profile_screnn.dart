// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:sisepuh/widget/bottomnav_widget.dart';
import 'package:sisepuh/widget/header_nav.dart';
import 'package:sisepuh/screens/Home/widget/navigation_drawer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: headerNav(title: "About Us"),
      body: SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.all(56),
        child: Column(
          children: [
            const SizedBox(
              height: 15.0,
            ),
            Text(
              "SI-SEPUH,\nSistem Informasi Penduduk Padukuhan",
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontFamily: 'Open Sans',
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              "   SI-SEPUH adalah sebuah aplikasi yang dirancang oleh KKNT Kelompok 01 - Kentolan Lor untuk membantu dalam pengelolaan data dan informasi terkait dengan sensus penduduk di padukuhan Kentolan Lor.",
              style: TextStyle(fontSize: 17),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
                "   Melalui SI-SEPUH, pengguna dapat mendaftarkan data individu, seperti nama, tanggal lahir dan jenis kelamin untuk melacak data kependudukan secara keseluruhan.",
                style: TextStyle(fontSize: 17)),
            const SizedBox(
              height: 40.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  "assets/images/logokknt.png",
                  width: 40.0,
                  height: 40.0,
                  fit: BoxFit.fill,
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Text("Kelompok 01 KKNT Kentolan Lor UAA "),
              ],
            )
          ],
        ),
      )),
    );
  }
}
