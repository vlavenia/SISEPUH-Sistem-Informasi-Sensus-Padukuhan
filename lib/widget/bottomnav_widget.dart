import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sisepuh/controller/bottomnavbar_controller.dart';

class bottomNavbar extends StatelessWidget {
  bottomNavbar({
    super.key,
  });

  final NavC = NavigationController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
          margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 15,
                offset: Offset(8, 20)),
          ]),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Obx(
                () => NavigationBar(
                  selectedIndex: NavC.selectedIndex.value,
                  onDestinationSelected: (index) =>
                      NavC.selectedIndex.value = index,
                  //Get.to(NavC.listpages[index]),
                  destinations: [
                    NavigationDestination(
                        icon: const Icon(
                          Icons.dashboard_customize_outlined,
                          size: 24.0,
                        ),
                        label: "Home"),
                    NavigationDestination(
                        icon: const Icon(
                          Icons.table_chart_outlined,
                          size: 24.0,
                        ),
                        label: "Data"),
                    NavigationDestination(
                        icon: const Icon(
                          Icons.settings,
                          size: 24.0,
                        ),
                        label: "About"),
                  ],
                ),
              )),
        ),
        body: Obx(
          () => NavC.listpages[NavC.selectedIndex.value],
        ));
  }
}
