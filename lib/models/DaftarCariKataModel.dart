// To parse this JSON data, do
//
//     final daftarCariKataModel = daftarCariKataModelFromJson(jsonString);

import 'dart:convert';

DaftarCariKataModel daftarCariKataModelFromJson(String str) => DaftarCariKataModel.fromJson(json.decode(str));

String daftarCariKataModelToJson(DaftarCariKataModel data) => json.encode(data.toJson());

class DaftarCariKataModel {
  DaftarCariKataModel({
    this.status,
    this.data,
  });

  String status;
  List<DatumKata> data;

  factory DaftarCariKataModel.fromJson(Map<String, dynamic> json) => DaftarCariKataModel(
    status: json["status"],
    data: List<DatumKata>.from(json["data"].map((x) => DatumKata.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class DatumKata {
  DatumKata({
    this.idKamus,
    this.kataJepangHiragana,
    this.kataJepangKatakana,
    this.kataJepangKanji,
    this.kataLatin,
    this.terjemahanKata,
  });

  int idKamus;
  String kataJepangHiragana;
  String kataJepangKatakana;
  String kataJepangKanji;
  String kataLatin;
  String terjemahanKata;

  factory DatumKata.fromJson(Map<String, dynamic> json) => DatumKata(
    idKamus: json["id_kamus"],
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
