import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutterstarter/locator.dart';
import 'package:flutterstarter/models/DaftarModulBelajarModel.dart';
import 'package:flutterstarter/services/EventBusService.dart';

class ModulBelajarDetail extends StatefulWidget {
  final int indexModulbelajar;
  ModulBelajarDetail({this.indexModulbelajar});
  @override
  _ModulBelajarDetailState createState() => _ModulBelajarDetailState();
}

class _ModulBelajarDetailState extends State<ModulBelajarDetail> {
  DatumBelajar datumBelajar;
  @override
  void initState() {
    // TODO: implement initState
    datumBelajar = locator<EventBusService>().daftarModulBelajarModel.data[widget.indexModulbelajar];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(datumBelajar.polaBelajar),
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
                        "Penjelasan:",
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "Ketuk speaker untuk mendengarkan penjelasan",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                      SizedBox(height: 16,),
                      InkWell(
                        child: Icon(Icons.volume_up),
                        onTap: () async{
                          FlutterTts flutterTts = FlutterTts();
                          await flutterTts.setLanguage("id-ID");
                          await flutterTts.setSpeechRate(1.0);
                          await flutterTts.setPitch(0.3);
                          await flutterTts.speak(datumBelajar.hintText);
                        },
                      ),
                      SizedBox(height: 16,),
                      Text(
                        datumBelajar.hintText,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16,),
                      Text(
                        "Contoh:",
                        textAlign: TextAlign.center,
                      ),
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
                          await flutterTts.speak(datumBelajar.speechText);
                        },
                      ),
                      SizedBox(height: 16,),
                      Text(datumBelajar.speechText, style: TextStyle(fontSize: 21),),
                      SizedBox(height: 16,),

                      Text(datumBelajar.textLatin, style: TextStyle(fontStyle: FontStyle.italic),),
                      SizedBox(height: 16,),

                      Text(datumBelajar.terjemahanText, style: TextStyle(fontWeight: FontWeight.bold),),

                    ],
                  ),
                ),
              ),
              SizedBox(height: 16,),
              Row(
                children: [
                Expanded(
                  child: OutlineButton(
                    borderSide: BorderSide(color: Colors.blue),
                    onPressed: widget.indexModulbelajar  == 0 ? null :
                        (){
                      Navigator.pushReplacementNamed(context, '/modul/belajar/detail', arguments: widget.indexModulbelajar-1);
                    },
                    child: Text("Sebelumnya", style: TextStyle(color: Colors.blue),),
                  ),
                ),
                SizedBox(width: 16,),
                Expanded(
                  child: RaisedButton(
                    color: Colors.blue,
                      onPressed: widget.indexModulbelajar +1 == locator<EventBusService>().daftarModulBelajarModel.data.length ? null :
                          (){
                            Navigator.pushReplacementNamed(context, '/modul/belajar/detail', arguments: widget.indexModulbelajar+1);
                          },
                      child: Text("Selanjutnya", style: TextStyle(color: Colors.white),),
                      ),
                )
              ],)
            ],
          ),
        ),
      ),
    );
  }
}
