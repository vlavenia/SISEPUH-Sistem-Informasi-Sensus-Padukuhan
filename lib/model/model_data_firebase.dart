import 'dart:convert';
import 'dart:ffi';

class DataModelPenduduk {
  String? id;
  String? nama;
  String? birthdate;
  String? gender;
  String? rt;
  // int? age;
  DateTime? dateTime;

  DataModelPenduduk({
    this.id,
    this.nama,
    this.birthdate,
    this.gender,
    this.rt,
    // this.age,
    this.dateTime,
  });

  factory DataModelPenduduk.fromRawJson(String str) =>
      DataModelPenduduk.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DataModelPenduduk.fromJson(Map<String, dynamic> json) =>
      DataModelPenduduk(
        id: json["id"],
        nama: json["nama"],
        birthdate: json["birthdate"],
        gender: json["gender"],
        rt: json["rt"],
        // age: json["age"],
        dateTime: json["dateTime"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "birthdate": birthdate,
        "gender": gender,
        "rt": rt,
        // "age": age,
        "dateTime": dateTime,
      };
}