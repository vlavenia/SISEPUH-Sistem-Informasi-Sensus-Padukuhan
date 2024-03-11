import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:sisepuh/services/auth_service.dart';

class DatabaseMethods extends GetxController {
  var currentUser = Get.put(AuthService());
  var getUser;

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

  Future<void> getUserMethods() async {
    var dataUser = await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser.currentUser!.uid)
        .get();
    update();

    print('=> [firestore service] current user ${currentUser.currentUser}');
    print('=> [firestore service] data user ${dataUser}');

    // var response = FirebaseFirestore.instance.collection("users").snapshots();
    // Stream<QuerySnapshot<Map<String, dynamic>>> obj = response;
    getUser = dataUser['nama'];
    print('=> [firestore service] data get user ${getUser}');
    return getUser;
  }
}
