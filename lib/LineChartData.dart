// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sisepuh/controller/formdata_controller.dart';

class LineChartWidget extends StatelessWidget {
  LineChartWidget({Key? key}) : super(key: key);

  var FromdataController = Get.put(FromDataController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Container(
        height: 150,
        child: LineChart(LineChartData(
          minX: 0,
          maxX: 6,
          minY: 0,
          maxY: (FromdataController.NumGenderp + FromdataController.NumGenderl)
              .toDouble(),
          lineBarsData: [
            LineChartBarData(
              spots: [
                const FlSpot(0, 6),
                const FlSpot(1, 6),
                const FlSpot(2, 6),
                const FlSpot(3, 6),
                const FlSpot(4, 6),
                const FlSpot(5, 4),
              ],
              isCurved: true,
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF50E4FF),
                  Color(0xFF2196F3),
                ],
              ),
              barWidth: 5,
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF50E4FF).withOpacity(0.3),
                    Color(0xFF2196F3).withOpacity(0.3),
                  ],
                ),
              ),
              dotData: FlDotData(show: false),
            )
          ],
          gridData: FlGridData(
            show: true,
            drawHorizontalLine: true,
            drawVerticalLine: true,
          ),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
              ),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 30,
                  getTitlesWidget: (value, meta) {
                    String text = '';
                    switch (value.toInt()) {
                      case 1:
                        text = '1';
                        break;
                      case 2:
                        text = '2';
                        break;
                      case 3:
                        text = '3';
                        break;
                      case 4:
                        text = '4';
                        break;
                      case 5:
                        text = '5';
                        break;
                      case 6:
                        text = '6';
                        break;

                      default:
                        return Container();
                    }
                    return Text(
                      text,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }),
            ),
          ),
        )),
      ),
    );
  }
}
