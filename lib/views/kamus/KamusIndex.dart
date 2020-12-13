import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutterstarter/models/DaftarKataModel.dart';
import 'package:flutterstarter/provider/KamusProvider.dart';
import 'package:flutterstarter/shareds/ViewState.dart';
import 'package:flutterstarter/views/BaseView.dart';

class KamusIndex extends StatefulWidget {
  @override
  _KamusIndexState createState() => _KamusIndexState();
}

class _KamusIndexState extends State<KamusIndex> {
  ScrollController _scrollController;

  @override
  void initState() {
    // TODO: implement initState
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BaseView<KamusProvider>(
      onModelReady: (model) => model.initDataKamus(),
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Kamus Jepang"),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(80),
              child: Container(
                padding: EdgeInsets.all(16),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  child: TextFormField(
                    onChanged: (value){
                      provider.cariKata['kata'] = value;
                    },
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () async {
                          if(provider.cariKata['kata'] == ''){
                            provider.initDataKamus();
                          }else{
                            provider.getCariKata();
                          }
                        },
                      ),
                      hintText: "Cari kata",
                      contentPadding: new EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 8),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xff00c292), width: 0.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 0.0),
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ),
              ),
            ),
          ),
          body: provider.state == ViewState.Fetching &&
                  provider.listKataKamus.length == 0
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : provider.state == ViewState.FetchNull &&
                      provider.listKataKamus.length == 0
                  ? Center(
                      child: Text("data tidak ditemukan"),
                    )
                  : RefreshIndicator(
                      onRefresh: () {
                        return provider.refreshDataKamus();
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        child: ListView.builder(
                          controller: provider.listKataKamus.length > 5
                              ? (_scrollController
                            ..addListener(() {
                              if (_scrollController.position.pixels ==
                                  _scrollController
                                      .position.maxScrollExtent) {
                                // Perform your task
                                if (provider.state !=
                                    ViewState.Fetching) {
                                  provider.getNextDataKamus();
                                }
                              }
                            }))
                              : null,
                          itemCount: provider.state == ViewState.Fetching
                              ? provider.listKataKamus.length + 1
                              : provider.listKataKamus.length,
                          itemBuilder: (context, index) {
                            if (provider.state == ViewState.Fetching &&
                                index == provider.listKataKamus.length) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child:
                                    Center(child: CircularProgressIndicator()),
                              );
                            } else {
                              Datum data = provider.listKataKamus[index];
                              return Card(
                                child: Container(
                                  padding: EdgeInsets.all(16),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          RichText(
                                            text: TextSpan(children: [
                                              TextSpan(
                                                  text: data.kataJepangHiragana,
                                                  style: TextStyle(
                                                      fontSize: 21,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.black)),
                                              TextSpan(
                                                  text: ' [hiragana]',
                                                  style: TextStyle(
                                                      color: Colors.black)),
                                            ]),
                                          ),
                                          data.kataJepangKatakana != '' ?  RichText(
                                            text: TextSpan(children: [
                                              TextSpan(
                                                  text: data.kataJepangKatakana,
                                                  style: TextStyle(
                                                      fontSize: 21,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.black)),
                                              TextSpan(
                                                  text: ' [katana]',
                                                  style: TextStyle(
                                                      color: Colors.black)),
                                            ]),
                                          ) : Container(),

                                          data.kataJepangKanji != '' ?  RichText(
                                            text: TextSpan(children: [
                                              TextSpan(
                                                  text: data.kataJepangKanji,
                                                  style: TextStyle(
                                                      fontSize: 21,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.black)),
                                              TextSpan(
                                                  text: ' [kanji]',
                                                  style: TextStyle(
                                                      color: Colors.black)),
                                            ]),
                                          ) : Container(),
                                          Text(
                                            data.kataLatin,
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic),
                                          ),
                                          Text(data.terjemahanKata),
                                        ],
                                      ),
                                      InkWell(
                                          child: Icon(Icons.audiotrack),
                                        onTap: () async{
                                          FlutterTts flutterTts = FlutterTts();
                                          await flutterTts.setLanguage("ja-JP");
                                          await flutterTts.setSpeechRate(1.0);
                                          await flutterTts.setPitch(0.3);
                                          var result = await flutterTts.speak("${data.kataJepangKanji != '' ? data.kataJepangKanji : data.kataJepangHiragana}");
//                                          final translator = GoogleTranslator();
//                                          translator.
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ),
        );
      },
    );
  }
}
