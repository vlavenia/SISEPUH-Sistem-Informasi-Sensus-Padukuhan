import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sisepuh/LineChartData.dart';
import 'package:sisepuh/controller/auth_controller.dart';
import 'package:sisepuh/controller/formdata_controller.dart';
import 'package:sisepuh/main.dart';
import 'package:sisepuh/screens/Home/widget/line_chart.dart';
import 'package:sisepuh/screens/Home/widget/pie_chart.dart';
import 'package:sisepuh/screens/mastertable/widget/streambuilder_data.dart';
import 'package:sisepuh/services/auth_service.dart';
import 'package:sisepuh/services/firestore_firebase.dart';
import 'package:sisepuh/widget/indicator_chart.dart';

class HomeScreen extends StatelessWidget {
  // int currentIndexPage = 0;

  var FromdataController = Get.put(FromDataController());
  var getData = Get.put(DatabaseMethods());
  var AuthC = AuthController();

  @override
  Widget build(BuildContext context) {
    var dataUser = getData.getUserMethods();
    print('=> [home_screen] dataCurrentUser ${getData.getUser}');

    return CustomScrollView(slivers: [
      SliverAppbarCustom(),
      SliverToBoxAdapter(
        child: Container(
            padding: EdgeInsets.only(top: 20),
            width: MediaQuery.of(context).size.width - 50,
            child: Column(
              children: [
                // Padding(
                //     //padding: const EdgeInsets.symmetric(vertical: 16),
                //     ),
                Container(
                  padding: EdgeInsets.all(12),
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
                      GetBuilder<DatabaseMethods>(
                        init: DatabaseMethods(),
                        initState: (_) {},
                        builder: (DatabaseMethods) {
                          return Text(
                            textAlign: TextAlign.center,
                            "Jumlah Penduduk Kentolan Lor Rt 02 - ${DatabaseMethods.getUser}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 23,
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      GetBuilder<FromDataController>(
                        init: FromDataController(),
                        builder: (controller) => Text(
                          "${(FromdataController.NumGenderp + FromdataController.NumGenderl)} Penduduk",
                          //"${controller.NumGender} Penduduk",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 17.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 15,
                                ),
                                GetBuilder<FromDataController>(
                                  init: FromDataController(),
                                  initState: (_) =>
                                      FromdataController.getNumGender(
                                          "perempuan"),
                                  builder: (FromDataController) {
                                    return Indicator(
                                      color: Colors.pink,
                                      text:
                                          "Perempuan ${(FromdataController.NumGenderp / (FromdataController.NumGenderp + FromdataController.NumGenderl) * 100).toInt()}% : ${FromdataController.NumGenderp}",
                                      //'Perempuan 75% : ${FromdataController.getNumGender("perempuan")} ',
                                      textColor: Colors.white,
                                      isSquare: true,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 18,
                                ),
                                GetBuilder<FromDataController>(
                                  init: FromDataController(),
                                  initState: (_) =>
                                      FromdataController.getNumGender(
                                          "laki-laki"),
                                  builder: (FromDataController) {
                                    return Indicator(
                                      color: Colors.amber,
                                      text:
                                          'Laki-Laki ${(FromdataController.NumGenderl / (FromdataController.NumGenderp + FromdataController.NumGenderl) * 100).toInt()}% : ${FromdataController.NumGenderl} ',
                                      textColor: Colors.white,
                                      isSquare: true,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
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
                            fontSize: 22,
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
                  takes: 2,
                ),

                const SizedBox(
                  height: 15.0,
                ),
                LineChartSample2(),
              ],
            )),
      )
    ]);
  }
}

class SliverAppbarCustom extends StatelessWidget {
  var AuthC = AuthController();

  SliverAppbarCustom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar.medium(
        expandedHeight: 140,
        stretch: true,
        //onStretchTrigger: (){},
        //flexibleSpace: FlexibleSpaceBar(),
        actions: [
          IconButton(
            onPressed: () {
              //signout
              AuthC.signOutController();
            },
            icon: const Icon(
              Icons.exit_to_app_outlined,
              size: 24.0,
            ),
          )
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
