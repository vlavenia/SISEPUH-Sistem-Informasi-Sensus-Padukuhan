import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addProductMethods(
      Map<String, dynamic> productInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("Product")
        .doc(id)
        .set(productInfoMap);
  }

  Future updateProductMethods(
      Map<String, dynamic> productInfoMap, String? id) async {
    return await FirebaseFirestore.instance
        .collection("Product")
        .doc(id)
        .set(productInfoMap);
  }

  getProductMethods() async {
    var response = FirebaseFirestore.instance.collection("Product").snapshots();
    Stream<QuerySnapshot<Map<String, dynamic>>> obj = response;
    return obj;
  }

  Future deleteProductMethods(String? id) async {
    return await FirebaseFirestore.instance
        .collection("Product")
        .doc(id)
        .delete();
  }
}
