import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sisepuh/controller/formdata_controller.dart';
import 'package:sisepuh/screens/Home/View/home_screen.dart';
import 'package:sisepuh/widget/bottomnav_widget.dart';
import 'package:sisepuh/widget/header_nav.dart';

class FormView extends StatelessWidget {
  FormView({super.key});
  var FromdataController = Get.put(FromDataController());
  var formattedDate = DateTime.now().toString();
  final List<String> genderItems = [
    'Laki-Laki',
    'Perempuan',
  ];
  final List<String> rtItems = [
    'RT01',
    'RT02',
    'RT03',
    'RT04',
    'RT05',
    'RT06',
  ];
  @override
  Widget build(BuildContext context) {
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
                      controller: FromdataController.namaC,
                      // initialValue: 'admin@gmail.com',
                      decoration: InputDecoration(
                        labelText: 'Nama',
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
                        ' Pilih Gender',
                        style: TextStyle(fontSize: 14),
                      ),
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
                      onChanged: (value) {
                        //onselectedGender = value;
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
                  Container(
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
                      FromdataController.addDataMethods(
                          formattedDate: formattedDate);

                      FromdataController.getDataMethods();
                      Get.to(bottomNavbar());
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
