import 'package:flutterstarter/models/DaftarModulBelajarModel.dart';
import 'package:flutterstarter/models/DaftarSoalModulLatihanModel.dart';

class EventBusService{
  // modul belajar
  DaftarModulBelajarModel daftarModulBelajarModel;

  //soal latihan
  DaftarSoalModulLatihanModel daftarSoalModulLatihanModel;

  //simpan data soal yang dikerjaan user per modul
  // List progressLatihanUser = [
  //   {
  //     'namaModul' : '123',
  //     'soalSelesai' : [1,2,23,]
  //   }
  // ];
  List progressLatihanUser = [];
}