import 'dart:convert';
import 'dart:io';

import 'package:flutterstarter/locator.dart';
import 'package:flutterstarter/models/DaftarModulBelajarModel.dart';
import 'package:flutterstarter/models/DaftarModulLatihanModel.dart';
import 'package:flutterstarter/models/DaftarModulModel.dart';
import 'package:flutterstarter/models/DaftarSoalModulLatihanModel.dart';
import 'package:flutterstarter/provider/BaseProvider.dart';
import 'package:flutterstarter/services/EventBusService.dart';
import 'package:flutterstarter/services/LatihanService.dart';
import 'package:flutterstarter/services/ModulService.dart';
import 'package:flutterstarter/shareds/ViewState.dart';

class ModulLatihanSoalProvider extends BaseProvider {
  DaftarSoalModulLatihanModel daftarSoalModulLatihanModel;
  LatihanService latihanService = locator<LatihanService>();
  List listDaftarSoal = [];


  Future initDataSoalModulLatihan(String idModulLatihan) async {
    try {
      setState(ViewState.Fetching);

      listDaftarSoal = [];
      List dataSoalSelesai = [];
      int indexDataProgressLocal = locator<EventBusService>().progressLatihanUser.indexWhere((element2) => element2['idModulLatihan'].toString() == idModulLatihan);
      if(indexDataProgressLocal !=-1){
        dataSoalSelesai = locator<EventBusService>().progressLatihanUser[indexDataProgressLocal]['soalSelesai'];
      }
      print(indexDataProgressLocal);
      print(locator<EventBusService>().progressLatihanUser);

      await getDaftarSoalModulLatihan(idModulLatihan);
      await checkProgressLatihanUser(dataSoalSelesai);
      setState(ViewState.Idle);

    } catch (e) {
      print('erer');
      setState(ViewState.FetchNull);
    }
  }

  Future getDaftarSoalModulLatihan(String idModulLatihan) async {
    try {
      daftarSoalModulLatihanModel = await latihanService.getDaftarSoalModulLatihan(idModulLatihan);
      //simpan di local
      locator<EventBusService>().daftarSoalModulLatihanModel = daftarSoalModulLatihanModel;
    } on SocketException catch (e) {
      setState(ViewState.ErrConnection);
    } catch (e) {
      if (e == 404 || e == 502 || e == 503) {
        setState(ViewState.ErrConnection);
      } else {
        setState(ViewState.FetchNull);
      }
    }
  }

  Future checkProgressLatihanUser(List dataSoalSelesai) async{
    daftarSoalModulLatihanModel.data.forEach((element) {
        //check progress dari db
        if(dataSoalSelesai.contains(element.nomorSoal)){
          listDaftarSoal.add(
              {
                "dataSoal" : element,
                "isSelesai" : true,
              }
          );
        }else{
          listDaftarSoal.add(
              {
                "dataSoal" : element,
                "isSelesai" : false,
              }
          );
        }
    });
  }

}