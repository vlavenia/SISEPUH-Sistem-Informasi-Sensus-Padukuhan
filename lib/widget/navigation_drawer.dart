// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:sisepuh/constant.dart';
import 'package:sisepuh/screens/dashboard_screen.dart';
import 'package:sisepuh/screens/master_table_screen.dart';
import 'package:sisepuh/screens/profile_screnn.dart';

class NavigationDrawerCustom extends StatefulWidget {
  const NavigationDrawerCustom({Key? key}) : super(key: key);

  @override
  State<NavigationDrawerCustom> createState() => _NavigationDrawerCustomState();
}

class _NavigationDrawerCustomState extends State<NavigationDrawerCustom> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: SingleChildScrollView(
      child: Column(
        children: [
          buildHeader(context),
          buildMenuItems(context),
        ],
      ),
    ));
  }

  Widget buildHeader(BuildContext context) => Material(
        color: primaryColor,
        child: InkWell(
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfileScreen()),
            );
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 250,
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 52,
                  backgroundImage: NetworkImage(
                    "https://i.ibb.co/PGv8ZzG/me.jpg",
                  ),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                Text(
                  "Pak Poniman",
                  style: TextStyle(fontSize: 28),
                ),
                Text(
                  "Ketua RT 02",
                  style: TextStyle(fontSize: 16),
                )
              ],
            ),
          ),
        ),
      );

  Widget buildMenuItems(BuildContext context) => Container(
        padding: EdgeInsets.all(24),
        child: Wrap(
          runSpacing: 16,
          children: [
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: Text("Dashboard"),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => DashboardScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: Text("Data Penduduk"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MasterTableScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: Text("Profile"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout_outlined),
              title: Text("Log out"),
              onTap: () {},
            ),
          ],
        ),
      );
}
