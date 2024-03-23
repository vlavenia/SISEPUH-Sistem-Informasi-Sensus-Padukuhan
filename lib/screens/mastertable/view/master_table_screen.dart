import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sisepuh/controller/auth_controller.dart';
import 'package:sisepuh/controller/bottomnavbar_controller.dart';
import 'package:sisepuh/screens/mastertable/view/formview.dart';
import 'package:sisepuh/services/countfirebase_service.dart';
import 'package:sisepuh/widget/bottomnav_widget.dart';
import 'package:sisepuh/widget/header_nav.dart';
import 'package:sisepuh/screens/Home/widget/navigation_drawer.dart';
import 'package:sisepuh/screens/mastertable/widget/streambuilder_data.dart';
import 'package:sisepuh/screens/Home/widget/text_search.dart';

class MasterTableScreen extends StatefulWidget {
  const MasterTableScreen({Key? key}) : super(key: key);

  @override
  State<MasterTableScreen> createState() => _MasterTableScreenState();
}

class _MasterTableScreenState extends State<MasterTableScreen> {
  var db = FirebaseFirestore.instance;
  var countFirebase = CountFirebase();
  User? loged = AuthController().getCurrentUser();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          centerTitle: true,
          title: Text(
            "Data Penduduk Kentolan Lor",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.transparent,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.blue,
                  Colors.purple
                ], // Ganti dengan warna yang Anda inginkan
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Padding(
              //   padding: const EdgeInsets.all(15),
              //   child: TextSearchField(),
              // ),

              Container(
                // padding: EdgeInsets.all(16),
                child: Streambuilderdata(
                  refreshCallback: () {},
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: loged!.email == 'testdukuhh@gmail.com'
            ? Text("")
            : FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FormView()),
                  );
                },
              ));
  }
}
