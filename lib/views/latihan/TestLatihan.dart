import 'dart:developer';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:toast/toast.dart';

class TestLatihan extends StatefulWidget {
  @override
  _TestLatihanState createState() => _TestLatihanState();
}

class _TestLatihanState extends State<TestLatihan> {


  SpeechToText _speech;
  bool _isListening = false;
  String _text = 'Press the button and start speaking';
  double _confidence = 1.0;

  @override
  void initState() {
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
                          var result = await flutterTts.speak("おはようございます");
                        },
                      ),
                      SizedBox(height: 16,),
                      Text("おはようございます")
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
      Future.delayed(Duration(seconds: 2), (){
        if(_text == 'おはようございます'){
          Toast.show(
              'Betulllll', context,
              duration: Toast.LENGTH_LONG,
              gravity: Toast.BOTTOM,
              backgroundColor: Colors.green);
        }else{
          Toast.show(
              'Salaahhhh', context,
              duration: Toast.LENGTH_LONG,
              gravity: Toast.BOTTOM,
              backgroundColor: Colors.red);
        }
        print(_text);
        _text = '';
      });
    }
  }
}
