import 'dart:convert';

class DataModelPenduduk {
  String? id;
  String? nama;
  DateTime? birthdate;
  String? gender;
  String? rt;

  DataModelPenduduk({
    this.id,
    this.nama,
    this.birthdate,
    this.gender,
    this.rt,
  });

  factory DataModelPenduduk.fromRawJson(String str) =>
      DataModelPenduduk.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DataModelPenduduk.fromJson(Map<String, dynamic> json) =>
      DataModelPenduduk(
        id: json["id"],
        nama: json["nama"],
        birthdate: json["birthdate"] == null
            ? null
            : DateTime.parse(json["birthdate"]),
        gender: json["gender"],
        rt: json["rt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "birthdate": birthdate?.toIso8601String(),
        "gender": gender,
        "rt": rt,
      };
}
