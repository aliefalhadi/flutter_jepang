import 'dart:convert';
import 'dart:io';

import 'package:flutterstarter/locator.dart';
import 'package:flutterstarter/models/DaftarModulBelajarModel.dart';
import 'package:flutterstarter/models/DaftarModulLatihanModel.dart';
import 'package:flutterstarter/models/DaftarModulModel.dart';
import 'package:flutterstarter/provider/BaseProvider.dart';
import 'package:flutterstarter/services/EventBusService.dart';
import 'package:flutterstarter/services/LatihanService.dart';
import 'package:flutterstarter/services/ModulService.dart';
import 'package:flutterstarter/shareds/ViewState.dart';

class ModulLatihanProvider extends BaseProvider {
  DaftarModulLatihanModel daftarModulLatihanModel;
  LatihanService latihanService = locator<LatihanService>();
  List listProgressLatihanUser = [];


  Future initDataModul() async {
    try {
      setState(ViewState.Fetching);
      listProgressLatihanUser = [];
      await getDaftarModulLatihan();
      await checkProgressLatihanUser(daftarModulLatihanModel);
      setState(ViewState.Idle);

    } catch (e) {
      print('erer');
      setState(ViewState.FetchNull);
    }
  }

  Future getDaftarModulLatihan() async {
    try {
      daftarModulLatihanModel = await latihanService.getDaftarModulLatihan();
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

  Future checkProgressLatihanUser(DaftarModulLatihanModel daftarModulLatihanModel) async{
    print('masuk');
    daftarModulLatihanModel.data.forEach((element) {
        //check progress dari db
      int indexDataProgressLocal = locator<EventBusService>().progressLatihanUser.indexWhere((element2) => element2['idModulLatihan'] == element.model.idModulLatihan);

      if(indexDataProgressLocal == -1){
          listProgressLatihanUser.add(
            {
              "namaModulLatihan" : element.model.namaModulLatihan,
              "idModulLatihan" : element.model.idModulLatihan,
              "soalSelesai" : [],
              "nilaiProses" : 0
            }
          );
      }else{
        listProgressLatihanUser.add(
            {
              "namaModulLatihan" : element.model.namaModulLatihan,
              "idModulLatihan" : element.model.idModulLatihan,
              "soalSelesai" : locator<EventBusService>().progressLatihanUser[indexDataProgressLocal]['soalSelesai'],
              "nilaiProses" : locator<EventBusService>().progressLatihanUser[indexDataProgressLocal]['soalSelesai'].length / int.parse(element.jumlahSoal) *100
            }
        );
      }
    });
    print('listp');
    print(listProgressLatihanUser);
  }

}