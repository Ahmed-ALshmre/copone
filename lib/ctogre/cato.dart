import 'package:admin_copon/utiletes/tools.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Cato extends StatefulWidget {
  @override
  _CatoState createState() => _CatoState();
}

class _CatoState extends State<Cato> {
  List<String> _arCato = [];
  List<String> _enCato = [];
  TextEditingController arTextEd = TextEditingController();
  TextEditingController enTextEd = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(right: 10),
              height: 50,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(),
              ),
              child: TextField(
                controller: arTextEd,
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: "اضافة فىْة"),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 10),
              height: 50,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(),
              ),
              child: TextField(
                controller: enTextEd,
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: "Add category"),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            InkWell(
              onTap: SavaItimInfo,
              child: Container(
                alignment: Alignment.center,
                height: 40,
                width: MediaQuery.of(context).size.width * 0.6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blueAccent,
                ),
                child: Text(
                  "اضافة",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  void SavaItimInfo() {
    setState(() {
      _enCato.add(enTextEd.text);
      _arCato.add(arTextEd.text);
      EcommerceApp.sharedPreferences.setStringList('en', _enCato);
      EcommerceApp.sharedPreferences.setStringList('ar', _arCato);
      print(EcommerceApp.sharedPreferences.getStringList("en"));
      print(EcommerceApp.sharedPreferences.getStringList("ar"));
    });
    final itmeRef = Firestore.instance.collection('list');
    itmeRef.document("i4bfCOrOshdSFcMR5QzD").updateData({
      "artitle":EcommerceApp.sharedPreferences.getStringList("ar"),
      "entitle":EcommerceApp.sharedPreferences.getStringList("en"),
    });
    Fluttertoast.showToast(msg: "تم اضافة");
    setState(() {
      enTextEd.clear();
      arTextEd.clear();
    });
  }
}
