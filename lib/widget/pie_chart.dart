import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sisepuh/constant.dart';
import 'package:sisepuh/main.dart';
import 'package:sisepuh/resources/app_color.dart';
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
  final db = FirebaseFirestore.instance;

  //AggregateQuerySnapshot aggregateQuerySnapshot= await db.collection('penduduk').count().get(source: aggregateQuerySnapshot.server);

  void main() {}

  @override
  Widget build(BuildContext context) {
    //ini tu udh ta bungkus di dlm func, heww, ga giut. so?satunya function apa, method? iya sma aja. trs? satunya method mana yang mau dipanggil

//  klo gni knapa
//cara dia tau klo lg ngitung data keseluruhan sama berdasarkan usia gmn dh
    db.collection("penduduk").count().get().then(
          (res) => datacount = res.count,
          onError: (e) => print("Error completing: $e"),
        );

    db
        .collection("penduduk")
        .where("age", isGreaterThan: 10)
        .count()
        .get()
        .then(
          //yg iini lho dia pke variabel yg sama kayak yg diatas, trs gmn? buat beda2 kh variablenya?
          (res) => datacountAge = res.count,
          //buat nampung jumlah data berdasarkan usia
          onError: (e) => print("Error completing: $e"),
        );

    void getDataAge() {}
    //nah ini gimana caranya klo ada 2 func yg berbeda trs dipanggil variebel yg sama scr bersamaan?
// yg mn??
    return AspectRatio(
      aspectRatio: 2.1,
      child: Container(
        padding: EdgeInsets.only(top: 30, left: 40),
        child: Row(
          children: <Widget>[
            Container(
              height: 150,
              child: Expanded(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: PieChart(
                    PieChartData(
                      pieTouchData: PieTouchData(
                        touchCallback: (FlTouchEvent event, pieTouchResponse) {
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
                  height: 17.0,
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
                          Indicator(
                            color: AppColors.contentColorBlue,
                            text: 'Lansia :  32 Orang',
                            isSquare: true,
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
                          Indicator(
                            color: AppColors.contentColorOrange,
                            text: 'Dewasa : $datacountAge',
                            isSquare: true,
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
                          Indicator(
                            color: AppColors.contentColorPurple,
                            text: 'Remaja: 30 orang',
                            isSquare: true,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      // Row(
                      //   children: [
                      //     SizedBox(
                      //       width: 18,
                      //     ),
                      //     Indicator(
                      //       color: AppColors.contentColorPink,
                      //       text: 'Balita : 3 anak',
                      //       isSquare: true,
                      //     ),
                      //   ],
                      // ),
                      // const SizedBox(
                      //   height: 13.5,
                      // ),
                      Text(
                        
                        //lm bgt ngereload dpt datanya
                        "Total : $datacount",
                        style: TextStyle(
                            color: Colors.yellow[600],
                            fontWeight: FontWeight.bold,
                            fontSize: 19),
                      ),
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
            value: 40,
            title: '40%',
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
            value: 30,
            title: '30%',
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
            value: 15,
            title: '15%',
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
            color: AppColors.contentColorPink,
            value: 15,
            title: '15%',
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
