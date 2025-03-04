import 'package:flutterstarter/provider/HomeProvider.dart';
import 'package:flutterstarter/provider/KamusProvider.dart';
import 'package:flutterstarter/provider/LoginProvider.dart';
import 'package:flutterstarter/provider/MainProvider.dart';
import 'package:flutterstarter/provider/ModulLatihanProvider.dart';
import 'package:flutterstarter/provider/ModulLatihanSoalProvider.dart';
import 'package:flutterstarter/provider/ModulProvider.dart';
import 'package:flutterstarter/services/ApiInterceptors.dart';
import 'package:flutterstarter/services/EventBusService.dart';
import 'package:flutterstarter/services/KamusService.dart';
import 'package:flutterstarter/services/LatihanService.dart';
import 'package:flutterstarter/services/ModulService.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  //  init injected file
  locator.registerLazySingleton(() => ApiInterceptors());
  locator.registerLazySingleton(() => EventBusService());

  //services
  locator.registerLazySingleton(() => KamusService());
  locator.registerLazySingleton(() => ModulService());
  locator.registerLazySingleton(() => LatihanService());


  // provider
  locator.registerFactory(() => MainProvider());
  locator.registerFactory(() => LoginProvider());
  locator.registerFactory(() => HomeProvider());
  locator.registerFactory(() => KamusProvider());
  locator.registerFactory(() => ModulProvider());
  locator.registerFactory(() => ModulLatihanProvider());
  locator.registerFactory(() => ModulLatihanSoalProvider());
}