import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterstarter/provider/HomeProvider.dart';
import 'package:flutterstarter/views/BaseView.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.blue,
        statusBarIconBrightness: Brightness.light));
    return BaseView<HomeProvider>(
      onModelReady: (model) => model.main(),
      builder: (context, provider, child) {
        return Scaffold(
            backgroundColor: Colors.white,

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
                                Icon(Icons.dehaze, color: Colors.white,),
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
                                Container(
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
                                      Icon(Icons.search, color: Colors.grey,),
                                      SizedBox(width: 8,),
                                      Text("Cari kosa kata", style: TextStyle(color: Colors.grey),)
                                    ],
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
                            onTap: (){
                              Navigator.pushNamed(context, '/kamus');
                            },
                            child: Container(
                              padding: EdgeInsets.all(8),
                              width: MediaQuery.of(context).size.width/2.7,
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
                                  ]
                              ),
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/images/kamus.png',
                                    width: 80,
                                  ),
                                  Spacer(),
                                  Text(
                                    "KAMUS",
                                    style: TextStyle(
                                        fontSize: 18
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),

                          InkWell(
                            onTap: (){
                              Navigator.pushNamed(context, '/modul');
                            },
                            child: Container(
                              padding: EdgeInsets.all(8),
                              width: MediaQuery.of(context).size.width/2.7,
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
                                  ]
                              ),
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/images/belajarkamus.png',
                                    width: 80,
                                  ),
                                  Spacer(),
                                  Text(
                                    "BELAJAR",
                                    style: TextStyle(
                                        fontSize: 18
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),

                          InkWell(
                            onTap: (){
                              Navigator.pushNamed(context, '/test-latihan');
                            },
                            child: Container(
                              padding: EdgeInsets.all(8),
                              width: MediaQuery.of(context).size.width/2.7,
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
                                  ]
                              ),
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/images/latihankamus.png',
                                    width: 80,
                                  ),
                                  Spacer(),
                                  Text(
                                    "LATIHAN",
                                    style: TextStyle(
                                        fontSize: 18
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(8),
                            width: MediaQuery.of(context).size.width/2.7,
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
                                ]
                            ),
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/kamus.png',
                                  width: 80,
                                ),
                                Spacer(),
                                Text(
                                  "PANDUAN",
                                  style: TextStyle(
                                      fontSize: 18
                                  ),
                                )
                              ],
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
