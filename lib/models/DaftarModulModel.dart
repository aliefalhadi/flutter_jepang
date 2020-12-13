// To parse this JSON data, do
//
//     final daftarModulModel = daftarModulModelFromJson(jsonString);

import 'dart:convert';

DaftarModulModel daftarModulModelFromJson(String str) => DaftarModulModel.fromJson(json.decode(str));

String daftarModulModelToJson(DaftarModulModel data) => json.encode(data.toJson());

class DaftarModulModel {
  DaftarModulModel({
    this.status,
    this.data,
  });

  String status;
  List<Datum> data;

  factory DaftarModulModel.fromJson(Map<String, dynamic> json) => DaftarModulModel(
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
    this.idModul,
    this.namaModul,
  });

  int idModul;
  String namaModul;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    idModul: json["id_modul"],
    namaModul: json["nama_modul"],
  );

  Map<String, dynamic> toJson() => {
    "id_modul": idModul,
    "nama_modul": namaModul,
  };
}
