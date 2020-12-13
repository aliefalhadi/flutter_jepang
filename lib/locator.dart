import 'package:flutterstarter/provider/HomeProvider.dart';
import 'package:flutterstarter/provider/KamusProvider.dart';
import 'package:flutterstarter/services/ApiInterceptors.dart';
import 'package:flutterstarter/services/KamusService.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  //  init injected file
  locator.registerLazySingleton(() => ApiInterceptors());

  //services
  locator.registerLazySingleton(() => KamusService());


  // provider
  locator.registerFactory(() => HomeProvider());
  locator.registerLazySingleton(() => KamusProvider());
}