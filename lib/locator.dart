import 'package:flutterstarter/provider/HomeProvider.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  //  init injected file
  //services


  // provider
  locator.registerLazySingleton(() => HomeProvider());
}