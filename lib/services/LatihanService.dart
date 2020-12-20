import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutterstarter/models/DaftarKataModel.dart';
import 'package:flutterstarter/models/DaftarModulLatihanModel.dart';
import 'package:flutterstarter/models/DaftarSoalModulLatihanModel.dart';
import 'package:flutterstarter/services/Service.dart';

class LatihanService extends Service {
  Future getDaftarModulLatihan() async {
    try {
      var url = "/latihans/daftar-modul-latihan";
      print(url);
      var response = await get(url);
      print('gasss');
      print(response.statusCode);
      if (response.statusCode == 200) {
        DaftarModulLatihanModel daftarModulLatihanModel =
        daftarModulLatihanModelFromJson(jsonEncode(response.data));
        print(daftarModulLatihanModel);
        return daftarModulLatihanModel;
      } else {
        throw ('data tidak ditemukan');
      }
    } catch (error) {
      if (error is DioError) {
        print(error.response.statusCode);
        throw (error.response.statusCode);
      }
    }
  }

  Future getDaftarSoalModulLatihan(String idModulLatihan) async {
    try {
      var url = "/latihans/daftar-soal-modul-latihan/"+idModulLatihan;
      print(url);
      var response = await get(url);
      print('gasss');
      print(response.statusCode);
      if (response.statusCode == 200) {
        DaftarSoalModulLatihanModel daftarSoalModulLatihanModel =
        daftarSoalModulLatihanModelFromJson(jsonEncode(response.data));
        print(daftarSoalModulLatihanModel);
        return daftarSoalModulLatihanModel;
      } else {
        throw ('data tidak ditemukan');
      }
    } catch (error) {
      if (error is DioError) {
        print(error.response.statusCode);
        throw (error.response.statusCode);
      }
    }
  }
}