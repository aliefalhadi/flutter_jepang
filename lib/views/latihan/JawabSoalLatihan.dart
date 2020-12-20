import 'dart:developer';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutterstarter/locator.dart';
import 'package:flutterstarter/models/DaftarSoalModulLatihanModel.dart';
import 'package:flutterstarter/services/EventBusService.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:toast/toast.dart';

class JawabSoalLatihan extends StatefulWidget {
  int indexSoal;
  JawabSoalLatihan({this.indexSoal});
  @override
  _JawabSoalLatihanState createState() => _JawabSoalLatihanState();
}

class _JawabSoalLatihanState extends State<JawabSoalLatihan> {
  Datum dataSoal;

  SpeechToText _speech;
  bool _isListening = false;
  String _text = 'Press the button and start speaking';


  @override
  void initState() {
    dataSoal = locator<EventBusService>().daftarSoalModulLatihanModel.data[widget.indexSoal];
    super.initState();
    _speech = SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Latihan Pengucapan'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        animate: _isListening,
        glowColor: Theme.of(context).primaryColor,
        endRadius: 75.0,
        duration: const Duration(milliseconds: 2000),
        repeatPauseDuration: const Duration(milliseconds: 100),
        repeat: true,
        child: FloatingActionButton(
          onPressed: _listen,
          child: Icon(_isListening ? Icons.mic : Icons.mic_none),
        ),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Card(
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        "Ketuk speaker untuk mendengarkan pelafalan",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                      SizedBox(height: 16,),
                      InkWell(
                          child: Icon(Icons.volume_up),
                        onTap: () async{
                          FlutterTts flutterTts = FlutterTts();
                          await flutterTts.setLanguage("ja-JP");
                          await flutterTts.setSpeechRate(1.0);
                          await flutterTts.setPitch(0.3);
                          await flutterTts.speak(dataSoal.textJepang);
                        },
                      ),
                      SizedBox(height: 16,),
                      Text(dataSoal.textJepang, style: TextStyle(fontSize: 21),),
                      SizedBox(height: 8,),
                      Text(dataSoal.textLatin, style: TextStyle(fontStyle: FontStyle.italic),),
                      SizedBox(height: 8,),
                      Text(dataSoal.terjemahanText, style: Theme.of(context).textTheme.bodyText1,),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          localeId: 'ja_JP',
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            child: Container(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(width: 8,),
                  Text("Loading"),
                ],
              ),
            ),
          );
        },
      );
      Future.delayed(Duration(seconds: 2), (){
        if(_text == dataSoal.textJepang){
          //simpan ke soal selesai di local
          int indexDataProgressLocal = locator<EventBusService>().progressLatihanUser.indexWhere((element2) => element2['idModulLatihan'] == dataSoal.idModulLatihan);
          print('jawabb');
          print(indexDataProgressLocal);
          if(indexDataProgressLocal == -1){
            locator<EventBusService>().progressLatihanUser.add(
              {
                'idModulLatihan' : dataSoal.idModulLatihan,
                'soalSelesai' : [dataSoal.nomorSoal]
              }
            );
          }else{
            //tambahkan ke daftar soalselesai
            locator<EventBusService>().progressLatihanUser[indexDataProgressLocal]['soalSelesai'] = [...locator<EventBusService>().progressLatihanUser[indexDataProgressLocal]['soalSelesai'], dataSoal.nomorSoal];
          }
          print(locator<EventBusService>().progressLatihanUser);
          Navigator.pop(context);
          Dialogs.materialDialog(
              color: Colors.white,
              msg: 'Selamat anda berhasil melafalkan kata dengan benar',
              title: 'Berhasil',
              animations: 'assets/images/congrat.json',
              context: context,
              actions: [
                IconsButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  text: 'Ok',
                  iconData: Icons.done,
                  color: Colors.blue,
                  textStyle: TextStyle(color: Colors.white),
                  iconColor: Colors.white,
                ),
              ]);
        }else{
          Navigator.pop(context);
          Dialogs.materialDialog(
              color: Colors.white,
              msg: 'Maaf, anda belum berhasil ayo coba lagi',
              title: 'Gagal',
              animations: 'assets/images/failed.json',
              context: context,
              actions: [
                IconsButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  text: 'Ok',
                  iconData: Icons.done,
                  color: Colors.blue,
                  textStyle: TextStyle(color: Colors.white),
                  iconColor: Colors.white,
                ),
              ]);
        }
        print(_text);
        _text = '';
      });
    }
  }
}
