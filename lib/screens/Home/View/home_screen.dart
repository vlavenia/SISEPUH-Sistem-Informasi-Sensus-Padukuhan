import 'package:flutter/material.dart';
import 'package:sisepuh/main.dart';
import 'package:sisepuh/screens/Home/widget/line_chart.dart';
import 'package:sisepuh/screens/Home/widget/pie_chart.dart';

import 'package:sisepuh/screens/mastertable/widget/streambuilder_data.dart';

class HomeScreen extends StatelessWidget {
  // int currentIndexPage = 0;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      SliverAppbarCustom(),
      SliverToBoxAdapter(
        child: Container(
            width: MediaQuery.of(context).size.width - 50,
            child: Column(
              children: [
                // Padding(
                //     //padding: const EdgeInsets.symmetric(vertical: 16),
                //     ),
                Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width - 50,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Color.fromARGB(172, 68, 137, 255),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromARGB(83, 0, 0, 0),
                            blurRadius: 20,
                            offset: Offset(8, 20))
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Jumlah Penduduk Kentolan Lor Rt 02",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 23,
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        "435 Penduduk",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      // border: Border.all(color: Colors.blueAccent),
                    ),
                    child: PieChartSample2()),
                Padding(
                  padding: EdgeInsets.only(top: 40),
                  child: Container(
                    width: MediaQuery.of(context).size.width - 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Data Terbaru",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            //color: Color.fromARGB(255, 68, 137, 255),
                          ),
                        ),
                        Text(
                          "View All",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Streambuilderdata(
                  db: db,
                  takes: 2,
                ),

                const SizedBox(
                  height: 15.0,
                ),
                LineChartSample2()
              ],
            )),
      )
    ]);
  }
}

class SliverAppbarCustom extends StatelessWidget {
  const SliverAppbarCustom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar.medium(
        expandedHeight: 140,
        actions: [
          const Icon(
            Icons.shopping_cart,
          ),
        ],
        leading: const Icon(
          Icons.menu_rounded,
        ),
        title: Column(
          children: [
            Text(
              "Selamat datang",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 25,
              ),
            ),
            Text(
              "Pak Poniman",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ),
            ),
          ],
        )
        // Text(
        //   "Dashboard Panel",
        //   style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30),
        // ),

        //backgroundColor: Color.fromARGB(255, 42, 190, 235),
        );
  }
}
