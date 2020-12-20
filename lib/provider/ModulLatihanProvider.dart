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
      print('asdasd');
      setState(ViewState.Fetching);
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
      int indexDataProgressLocal = locator<EventBusService>().progressLatihanUser.indexWhere((element2) => element2['idModulLatihan'] == element.idModulLatihan);

      if(indexDataProgressLocal == -1){
          listProgressLatihanUser.add(
            {
              "namaModulLatihan" : element.namaModulLatihan,
              "idModulLatihan" : element.idModulLatihan,
              "soalSelesai" : [],
              "nilaiProses" : 0
            }
          );
      }else{
        listProgressLatihanUser.add(
            {
              "namaModulLatihan" : element.namaModulLatihan,
              "idModulLatihan" : element.idModulLatihan,
              "soalSelesai" : locator<EventBusService>().progressLatihanUser[indexDataProgressLocal]['soalSelesai'],
              "nilaiProses" : locator<EventBusService>().progressLatihanUser[indexDataProgressLocal]['soalSelesai'].length /2
            }
        );
      }
    });
    print('listp');
    print(listProgressLatihanUser);
  }

}