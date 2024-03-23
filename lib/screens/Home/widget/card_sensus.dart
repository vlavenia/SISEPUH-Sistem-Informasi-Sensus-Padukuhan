import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sisepuh/services/countfirebase_service.dart';

class CardSensus extends StatelessWidget {
  CardSensus({super.key});
  var countFirebase = Get.put(CountFirebase());

  @override
  Widget build(BuildContext context) {
    // List<int> rt = [
    //   // countFirebase.dataRt,
    //   01,
    //   02,
    //   03,
    //   04,
    //   05,
    //   06,
    // ];
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(),
      child: GetBuilder<CountFirebase>(
        init: CountFirebase(),
        initState: (_) => countFirebase.getAllColection2(),
        builder: (_) {
          // total data
          int totalData = 0;
          for (var i = 1; i <= countFirebase.rtUser.length; i++) {
            totalData = totalData + countFirebase.results[i]!;
          }
          return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            // for (var i in countFirebase.rtUser)
            for (var i = 1; i <= countFirebase.rtUser.length; i++) Text(
                // "Data Penduduk Rt $i : ${countFirebase.results[i] != 0 && countFirebase.results[i] != null ? ((countFirebase.results[i]! / countFirebase.total) * 100) : 0}% | ${countFirebase.results[i]} Penduduk "),
                "Data Penduduk Rt $i : ${countFirebase.results[i] != 0 ? ((countFirebase.results[i]! / totalData) * 100) : 0} % | ${countFirebase.results[i]} Penduduk "),
          ]);
        },
      ),
    );
  }
}
