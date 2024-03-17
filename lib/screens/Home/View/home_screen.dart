import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:get/get.dart';
import 'package:sisepuh/LineChartData.dart';
import 'package:sisepuh/controller/auth_controller.dart';
import 'package:sisepuh/controller/formdata_controller.dart';
// import 'package:sisepuh/main.dart';
// import 'package:sisepuh/screens/Home/widget/line_chart.dart';
import 'package:sisepuh/screens/Home/widget/pie_chart.dart';
import 'package:sisepuh/screens/login/login_screens.dart';
// import 'package:sisepuh/screens/login/login_screens.dart';
import 'package:sisepuh/screens/mastertable/view/master_table_screen.dart';
import 'package:sisepuh/screens/mastertable/widget/streambuilder_data.dart';
import 'package:sisepuh/services/auth_service.dart';
import 'package:sisepuh/services/countfirebase_service.dart';
import 'package:sisepuh/services/firebase_service.dart';
import 'package:sisepuh/widget/indicator_chart.dart';

class HomeScreen extends StatelessWidget {
  // int currentIndexPage = 0;

  var FromdataController = Get.put(FromDataController());
  var countFirebase = Get.put(CountFirebase());
  // var getCountGender = CountFirebase().getCountGender();
  var AuthDataController = Get.put(AuthController());
  var AuthServices = AuthService();
  var curruserview = true;
  var dataL;
  User? loged = AuthController().getCurrentUser();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        controller: ScrollController(),
        child: Container(
            padding: EdgeInsets.only(top: 30),
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Dashboard SI-Sepuh",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2),
                          ),
                          const SizedBox(
                            height: 2.0,
                          ),
                          FutureBuilder(
                              future: countFirebase.getallCollection(),
                              builder: (context, snapshot) {
                                return FutureBuilder(
                                    future: countFirebase.getallCollection(),
                                    builder: (context, snapshot) {
                                      return GetBuilder<CountFirebase>(
                                        init: CountFirebase(),
                                        initState: (_) =>
                                            countFirebase.getallCollection(),
                                        builder: (AuthController) {
                                          return loged!.email !=
                                                  'testdukuhh@gmail.com'
                                              ? Text(
                                                  "Wellcome,RT${countFirebase.currUserCollectionRT}",
                                                  style: TextStyle(
                                                      fontSize: 28,
                                                      letterSpacing: 1),
                                                )
                                              : Text(
                                                  "Wellcome,Pak Dukuh",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 32,
                                                  ),
                                                );
                                        },
                                      );
                                    });
                              }),
                        ],
                      ),
                      IconButton(
                        onPressed: () async {
                          //SIgnout secara session login
                          AuthDataController.signOut();

                          //Ketika Signout berhasil maka akan redirect ke halaman login
                          // 1.Manggil widget page login => Login->Home.signout->Login
                          // 2.Redirect back to page login => Home.signout())
                          // 3. Ketika tidak ada session login, system dapat mendeteksi kemudian diarahkan ke page login => Controller/state management global, Home->  isLogin?false ->redirect back to login
                        },
                        icon: const Icon(
                          Icons.logout_outlined,
                          size: 24.0,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25.0,
                ),
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
                      GetBuilder<CountFirebase>(
                        init: CountFirebase(),
                        initState: (_) => countFirebase.getallCollection(),
                        builder: (CountFirebase) {
                          return loged!.email == 'testdukuhh@gmail.com'
                              ? Text(
                                  textAlign: TextAlign.center,
                                  "Total Penduduk Kentolan Lor",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 23,
                                  ),
                                )
                              : Text(
                                  textAlign: TextAlign.center,
                                  "Jumlah Pencatatan Penduduk\n Kentolan Lor RT ${countFirebase.currUserCollectionRT}",
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
                      FutureBuilder<dynamic>(
                          future: countFirebase.getallCollection(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return GetBuilder<CountFirebase>(
                                init: CountFirebase(),
                                initState: (_) =>
                                    countFirebase.getallCollection(),
                                builder: (countFirebase) => Text(
                                  "${countFirebase.NumLength} Penduduk",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            } else {
                              return Text("Nothing");
                            }
                          }),
                      const SizedBox(
                        height: 17.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FutureBuilder(
                              future: CountFirebase().getCountGender(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                } else if (snapshot.connectionState ==
                                    ConnectionState.active) {
                                  return Text("Connection Active Testing");
                                } else if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  return Row(
                                    children: [
                                      GetBuilder<CountFirebase>(
                                        init: CountFirebase(),
                                        initState: (_) =>
                                            countFirebase.getCountGender(
                                                gender: "perempuan"),
                                        builder: (countFirebase) {
                                          print(
                                              "[GetBuilder]==> value countGender Perempuan : ${countFirebase.NumLengthGenderP}");
                                          return Indicator(
                                            color: Colors.pink,
                                            text:
                                                "Perempuan ${((countFirebase.NumLengthGenderP / (countFirebase.NumLengthGenderL + countFirebase.NumLengthGenderP)) * 100).toInt()}% : ${countFirebase.NumLengthGenderP}",
                                            textColor: Colors.white,
                                            isSquare: true,
                                          );
                                        },
                                      ),
                                      const SizedBox(
                                        width: 10.0,
                                      ),
                                      GetBuilder<CountFirebase>(
                                        init: CountFirebase(),
                                        initState: (_) =>
                                            countFirebase.getCountGender(
                                                gender: "laki-laki"),
                                        builder: (countFirebase) {
                                          print(
                                              "[GetBuilder]==> value countGender LAKI-LAKI : ${countFirebase.NumLengthGenderL}");
                                          return Indicator(
                                            color: Colors.amber,
                                            text:
                                                'Laki-Laki ${(countFirebase.NumLengthGenderL / (countFirebase.NumLengthGenderL + countFirebase.NumLengthGenderP) * 100).toInt()}% : ${countFirebase.NumLengthGenderL} ',
                                            textColor: Colors.white,
                                            isSquare: true,
                                          );
                                        },
                                      ),
                                    ],
                                  );
                                }
                                return Text("Loading");
                              }),
                        ],
                      ),
                      const SizedBox(
                        height: 17.0,
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
                    ),
                    child: FutureBuilder<dynamic>(
                        future: countFirebase.getCountBirth(),
                        builder: (context, snapshot) {
                          // if (snapshot.connectionState ==
                          //     ConnectionState.waiting) {
                          //   return Center(child: CircularProgressIndicator());
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return PieChartSample2();
                          }
                          return Text("loading");
                        })),
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
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MasterTableScreen()),
                            );
                          },
                          child: Text(
                            "View All",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Streambuilderdata(
                  refreshCallback: () {},
                  takes: 2,
                ),
                const SizedBox(
                  height: 15.0,
                ),
                //LineChartSample2(),
              ],
            )),
      ),
    ));
  }
}
