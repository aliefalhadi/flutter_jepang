// To parse this JSON data, do
//
//     final daftarModulBelajarModel = daftarModulBelajarModelFromJson(jsonString);

import 'dart:convert';

DaftarModulBelajarModel daftarModulBelajarModelFromJson(String str) => DaftarModulBelajarModel.fromJson(json.decode(str));

String daftarModulBelajarModelToJson(DaftarModulBelajarModel data) => json.encode(data.toJson());

class DaftarModulBelajarModel {
  DaftarModulBelajarModel({
    this.status,
    this.data,
  });

  String status;
  List<DatumBelajar> data;

  factory DaftarModulBelajarModel.fromJson(Map<String, dynamic> json) => DaftarModulBelajarModel(
    status: json["status"],
    data: List<DatumBelajar>.from(json["data"].map((x) => DatumBelajar.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class DatumBelajar {
  DatumBelajar({
    this.idModulBelajar,
    this.idModul,
    this.nomorBelajar,
    this.textJepang,
    this.textLatin,
    this.terjemahanText,
    this.hintText,
    this.speechText,
    this.polaBelajar,
  });

  int idModulBelajar;
  int idModul;
  int nomorBelajar;
  String textJepang;
  String textLatin;
  String terjemahanText;
  String hintText;
  String speechText;
  String polaBelajar;

  factory DatumBelajar.fromJson(Map<String, dynamic> json) => DatumBelajar(
    idModulBelajar: json["id_modul_belajar"],
    idModul: json["id_modul"],
    nomorBelajar: json["nomor_belajar"],
    textJepang: json["text_jepang"],
    textLatin: json["text_latin"],
    terjemahanText: json["terjemahan_text"],
    hintText: json["hint_text"],
    speechText: json["speech_text"],
    polaBelajar: json["pola_belajar"],
  );

  Map<String, dynamic> toJson() => {
    "id_modul_belajar": idModulBelajar,
    "id_modul": idModul,
    "nomor_belajar": nomorBelajar,
    "text_jepang": textJepang,
    "text_latin": textLatin,
    "terjemahan_text": terjemahanText,
    "hint_text": hintText,
    "speech_text": speechText,
    "pola_belajar": polaBelajar,
  };
}
