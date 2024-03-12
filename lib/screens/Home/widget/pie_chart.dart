import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sisepuh/controller/formdata_controller.dart';
import 'package:sisepuh/resources/app_color.dart';
import 'package:sisepuh/services/countfirebase_service.dart';
import 'package:sisepuh/widget/indicator_chart.dart';

class PieChartSample2 extends StatefulWidget {
  const PieChartSample2({super.key});

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State<PieChartSample2> {
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
                  child: GetBuilder<CountFirebase>(
                    init: CountFirebase(),
                    // initState: (_) => countServices.getNumUsia(),
                    builder: (_) {
                      return PieChart(
                        PieChartData(
                          pieTouchData: PieTouchData(
                            touchCallback:
                                (FlTouchEvent event, pieTouchResponse) {
                              setState(() {
                                if (!event.isInterestedForInteractions ||
                                    pieTouchResponse == null ||
                                    pieTouchResponse.touchedSection == null) {
                                  touchedIndex = -1;
                                  return;
                                }
                                touchedIndex = pieTouchResponse
                                    .touchedSection!.touchedSectionIndex;
                              });
                            },
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
                  ),
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
                  height: 10.0,
                ),
                Container(
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
                            initState: (_) => countFirebase.getCountBirth(46),
                            builder: (CountFirebase) {
                              return Indicator(
                                color: AppColors.contentColorBlue,
                                text: "Lansia : ${countFirebase.numLansia}",
                                //  'Lansia : ${FromdataController.getNumLansia()}',
                                isSquare: true,
                              );
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 18,
                          ),
                          GetBuilder<CountFirebase>(
                            init: CountFirebase(),
                            initState: (_) => countFirebase.getCountBirth(26),
                            builder: (CountFirebase) {
                              return Indicator(
                                color: AppColors.contentColorOrange,
                                text: 'Dewasa : ${CountFirebase.numDewasa}',
                                isSquare: true,
                              );
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 18,
                          ),
                          GetBuilder<CountFirebase>(
                            init: CountFirebase(),
                            initState: (_) => countFirebase.getCountBirth(12),
                            builder: (CountFirebase) {
                              return Indicator(
                                color: AppColors.contentColorPurple,
                                text: 'Remaja: ${CountFirebase.numRemaja}',
                                isSquare: true,
                              );
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 18,
                          ),
                          GetBuilder<CountFirebase>(
                            init: CountFirebase(),
                            initState: (_) => countFirebase.getCountBirth(5),
                            builder: (CountFirebase) {
                              return Indicator(
                                color: Color.fromARGB(255, 27, 207, 69),
                                text: 'Anak : ${CountFirebase.numAnak}',
                                isSquare: true,
                              );
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 18,
                          ),
                          GetBuilder<CountFirebase>(
                            init: CountFirebase(),
                            initState: (_) => countFirebase.getCountBirth(6),
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
    return List.generate(4, (i) {
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
