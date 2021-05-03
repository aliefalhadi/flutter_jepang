import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterstarter/locator.dart';
import 'package:flutterstarter/provider/HomeProvider.dart';
import 'package:flutterstarter/provider/LoginProvider.dart';
import 'package:flutterstarter/views/BaseView.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.blue,
        statusBarIconBrightness: Brightness.light));
    return BaseView<HomeProvider>(
      onModelReady: (model) => model.main(),
      builder: (context, provider, child) {
        return Scaffold(
            key: _drawerKey,
            endDrawerEnableOpenDragGesture: false,
            backgroundColor: Colors.white,
            drawer: Drawer(
              child: ListView(
                children: <Widget>[
                  SafeArea(
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.height / 1.4,
                        ),
                        InkWell(
                          child: ListTile(
                            title: Text(''),
                          ),
                          onTap: () async {
//                          Navigator.pop(context);
//                            Navigator.pushNamed(context, 'ganti-password');
                          },
                        ),
                        Divider(
                          height: 1,
                        ),
                        InkWell(
                          child: ListTile(
                            leading: Icon(Icons.exit_to_app),
                            title: Text('Keluar'),
                          ),
                          onTap: () async {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Keluar"),
                                    content: Text("Apakah anda yakin?"),
                                    actions: <Widget>[
                                      FlatButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "Batal",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                      FlatButton(
                                        onPressed: () async {
                                          showDialog(
                                              context: context,
                                              builder: (dialogContex) {
                                                return WillPopScope(
                                                  onWillPop: () async => false,
                                                  child: Center(
                                                    child: Card(
                                                      child: Container(
                                                        width: 80,
                                                        height: 80,
                                                        padding: EdgeInsets.all(
                                                            12.0),
                                                        child:
                                                            CircularProgressIndicator(),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              });
                                          bool res =
                                              await locator<LoginProvider>()
                                                  .logout();
                                          if (res) {
                                            Navigator.of(context)
                                                .pushNamedAndRemoveUntil(
                                                    '/login',
                                                    (Route<dynamic> route) =>
                                                        false);
                                          }
                                        },
                                        child: Text("Keluar"),
                                      )
                                    ],
                                  );
                                });
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20))),
                            height: 285,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 16, horizontal: 24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  child: Icon(
                                    Icons.dehaze,
                                    color: Colors.white,
                                  ),
                                  onTap: () {
                                    _drawerKey.currentState.openDrawer();
                                  },
                                ),
                                Center(
                                  child: Image.asset(
                                    'assets/images/welcome.png',
                                    width: 300,
                                  ),
                                ),
                                Text(
                                  "Selamat Datang,",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24),
                                ),
                                Text(
                                  "Tempat belajar bahasa jepang",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                InkWell(
                                  onTap: (){
                                    Navigator.pushNamed(context, '/kamus');
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(top: 8),
                                    padding: EdgeInsets.all(8),
                                    height: 40,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.2),
                                            blurRadius: 5.0,
                                            spreadRadius: 0.1,
                                            offset: Offset(
                                              0.0, // Move to right 10  horizontally
                                              5.0, // Move to bottom 5 Vertically
                                            ),
                                          ),
                                        ]),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.search,
                                          color: Colors.grey,
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          "Cari kosa kata",
                                          style: TextStyle(color: Colors.grey),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 8),
                      child: Wrap(
                        spacing: 32,
                        runSpacing: 16,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/kamus');
                            },
                            child: Container(
                              padding: EdgeInsets.all(8),
                              width: MediaQuery.of(context).size.width / 2.7,
                              height: 140,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 5.0,
                                      spreadRadius: 0.1,
                                      offset: Offset(
                                        0.0, // Move to right 10  horizontally
                                        5.0, // Move to bottom 5 Vertically
                                      ),
                                    )
                                  ]),
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/images/kamus.png',
                                    width: 80,
                                  ),
                                  Spacer(),
                                  Text(
                                    "KAMUS",
                                    style: TextStyle(fontSize: 18),
                                  )
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/modul');
                            },
                            child: Container(
                              padding: EdgeInsets.all(8),
                              width: MediaQuery.of(context).size.width / 2.7,
                              height: 140,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 5.0,
                                      spreadRadius: 0.1,
                                      offset: Offset(
                                        0.0, // Move to right 10  horizontally
                                        5.0, // Move to bottom 5 Vertically
                                      ),
                                    )
                                  ]),
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/images/belajarkamus.png',
                                    width: 80,
                                  ),
                                  Spacer(),
                                  Text(
                                    "BELAJAR",
                                    style: TextStyle(fontSize: 18),
                                  )
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/modul/latihan');
                            },
                            child: Container(
                              padding: EdgeInsets.all(8),
                              width: MediaQuery.of(context).size.width / 2.7,
                              height: 140,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 5.0,
                                      spreadRadius: 0.1,
                                      offset: Offset(
                                        0.0, // Move to right 10  horizontally
                                        5.0, // Move to bottom 5 Vertically
                                      ),
                                    )
                                  ]),
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/images/latihankamus.png',
                                    width: 80,
                                  ),
                                  Spacer(),
                                  Text(
                                    "LATIHAN",
                                    style: TextStyle(fontSize: 18),
                                  )
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              Alert(
                                context: context,
                                type: AlertType.none,
                                title: "PANDUAN APLIKASI",
                                content: Column(
                                  children: [
                                    Text("Aplikasi pembelajaran Bahasa Jepanag ini memiliki materi pembelajaran berasal dari buku \"Jago Kuasai Bahasa Jepang\" yang ditulis oleh Aditya R. Saputra S.S dab Bayu S. Wipriyanto, S.S.", textAlign: TextAlign.justify, style: Theme.of(context).textTheme.bodyText1,),
                                    SizedBox(height: 8,),
                                    Text("Aplikasi ini memiliki 6 sub menu materi yang terdiri dari kata sambung, kata bantu, kata sifat, kata ganti tunjuk, kata kerja dan kata benda.", textAlign: TextAlign.justify, style: Theme.of(context).textTheme.bodyText1,),
                                    SizedBox(height: 8,),
                                    Text("Dibawah ini adalah panduan menggunakan aplikasi:", textAlign: TextAlign.justify, style: Theme.of(context).textTheme.bodyText1,),
                                    Text("1. Pengguna aplikasi login menggunakan akun google.", textAlign: TextAlign.justify, style: Theme.of(context).textTheme.bodyText1,),
                                    Text("2. pengguna bisa belajar materi pada menu belajar.", textAlign: TextAlign.justify, style: Theme.of(context).textTheme.bodyText1,),
                                    Text("3. Penguna bisa melihat kosa kata bahsa jepang pada menu kamus.", textAlign: TextAlign.justify, style: Theme.of(context).textTheme.bodyText1,),
                                    Text("4. Pengguna bisa menyelesaikan semua kategori latihan pengucapakan pada menu latihan.", textAlign: TextAlign.justify, style: Theme.of(context).textTheme.bodyText1,),
                                  ],
                                ),
                                buttons: [
                                  DialogButton(
                                    child: Text(
                                      "OK",
                                      style: TextStyle(color: Colors.white, fontSize: 20),
                                    ),
                                    onPressed: () => Navigator.pop(context),
                                    width: 120,
                                  )
                                ],
                              ).show();
                            },
                            child: Container(
                              padding: EdgeInsets.all(8),
                              width: MediaQuery.of(context).size.width / 2.7,
                              height: 140,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 5.0,
                                      spreadRadius: 0.1,
                                      offset: Offset(
                                        0.0, // Move to right 10  horizontally
                                        5.0, // Move to bottom 5 Vertically
                                      ),
                                    )
                                  ]),
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/images/kamus.png',
                                    width: 80,
                                  ),
                                  Spacer(),
                                  Text(
                                    "PANDUAN",
                                    style: TextStyle(fontSize: 18),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ));
      },
    );
  }
}
