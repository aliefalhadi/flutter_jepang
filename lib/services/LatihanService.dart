import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutterstarter/models/DaftarKataModel.dart';
import 'package:flutterstarter/models/DaftarModulLatihanModel.dart';
import 'package:flutterstarter/models/DaftarSoalModulLatihanModel.dart';
import 'package:flutterstarter/models/DataProgresUsermodel.dart';
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

  Future getProgresUser(String email) async {
    try {
      var url = "/latihans/progres-user";
      var data = {
        'email' : email
      };
      var response = await post(url, jsonEncode(data));
      print(email);
      print(response.statusCode);
      if (response.statusCode == 200) {
       if(response.data['data'] != null){
         DataProgresUserModel dataProgresUserModel =
         dataProgresUserModelFromJson(jsonEncode(response.data));
         print(dataProgresUserModel);
         return dataProgresUserModel;
       }else{
         throw ('data tidak ditemukan');
       }
      } else {
        print('err');
        throw ('data tidak ditemukan');
      }
    } catch (error) {
      if (error is DioError) {
        print(error.response.statusCode);
        throw (error.response.statusCode);
      }
    }
  }

  Future tambahPorgresUser(var data) async {
    try {
      var url = "/latihans/tambah-progres-user";
      print(url);
      print(data);
      var response = await post(url, data);
      print(response.statusCode);
      if (response.statusCode == 200) {
        return true;
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

  Future updatePorgresUser(var data) async {
    try {
      var url = "/latihans/update-progres-user";
      print(url);
      print(data);
      var response = await put(url, data);
      print(response.statusCode);
      if (response.statusCode == 200) {
        return true;
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