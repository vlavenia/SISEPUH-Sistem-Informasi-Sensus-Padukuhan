import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sisepuh/screens/form_view.dart';
import 'package:sisepuh/widget/header_nav.dart';
import 'package:sisepuh/widget/navigation_drawer.dart';
import 'package:sisepuh/widget/streambuilder_data.dart';
import 'package:sisepuh/widget/text_search.dart';

class MasterTableScreen extends StatefulWidget {
  const MasterTableScreen({Key? key}) : super(key: key);

  @override
  State<MasterTableScreen> createState() => _MasterTableScreenState();
}

class _MasterTableScreenState extends State<MasterTableScreen> {
  var db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerCustom(),
      appBar: headerNav(title: 'Data Penduduk RT 02'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextSearchField(),
            ),
            Streambuilderdata(db: db),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FormView()),
          );
        },
      ),
    );
  }
}

