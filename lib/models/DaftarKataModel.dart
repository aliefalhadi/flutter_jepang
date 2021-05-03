// To parse this JSON data, do
//
//     final daftarKataModel = daftarKataModelFromJson(jsonString);

import 'dart:convert';

DaftarKataModel daftarKataModelFromJson(String str) => DaftarKataModel.fromJson(json.decode(str));

String daftarKataModelToJson(DaftarKataModel data) => json.encode(data.toJson());

class DaftarKataModel {
  DaftarKataModel({
    this.status,
    this.data,
    this.totalItems,
  });

  String status;
  List<Datum> data;
  String totalItems;

  factory DaftarKataModel.fromJson(Map<String, dynamic> json) => DaftarKataModel(
    status: json["status"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    totalItems: json["totalItems"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "totalItems": totalItems,
  };
}

class Datum {
  Datum({
    this.idKamus,
    this.kataJepangHiragana,
    this.kataJepangKatakana,
    this.kataJepangKanji,
    this.kataLatin,
    this.terjemahanKata,
  });

  String idKamus;
  String kataJepangHiragana;
  String kataJepangKatakana;
  String kataJepangKanji;
  String kataLatin;
  String terjemahanKata;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    idKamus: json["id_kamus"].toString(),
    kataJepangHiragana: json["kata_jepang_hiragana"],
    kataJepangKatakana: json["kata_jepang_katakana"],
    kataJepangKanji: json["kata_jepang_kanji"],
    kataLatin: json["kata_latin"],
    terjemahanKata: json["terjemahan_kata"],
  );

  Map<String, dynamic> toJson() => {
    "id_kamus": idKamus,
    "kata_jepang_hiragana": kataJepangHiragana,
    "kata_jepang_katakana": kataJepangKatakana,
    "kata_jepang_kanji": kataJepangKanji,
    "kata_latin": kataLatin,
    "terjemahan_kata": terjemahanKata,
  };
}

