import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sisepuh/services/countfirebase_service.dart';

class CardSensus extends StatelessWidget {
  CardSensus({super.key});
  var countFirebase = Get.put(CountFirebase());

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
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
            for (var i = 1; i <= countFirebase.rtUser.length; i++)
              Container(
                //s color: Colors.amber,

                padding: EdgeInsets.all(10),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  // /color: Colors.red,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      border: Border.all(
                        width: 0.3,
                        color: const Color.fromARGB(187, 33, 33, 33)!,
                      ),
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Colors.white, Colors.white]),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromARGB(83, 0, 0, 0),
                            blurRadius: 5,
                            offset: Offset(8, 5))
                      ]),
                  padding: EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          // "Data Penduduk Rt $i : ${countFirebase.results[i] != 0 && countFirebase.results[i] != null ? ((countFirebase.results[i]! / countFirebase.total) * 100) : 0}% | ${countFirebase.results[i]} Penduduk "),
                          "Data Penduduk Rt $i : ${countFirebase.results[i] != 0 ? ((countFirebase.results[i]! / totalData) * 100).round() : 0} % "),
                      Text(" ${countFirebase.results[i]} Penduduk")
                    ],
                  ),
                ),
              ),
          ]);
        },
      ),
    );
  }
}
