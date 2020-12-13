import 'package:flutter/material.dart';
import 'package:flutterstarter/views/kamus/KamusIndex.dart';
import 'package:flutterstarter/views/latihan/TestLatihan.dart';

import 'Home.dart';

class RouterApp {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/home':
        return MaterialPageRoute(
            builder: (_) => MyHomePage(title: 'Flutter Demo Home Page')
        );

      case '/kamus':
        return MaterialPageRoute(
            builder: (_) => KamusIndex()
        );

      case '/test-latihan':
        return MaterialPageRoute(
            builder: (_) => TestLatihan()
        );
    }
  }
}