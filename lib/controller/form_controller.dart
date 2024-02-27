// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:random_string/random_string.dart';
// import 'package:sisepuh/main.dart';
// import 'package:sisepuh/screens/form_view.dart';
// import 'package:sisepuh/services/firestore_firebase.dart';

// class FormController extends State<FormView> {
//   static late FormController instance;
//   late FormView view;

//   @override
//   void initState() {
//     instance = this;

//     super.initState();
//   }

//   @override
//   void dispose() => super.dispose();

//   @override
//   Widget build(BuildContext context) => widget.build(context, this);

//   String? productName;
//   int? Quantity;
//   String? location;
//   String? id;

//   Map<String, dynamic> productInfoMap = {};

//   Map<String, dynamic> additem() {
//     return productInfoMap;
//   } //function untuk mengambil seluruh data dari view

//   save() {
//     String id = randomAlphaNumeric(10);
//     final user = <String, dynamic>{
//       "id": id,
//       "name": "test",
//       "birthdate": "20010219",
//       "gender": "p"
//     };
//     db
//         .collection("penduduk")
//         .add(user)
//         .then((DocumentReference doc) =>
//             print('DocumentSnapshot added with ID: ${doc.id}'))
//         .then((value) => Fluttertoast.showToast(
//             msg: "Product Details has been uploaded successfully",
//             toastLength: Toast.LENGTH_SHORT,
//             gravity: ToastGravity.CENTER,
//             timeInSecForIosWeb: 1,
//             backgroundColor: Colors.red,
//             textColor: Colors.white,
//             fontSize: 16.0));
//   }
// }
