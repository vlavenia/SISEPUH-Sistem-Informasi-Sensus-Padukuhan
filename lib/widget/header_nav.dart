import 'package:flutter/material.dart';
import 'package:sisepuh/constant.dart';

AppBar headerNav({required String title}) {
  return AppBar(
    toolbarHeight: 100,
    title: Text(
      title,
      style: TextStyle(
        color: Colors.white,
      ),
    ),
    centerTitle: true,
    backgroundColor: Colors.transparent,
    flexibleSpace: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue,
            Colors.purple
          ], // Ganti dengan warna yang Anda inginkan
        ),
      ),
    ),
  );
}
