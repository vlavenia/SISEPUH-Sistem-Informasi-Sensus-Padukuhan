import 'dart:convert';

class DataModelPenduduk {
  String? id;
  String? nama;
  String? birthdate;
  String? gender;
  String? rt;
  int? age;

  DataModelPenduduk({
    this.id,
    this.nama,
    this.birthdate,
    this.gender,
    this.rt,
    this.age,
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
        age: json["age"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "birthdate": birthdate,
        "gender": gender,
        "rt": rt,
        "age": age,
      };
}
