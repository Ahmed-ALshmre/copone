import 'package:flutter/material.dart';

class AppData with ChangeNotifier{
  List<dynamic> listAppData=[];
  List<dynamic> listAppDataCatoAr=[];
  List<dynamic> listAppDataCatEn=[];
  List<dynamic> market=[];
  conterIndex(List domo){
    listAppData=domo;
    notifyListeners();
  }
  // ignore: non_constant_identifier_names
  catoFirebase(List list ,ListEn){
    listAppDataCatoAr = list;
    listAppDataCatEn =ListEn;
    notifyListeners();
  }
  marketList(List list){
    market = list;
    notifyListeners();
  }

}