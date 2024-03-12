import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class FirebaseService {
  var db = FirebaseFirestore.instance;
  var getData = FirebaseFirestore.instance.collection('penduduk').get();

  var numdataP;
  var numdatauser;
  var jumlah;
  //var getRt = getData['rt'];

  Future AddProduct(
      Map<String, dynamic> datapenduduk, String id, String roleRt) async {
    return await db
        .collection("Data KentolanLor $roleRt")
        .add(datapenduduk)
        .whenComplete(() =>
            printInfo(info: "==> Data Penduduk-$id berhasil ditambahkan <=="));
  }

  Future updateProduct(Map<String, dynamic> productInfoMap, String? id) async {
    return await FirebaseFirestore.instance
        .collection("Product")
        .doc(id)
        .set(productInfoMap);
  }

  getProduct() async {
    var response = FirebaseFirestore.instance.collection("Product").snapshots();
    Stream<QuerySnapshot<Map<String, dynamic>>> obj = response;
    return obj;
  }

  Future deleteProduct(String? id) async {
    return await FirebaseFirestore.instance
        .collection("Product")
        .doc(id)
        .delete();
  }
}
