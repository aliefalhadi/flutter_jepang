import 'package:flutter/material.dart';
import 'package:flutterstarter/locator.dart';
import 'package:flutterstarter/views/Home.dart';
import 'package:flutterstarter/views/Router.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      onGenerateRoute: RouterApp.generateRoute,
    );
  }
}

