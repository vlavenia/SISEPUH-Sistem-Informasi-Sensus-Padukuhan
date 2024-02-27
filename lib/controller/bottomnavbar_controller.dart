import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:sisepuh/screens/Home/View/home_screen.dart';
import 'package:sisepuh/screens/mastertable/view/master_table_screen.dart';
import 'package:sisepuh/screens/setting/view/profile_screnn.dart';

class NavigationController extends GetxController {
  final selectedIndex = 0.obs;

  final listpages = [
    Container(child: HomeScreen()),
    Container(child: MasterTableScreen()),
    Container(child: ProfileScreen())
  ];
}
