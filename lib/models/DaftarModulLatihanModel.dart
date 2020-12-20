// To parse this JSON data, do
//
//     final daftarModulLatihanModel = daftarModulLatihanModelFromJson(jsonString);

import 'dart:convert';

DaftarModulLatihanModel daftarModulLatihanModelFromJson(String str) => DaftarModulLatihanModel.fromJson(json.decode(str));

String daftarModulLatihanModelToJson(DaftarModulLatihanModel data) => json.encode(data.toJson());

class DaftarModulLatihanModel {
  DaftarModulLatihanModel({
    this.status,
    this.data,
  });

  String status;
  List<Datum> data;

  factory DaftarModulLatihanModel.fromJson(Map<String, dynamic> json) => DaftarModulLatihanModel(
    status: json["status"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.idModulLatihan,
    this.levelLatihan,
    this.namaModulLatihan,
  });

  int idModulLatihan;
  int levelLatihan;
  String namaModulLatihan;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    idModulLatihan: json["id_modul_latihan"],
    levelLatihan: json["level_latihan"],
    namaModulLatihan: json["nama_modul_latihan"],
  );

  Map<String, dynamic> toJson() => {
    "id_modul_latihan": idModulLatihan,
    "level_latihan": levelLatihan,
    "nama_modul_latihan": namaModulLatihan,
  };
}
