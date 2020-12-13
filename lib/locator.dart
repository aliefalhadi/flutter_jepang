import 'package:flutterstarter/provider/HomeProvider.dart';
import 'package:flutterstarter/provider/KamusProvider.dart';
import 'package:flutterstarter/provider/ModulProvider.dart';
import 'package:flutterstarter/services/ApiInterceptors.dart';
import 'package:flutterstarter/services/EventBusService.dart';
import 'package:flutterstarter/services/KamusService.dart';
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


  // provider
  locator.registerFactory(() => HomeProvider());
  locator.registerFactory(() => KamusProvider());
  locator.registerFactory(() => ModulProvider());
}