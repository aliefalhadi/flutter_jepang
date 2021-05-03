import 'dart:convert';

import 'package:flutterstarter/locator.dart';
import 'package:flutterstarter/models/DataProgresUsermodel.dart';
import 'package:flutterstarter/services/EventBusService.dart';
import 'package:flutterstarter/services/LatihanService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainProvider {
  Future<String> onStartApp() async {
    try{
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

      if (sharedPreferences.containsKey('isLogin')) {
        print('login');
        bool isLogin = sharedPreferences.getBool('isLogin');
        if (isLogin) {
          await getProgresUser(sharedPreferences.getString('email'));

          return '/home';
        } else {
          return '/login';
        }
      } else {
        return '/login';
      }
    }catch(e){
      print('err');
      return '/login';
    }
  }

  Future getProgresUser(String email) async{
    try{
      DataProgresUserModel dataProgresUserModel = await locator<LatihanService>().getProgresUser(email);
      if(dataProgresUserModel.data == null ){
        locator<EventBusService>().progressLatihanUser = [];
      }else{
        locator<EventBusService>().progressLatihanUser = jsonDecode(dataProgresUserModel.data.progres);
      }
    }catch(e){

    }
  }
}