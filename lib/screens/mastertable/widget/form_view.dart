// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:random_string/random_string.dart';
import 'package:sisepuh/main.dart';
import 'package:sisepuh/widget/header_nav.dart';
import 'package:flutter/cupertino.dart';

class FormView extends StatefulWidget {
  FormView({Key? key}) : super(key: key);
  final List<String> genderItems = [
    'Laki-Laki',
    'Perempuan',
  ];
  // final List<String> rtItems = [
  //   'RT01',
  //   'RT02',
  //   'RT03',
  //   'RT04',
  //   'RT05',
  //   'RT06',
  // ];

  @override
  State<FormView> createState() => _FormViewState();
}

class _FormViewState extends State<FormView> {
  @override
  DateTime selectedDate = DateTime.now();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController birthdatecontroller = TextEditingController();
  var formattedDate = DateTime.now().toString();
  int _countagedewasa = 0;

  Widget build(BuildContext context) {
    String? onselectedGender;
    String? onselectedrt;
    return Scaffold(
      appBar: headerNav(title: "Form Input Data Penduduk"),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    margin: const EdgeInsets.only(top: 20),
                    child: TextFormField(
                      controller: namecontroller,
                      // initialValue: 'admin@gmail.com',
                      decoration: InputDecoration(
                        labelText: 'Nama Lengkap',
                        labelStyle: TextStyle(fontSize: 14),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                      ),
                      onChanged: (value) {},
                    ),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  SizedBox(
                    height: 200,
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.date,
                      maximumDate: DateTime.now(),
                      initialDateTime: DateTime(1970, 1, 1),
                      onDateTimeChanged: (DateTime newDateTime) {
                        formattedDate =
                            DateFormat('yyyy-MM-dd').format(newDateTime);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: DropdownButtonFormField2(
                      isExpanded: true,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(fontSize: 14),
                        // Add Horizontal padding using menuItemStyleData.padding so it matches
                        // the menu padding when button's width is not specified.
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 16),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                        // Add more decoration..
                      ),
                      hint: const Text(
                        ' Pilih Gender dulu',
                        style: TextStyle(fontSize: 14),
                      ),
                      items: widget.genderItems
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ))
                          .toList(),
                      validator: (value) {
                        if (value == null) {
                          return 'Please select gender ya.';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        onselectedGender = value;
                      },
                      onSaved: (value) {},
                      buttonStyleData: const ButtonStyleData(
                        padding: EdgeInsets.only(right: 8),
                      ),
                      iconStyleData: const IconStyleData(
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black45,
                        ),
                        iconSize: 24,
                      ),
                      dropdownStyleData: DropdownStyleData(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.blue.shade400),
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                      ),
                    ),
                  ),
                  // const SizedBox(
                  //   height: 25.0,
                  // ),
                  // Container(
                  //   padding: const EdgeInsets.symmetric(horizontal: 30),
                  //   child: DropdownButtonFormField2(
                  //     isExpanded: true,
                  //     decoration: InputDecoration(
                  //         // Add Horizontal padding using menuItemStyleData.padding so it matches
                  //         // the menu padding when button's width is not specified.
                  //         contentPadding:
                  //             const EdgeInsets.symmetric(vertical: 16),
                  //         border: UnderlineInputBorder(
                  //             borderSide: BorderSide(color: Colors.grey))
                  //         // Add more decoration..
                  //         ),
                  //     hint: const Text(
                  //       ' RT Berapa?',
                  //       style: TextStyle(fontSize: 14),
                  //     ),
                  //     items: widget.rtItems
                  //         .map((item) => DropdownMenuItem<String>(
                  //               value: item,
                  //               child: Text(
                  //                 item,
                  //                 style: const TextStyle(
                  //                   fontSize: 14,
                  //                 ),
                  //               ),
                  //             ))
                  //         .toList(),
                  //     validator: (value) {
                  //       if (value == null) {
                  //         return 'Select Your RT.';
                  //       }
                  //       return null;
                  //     },
                  //     onChanged: (value) {
                  //       onselectedrt = value;
                  //     },
                  //     onSaved: (value) {
                  //       // selectedValue = value.toString();
                  //     },
                  //     buttonStyleData: const ButtonStyleData(
                  //       padding: EdgeInsets.only(right: 8),
                  //     ),
                  //     iconStyleData: const IconStyleData(
                  //       icon: Icon(
                  //         Icons.arrow_drop_down,
                  //         color: Colors.black45,
                  //       ),
                  //       iconSize: 24,
                  //     ),
                  //     dropdownStyleData: DropdownStyleData(
                  //       decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(15),
                  //           color: Colors.blue.shade400),
                  //     ),
                  //     menuItemStyleData: const MenuItemStyleData(
                  //       padding: EdgeInsets.symmetric(horizontal: 16),
                  //     ),
                  //   ),
                  // )
                ],
              ),
              const SizedBox(
                height: 30.0,
              ),
              Container(
                width: 330,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        //primary: Colors.blue, // background
                        // foreground
                        ),
                    onPressed: () {
                      String id = randomAlphaNumeric(10);
                      final user = <String, dynamic>{
                        "id": id,
                        "name": namecontroller.text.toString(),
                        "birthdate": formattedDate,
                        "gender": onselectedGender,
                        //"rt": onselectedrt
                      };

                      // Add a new document with a generated ID
                      FirebaseFirestore.instance
                          .collection("penduduk")
                          .add(user)
                          .then((DocumentReference doc) => print(
                              'DocumentSnapshot added with ID: ${doc.id}'));

                      setState(() {
                        _getNumGender() async {
                          //Query Firestore
                          var getNumGender = await db
                              .where('gender', isGreaterThanOrEqualTo: 50)
                              .get();
                          setState(() {
                            _countagedewasa = getNumGender.size;
                          });
                        }
                      });
                    },
                    child: Text("Simpan")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
