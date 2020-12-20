import 'package:flutter/material.dart';
import 'package:flutterstarter/locator.dart';
import 'package:flutterstarter/provider/MainProvider.dart';
import 'package:flutterstarter/views/Home.dart';
import 'package:flutterstarter/views/Login.dart';
import 'package:flutterstarter/views/Router.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  MainProvider mainProvider = locator<MainProvider>();
  mainProvider.onStartApp().then((value) {
    return runApp(MyApp(route: value,));
  });

}

class MyApp extends StatelessWidget {
  final String route;
  MyApp({this.route});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme:
          GoogleFonts.montserratTextTheme(Theme.of(context).textTheme),
      ),
      home: route == '/login' ? Login() : MyHomePage(),
      onGenerateRoute: RouterApp.generateRoute,
    );
  }
}

