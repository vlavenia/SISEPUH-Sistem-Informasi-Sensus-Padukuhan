import 'package:flutter/material.dart';

class ListBuilderWidget extends StatelessWidget {
  ListBuilderWidget({super.key});

  List<String> products = ["Sofa, bed, chair"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
      child: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            child: Text(products[index]),
          ),
        );
      }),
    ),
    );
  }
}
