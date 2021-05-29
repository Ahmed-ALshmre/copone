import 'package:admin_copon/edit/cato_edit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Cato extends StatefulWidget {
  @override
  _CatoState createState() => _CatoState();
}

class _CatoState extends State<Cato> {
  TextEditingController arTextEd = TextEditingController();
  TextEditingController enTextEd = TextEditingController();
  String productId = DateTime.now().microsecondsSinceEpoch.toString();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>EditCato()));
            },
          ),
        ],
      ),
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
    final itmeRef = Firestore.instance.collection('list');
    itmeRef.document(productId).setData({
      "artitle":enTextEd.text,
      "entitle":arTextEd.text,
      "uid":productId,
    });
    Fluttertoast.showToast(msg: "تم اضافة");
    setState(() {
      Navigator.pop(context);
      enTextEd.clear();
      arTextEd.clear();
    });
  }
}
