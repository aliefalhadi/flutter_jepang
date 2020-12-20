// To parse this JSON data, do
//
//     final daftarSoalModulLatihanModel = daftarSoalModulLatihanModelFromJson(jsonString);

import 'dart:convert';

DaftarSoalModulLatihanModel daftarSoalModulLatihanModelFromJson(String str) => DaftarSoalModulLatihanModel.fromJson(json.decode(str));

String daftarSoalModulLatihanModelToJson(DaftarSoalModulLatihanModel data) => json.encode(data.toJson());

class DaftarSoalModulLatihanModel {
  DaftarSoalModulLatihanModel({
    this.status,
    this.data,
  });

  String status;
  List<Datum> data;

  factory DaftarSoalModulLatihanModel.fromJson(Map<String, dynamic> json) => DaftarSoalModulLatihanModel(
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
    this.idModulLatihanSoal,
    this.idModulLatihan,
    this.nomorSoal,
    this.textJepang,
    this.textLatin,
    this.terjemahanText,
  });

  int idModulLatihanSoal;
  int idModulLatihan;
  int nomorSoal;
  String textJepang;
  String textLatin;
  String terjemahanText;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    idModulLatihanSoal: json["id_modul_latihan_soal"],
    idModulLatihan: json["id_modul_latihan"],
    nomorSoal: json["nomor_soal"],
    textJepang: json["text_jepang"],
    textLatin: json["text_latin"],
    terjemahanText: json["terjemahan_text"],
  );

  Map<String, dynamic> toJson() => {
    "id_modul_latihan_soal": idModulLatihanSoal,
    "id_modul_latihan": idModulLatihan,
    "nomor_soal": nomorSoal,
    "text_jepang": textJepang,
    "text_latin": textLatin,
    "terjemahan_text": terjemahanText,
  };
}
