import 'package:flutter/material.dart';
import 'package:flutterstarter/models/DaftarSoalModulLatihanModel.dart';
import 'package:flutterstarter/views/Login.dart';
import 'package:flutterstarter/views/kamus/KamusIndex.dart';
import 'package:flutterstarter/views/latihan/JawabSoalLatihan.dart';
import 'package:flutterstarter/views/latihan/ModulLatihan.dart';
import 'package:flutterstarter/views/latihan/ModulLatihanSoal.dart';
import 'package:flutterstarter/views/latihan/TestLatihan.dart';
import 'package:flutterstarter/views/modul/ModulBelajarDetail.dart';
import 'package:flutterstarter/views/modul/ModulBelajarIndex.dart';
import 'package:flutterstarter/views/modul/ModulIndex.dart';

import 'Home.dart';

class RouterApp {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/login':
        return MaterialPageRoute(
            builder: (_) => Login()
        );

      case '/home':
        return MaterialPageRoute(
            builder: (_) => MyHomePage(title: 'Flutter Demo Home Page')
        );

      case '/kamus':
        return MaterialPageRoute(
            builder: (_) => KamusIndex()
        );

      case '/modul':
        return MaterialPageRoute(
            builder: (_) => ModulIndex()
        );

      case '/modul/latihan':
        return MaterialPageRoute(
            builder: (_) => ModulLatihan()
        );

      case '/modul/latihan/soal':
        Map dataProgresLatihanModul= settings.arguments;
        return MaterialPageRoute(
            builder: (_) => ModulLatihanSoal(dataProgresLatihanModul: dataProgresLatihanModul,)
        );

      case '/modul/latihan/soal/jawab':
        int indexSoal = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => JawabSoalLatihan(indexSoal: indexSoal,)
        );

      case '/modul/belajar':
        Map data = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => ModulBelajarIndex(idModul: data['idModul'], namaModul: data['namaModul'],)
        );

      case '/modul/belajar/detail':
        var data = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => ModulBelajarDetail(indexModulbelajar: data,)
        );

      case '/test-latihan':
        return MaterialPageRoute(
            builder: (_) => TestLatihan()
        );
    }
  }
}