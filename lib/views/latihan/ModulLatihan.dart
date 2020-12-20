import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterstarter/provider/ModulLatihanProvider.dart';
import 'package:flutterstarter/shareds/ViewState.dart';
import 'package:flutterstarter/views/BaseView.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

class ModulLatihan extends StatefulWidget {
  @override
  _ModulLatihanState createState() => _ModulLatihanState();
}

class _ModulLatihanState extends State<ModulLatihan> {
  @override
  Widget build(BuildContext context) {
    return BaseView<ModulLatihanProvider>(
      onModelReady: (model) => model.initDataModul(),
      builder: (context, provider, child){
        return  Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text("Modul Latihan"),
          ),
          body:
          provider.state == ViewState.Fetching ?
              Center(child: CircularProgressIndicator(),)
              :
          SingleChildScrollView(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))
                          ),
                          height: 200,
                        ),
                        Container(
                            padding: EdgeInsets.symmetric(vertical: 24),
                            child:
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    padding: EdgeInsets.symmetric(horizontal: 16),
                                    child: Text('Daftar modul latihan', style: TextStyle(color: Colors.white,fontSize: 16, fontWeight: FontWeight.bold),)
                                ),
                                SizedBox(height: 16,),
                                Container(
                                  height: 250,
                                  child: ScrollSnapList(
                                    onItemFocus: null,
                                    itemCount: provider.daftarModulLatihanModel.data.length,
                                    itemSize: 195,
                                    dynamicItemSize: true,
                                    itemBuilder: (context, index){
                                      return InkWell(
                                        onTap: (){
                                          Navigator.pushNamed(context, '/modul/latihan/soal', arguments: provider.listProgressLatihanUser[index]).then((value) => provider.initDataModul());
                                        },
                                        child: Card(
                                          color: index%2 != 0 ? Colors.deepPurpleAccent : Colors.lightBlue,
                                          elevation: 2,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(20)
                                          ),
                                          child: Container(
                                            width: 180,
                                            height: 230,
                                            child: Stack(
                                              children: [
                                                Align(alignment:Alignment.bottomRight,child: Image.asset('assets/images/latihankamus.png', width: 130,)),
                                                Container(
                                                  padding: EdgeInsets.all(24),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(provider.daftarModulLatihanModel.data[index].model.namaModulLatihan, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),),
                                                      SizedBox(height: 16,),
                                                      CircleAvatar(
                                                        backgroundColor: Colors.redAccent.withOpacity(0.2),
                                                        child: Icon(Icons.play_arrow),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            )

                        )
                      ],
                    ),
                  ),

                  // recent
                  Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Progres latihan", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                        SizedBox(height: 16,),

                        ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: provider.listProgressLatihanUser.length,
                            itemBuilder: (context, index){
                              return Column(
                                children: [
                                  Card(
                                    margin: EdgeInsets.zero,
                                    child: Container(
                                      child: ListTile(
                                        leading: Container(
                                          padding: EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                              color: index%2 != 0 ?  Colors.deepPurpleAccent.withOpacity(0.5) :  Colors.lightBlue.withOpacity(0.5),
                                              borderRadius: BorderRadius.circular(8)
                                          ),
                                          child: Icon(Icons.assignment,color: Colors.white,),
                                        ),
                                        title: Text(provider.listProgressLatihanUser[index]['namaModulLatihan'], style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 16),),
                                        subtitle: Text(provider.listProgressLatihanUser[index]['nilaiProses'] != 100 ? "kamu belum selesaikan latihan" : "kamu telah selesaikan latihan",style: Theme.of(context).textTheme.caption,),
                                        trailing: CircularPercentIndicator(
                                          radius: 35.0,
                                          lineWidth: 2.0,
                                          percent: provider.listProgressLatihanUser[index]['nilaiProses']/100,
                                          center: Text(provider.listProgressLatihanUser[index]['nilaiProses'].toString()+"%", style: TextStyle(fontSize: 8),),
                                          progressColor : index%2 != 0 ? Colors.deepPurpleAccent : Colors.lightBlue,
                                        ),
                                      ),
                                    ),
                                  ),

                                  SizedBox(height: 16,),
                                ],
                              );
                            }
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
