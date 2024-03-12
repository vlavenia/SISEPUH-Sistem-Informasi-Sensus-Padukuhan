import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sisepuh/constant.dart';
import 'package:sisepuh/controller/formdata_controller.dart';
import 'package:sisepuh/services/countfirebase_service.dart';

var FromdataController = Get.put(FromDataController());
var countFirebase = Get.put(CountFirebase());

AppBar headerNav({required String title}) {
  return AppBar(
    title: GetBuilder<CountFirebase>(
      init: CountFirebase(),
      initState: (_) => countFirebase.getRtUser(),
      builder: (countFirebase) {
        return Text("$title ${countFirebase.selectedRt}");
      },
    ),
    centerTitle: true,
  );
}
