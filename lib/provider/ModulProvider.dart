import 'dart:convert';
import 'dart:io';

import 'package:flutterstarter/locator.dart';
import 'package:flutterstarter/models/DaftarModulBelajarModel.dart';
import 'package:flutterstarter/models/DaftarModulModel.dart';
import 'package:flutterstarter/provider/BaseProvider.dart';
import 'package:flutterstarter/services/EventBusService.dart';
import 'package:flutterstarter/services/ModulService.dart';
import 'package:flutterstarter/shareds/ViewState.dart';

class ModulProvider extends BaseProvider {
  DaftarModulModel daftarModulModel;
  DaftarModulBelajarModel daftarModulBelajarModel;
  List<Datum> listModul = [];
  ModulService modulService = locator<ModulService>();
  int page = 1;
  int oldPage;
  Map cariKata = {
    'kata' : ''
  };

  Future initDataModul() async {
    try {
      setState(ViewState.Fetching);
      await refreshDataModul();
    } catch (e) {
      print('erer');
      setState(ViewState.FetchNull);
    }
  }

  Future refreshDataModul() async {
    try {
      listModul = [];
      daftarModulModel =
      await modulService.getDaftarModul();
      daftarModulModel.data.forEach((element) {
        listModul.add(element);
      });
      setState(ViewState.Idle);
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

  Future getDaftarModulBelajar(String idModul) async {
    try {
      setState(ViewState.Fetching);
      daftarModulBelajarModel =
      await modulService.getDaftarModulBelajar(idModul);
      if(daftarModulBelajarModel.data.isEmpty){
        throw('errr');
      }
      locator<EventBusService>().daftarModulBelajarModel = daftarModulBelajarModel;
      setState(ViewState.Idle);
    } catch (e) {
      print('erer');
      setState(ViewState.FetchNull);
    }
  }
}