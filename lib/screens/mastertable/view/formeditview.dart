import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sisepuh/controller/auth_controller.dart';
import 'package:sisepuh/controller/formdata_controller.dart';
import 'package:sisepuh/screens/Home/View/home_screen.dart';
import 'package:sisepuh/services/countfirebase_service.dart';
import 'package:sisepuh/widget/bottomnav_widget.dart';
import 'package:sisepuh/widget/header_nav.dart';

class FormEditView extends StatelessWidget {
  FormEditView({Key? key, this.item}) : super(key: key);
  QueryDocumentSnapshot? item;
  var FromdataController = Get.put(FromDataController());
  var countFirebase = Get.put(CountFirebase());
  //var formattedDate = DateTime.now().toString();
  final List<String> genderItems = [
    'laki-laki',
    'perempuan',
  ];

  User? loged = AuthController().getCurrentUser();

  var enabledRTDropdown = true; //dikondisikan nanti

  String? selectedValue;

  var selectdedgender;
  final List<String> rtItems = [
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
  ];
  String? selectedValueRT;

  var difference;
  var countAge;

  @override
  Widget build(BuildContext context) {
    if (loged!.email != 'dukuhkentolanlor@gmail.com') {
      print('=> user loged suscessfully email: ${loged!.email}');
      enabledRTDropdown = false;
    }

    print('=> user loged email: ${loged!.email}');
    print("=> [formeditview] item: $item");
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
                      // controller: FromdataController.namaC,
                      // initialValue: FromdataController.namaC.text,
                      initialValue: item!['nama'],
                      decoration: InputDecoration(
                        labelText: 'Nama',
                        labelStyle: TextStyle(fontSize: 14),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                      ),
                      onChanged: (value) {
                        FromdataController.namaC.text = value;
                      },
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
                      // initialDateTime: DateTime(1970 - 1 - 2),
                      initialDateTime:
                          DateTime.parse('${item!['birthdate']} 00:00:00.000'),
                      onDateTimeChanged: (DateTime newDateTime) {
                        // print('=> datetime current ${item!['birthdate']} ');
                        FromdataController.formattedDate =
                            DateFormat('yyyy-MM-dd').format(newDateTime);
                        difference = DateTime.now()
                            .difference(DateTime.parse(
                                FromdataController.formattedDate))
                            .inDays;
                        countAge = (difference ~/ 365).round();
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
                        ' Pilih Gender',
                        style: TextStyle(fontSize: 14),
                      ),
                      value: item!['gender'].toString(),
                      items: genderItems
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
                          return 'Please select gender.';
                        }
                        return null;
                      },
                      onChanged: (String? value) {
                        print('=> gender selected ${value}');
                        print(
                            '=> gender selected default ${this.item!['gender']}');
                        FromdataController.selectedgender = value;
                        // selectedValue = value;
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
                  const SizedBox(
                    height: 25.0,
                  ),
                  enabledRTDropdown == false
                      ? Text("RT Disabled")
                      : Container(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: DropdownButtonFormField2(
                            isExpanded: true,
                            decoration: InputDecoration(
                                // Add Horizontal padding using menuItemStyleData.padding so it matches
                                // the menu padding when button's width is not specified.
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                border: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey))
                                // Add more decoration..
                                ),
                            hint: const Text(
                              ' RT Berapa?',
                              style: TextStyle(fontSize: 14),
                            ),
                            value: item!['rt'].toString(),
                            items: rtItems
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
                                return 'Select Your RT.';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              // onselectedrt = value;
                            },
                            onSaved: (value) {
                              // selectedValue = value.toString();
                            },
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
                        )
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
                      FromdataController.AddDataMethod(
                        formattedDate: FromdataController.formattedDate,
                        countAge: countAge,
                      );
                      // print(
                      //     "data formattedDate: ${FromdataController.formattedDate}");
                      FromdataController.getDataMethods();

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => bottomNavbar()),
                      );
                      print(
                          "Data Gender yang didapat ======== ${FromdataController.selectedgender}");

                      //Get.to(bottomNavbar());
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
