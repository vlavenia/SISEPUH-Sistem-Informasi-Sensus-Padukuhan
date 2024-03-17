import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sisepuh/controller/formdata_controller.dart';
import 'package:sisepuh/resources/app_color.dart';
import 'package:sisepuh/services/countfirebase_service.dart';
import 'package:sisepuh/widget/indicator_chart.dart';

class PieChartSample2 extends StatelessWidget {
  int touchedIndex = -1;
  int? datacount;
  int? datacountAge;

  var FromdataController = Get.put(FromDataController());
  var countFirebase = Get.put(CountFirebase());

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.1,
      child: Container(
        padding: EdgeInsets.only(top: 17, left: 40),
        child: Row(
          children: <Widget>[
            Container(
              height: 150,
              child: Expanded(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: FutureBuilder<dynamic>(
                      future: countFirebase.getCountBirth(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.connectionState ==
                            ConnectionState.done) {
                          return GetBuilder<CountFirebase>(
                            init: CountFirebase(),
                            initState: (_) => countFirebase.getCountBirth(),
                            builder: (_) {
                              return PieChart(
                                PieChartData(
                                  pieTouchData: PieTouchData(
                                    touchCallback: (FlTouchEvent event,
                                        pieTouchResponse) {},
                                  ),
                                  borderData: FlBorderData(
                                    show: false,
                                  ),
                                  sectionsSpace: 0,
                                  centerSpaceRadius: 40,
                                  sections: showingSections(),
                                ),
                              );
                            },
                          );
                        }
                        return Text("Nothing");
                      }),
                ),
              ),
            ),
            const SizedBox(
              width: 18,
            ),
            Column(
              children: [
                Container(
                  width: 160,
                  child: Center(
                    child: Text(
                      "Kategori  Usia",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
                Container(
                  height: 132,
                  width: 170,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 18,
                          ),
                          GetBuilder<CountFirebase>(
                            init: CountFirebase(),
                            initState: (_) =>
                                countFirebase.getCountBirth(countAge: 46),
                            builder: (CountFirebase) {
                              print(
                                  "[GetBuilder]==> value countAge lansia : ${countFirebase.numLansia}");
                              return Indicator(
                                color: AppColors.contentColorBlue,
                                text: "Lansia : ${CountFirebase.numLansia}",
                                //  'Lansia : ${FromdataController.getNumLansia()}',
                                isSquare: true,
                              );
                            },
                          )
                        ],
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 18,
                          ),
                          GetBuilder<CountFirebase>(
                            init: CountFirebase(),
                            initState: (_) =>
                                countFirebase.getCountBirth(countAge: 26),
                            builder: (countFirebase) {
                              print(
                                  "[GetBuilder]==> value countAge Dewasa : ${countFirebase.numDewasa}");
                              return Indicator(
                                color: AppColors.contentColorOrange,
                                text: 'Dewasa :${countFirebase.numDewasa}',
                                isSquare: true,
                              );
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 18,
                          ),
                          GetBuilder<CountFirebase>(
                            init: CountFirebase(),
                            initState: (_) =>
                                countFirebase.getCountBirth(countAge: 12),
                            builder: (countFirebase) {
                              return Indicator(
                                color: AppColors.contentColorPurple,
                                text: 'Remaja: ${countFirebase.numRemaja}',
                                isSquare: true,
                              );
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 18,
                          ),
                          GetBuilder<CountFirebase>(
                            init: CountFirebase(),
                            initState: (_) =>
                                countFirebase.getCountBirth(countAge: 6),
                            builder: (countFirebase) {
                              return Indicator(
                                color: Color.fromARGB(255, 27, 207, 69),
                                text: 'Anak : ${countFirebase.numAnak}',
                                isSquare: true,
                              );
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 18,
                          ),
                          GetBuilder<CountFirebase>(
                            init: CountFirebase(),
                            initState: (_) =>
                                countFirebase.getCountBirth(countAge: 5),
                            builder: (CountFirebase) {
                              return Indicator(
                                color: AppColors.contentColorPink,
                                text: 'Balita : ${CountFirebase.numBalita}',
                                isSquare: true,
                              );
                            },
                          ),
                        ],
                      ),
                      // const SizedBox(
                      //   height: 13.5,
                      // ),
                      // Text(
                      //
                      //   "Total : $datacount",
                      //   style: TextStyle(
                      //       color: Colors.yellow[600],
                      //       fontWeight: FontWeight.bold,
                      //       fontSize: 19),
                      // ),
                      // ElevatedButton(
                      //     onPressed: () async {
                      //       // db.collection("penduduk").count().get().then(
                      //       //       (res) => datacount,
                      //       //       onError: (e) => print("Error completing: $e"),
                      //       //     );
                      //     },
                      //     //cb klo di dumb gmn caranya
                      //     child: Text("Total : $datacount"))
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 28,
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(5, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: AppColors.contentColorBlue,
            value:
                (countFirebase.numLansia / countFirebase.presentaseUsia) * 100,
            title:
                '${((countFirebase.numLansia / countFirebase.presentaseUsia) * 100).toInt()}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.mainTextColor1,
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: AppColors.contentColorOrange,
            value:
                (countFirebase.numDewasa / countFirebase.presentaseUsia) * 100,
            // ((countFirebase.numDewasa != null
            //             ? countFirebase.numDewasa
            //             : 0) /
            //         countFirebase.presentaseUsia) *
            //     100,
            title:
                '${((countFirebase.numDewasa / countFirebase.presentaseUsia) * 100).toInt()}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.mainTextColor1,
              shadows: shadows,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: AppColors.contentColorPurple,
            value:
                (countFirebase.numRemaja / countFirebase.presentaseUsia) * 100,
            title:
                '${((countFirebase.numRemaja / countFirebase.presentaseUsia) * 100).toInt()}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.mainTextColor1,
              shadows: shadows,
            ),
          );
        case 3:
          return PieChartSectionData(
            //contentColorGreen
            color: Color.fromARGB(255, 27, 207, 69),
            value: (countFirebase.numAnak / countFirebase.presentaseUsia) * 100,
            title:
                '${((countFirebase.numAnak / countFirebase.presentaseUsia) * 100).toInt()}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.mainTextColor1,
              shadows: shadows,
            ),
          );
        case 4:
          return PieChartSectionData(
            color: AppColors.contentColorPink,
            value:
                (countFirebase.numBalita / countFirebase.presentaseUsia) * 100,
            title:
                '${((countFirebase.numBalita / countFirebase.presentaseUsia) * 100).toInt()}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.mainTextColor1,
              shadows: shadows,
            ),
          );
        default:
          throw Error();
      }
    });
  }
}
