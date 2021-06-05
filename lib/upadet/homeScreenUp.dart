import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class UpdateHomeScreen extends StatefulWidget {
  final  String textEn;
  final String textAir;
  final String id;
  final String code;

  const UpdateHomeScreen({Key key, this.textEn, this.textAir, this.code, this.id}) : super(key: key);
  @override
  _UpdateHomeScreenState createState() => _UpdateHomeScreenState();
}

class _UpdateHomeScreenState extends State<UpdateHomeScreen> {
  TextEditingController _controllerEnglish = TextEditingController();
  TextEditingController _controllerAir = TextEditingController();
  TextEditingController _controllerCop = TextEditingController();

  @override
  void dispose() {
 
    super.dispose();
  _controllerAir.dispose();
  _controllerCop.dispose();
  _controllerEnglish.dispose();
  }
  @override
  void initState() {
    
    super.initState();
    _controllerCop.text = widget.code;
    _controllerAir.text=widget.textAir;
    _controllerEnglish.text=widget.textEn;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SizedBox(height: 10,),
          Text("Edit Text"),
          Padding(
            padding:  EdgeInsets.all(8.0),
            child: Container(
              height:60,
        decoration: BoxDecoration(
            border: Border.all(),
        ),
              child: TextField(
                controller: _controllerEnglish,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              ),
            ),
          ),
          SizedBox(height: 10,),
          Text("تعديل النص"),
          Padding(
            padding:  EdgeInsets.all(8.0),
            child: Container(
              height:60,
              decoration: BoxDecoration(
                border: Border.all(),
              ),
              child: TextField(
                controller: _controllerAir,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          SizedBox(height: 10,),
          Text("تعديل الكوبون"),
          Padding(
            padding:  EdgeInsets.all(8.0),
            child: Container(
              height:60,
              decoration: BoxDecoration(
                border: Border.all(),
              ),
              child: TextField(
                controller: _controllerCop,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: (){
              Firestore.instance.collection('items').document(widget.id).updateData({
                "titleEn":_controllerEnglish.text,
                "titleAr":_controllerAir.text,
                "code":_controllerCop.text,
              }).then((value)  {
              _controllerCop.clear();
              _controllerAir.clear();
              _controllerEnglish.clear();
              }).catchError((e)=>print(e.toString()));
            },
            child: Container(
              alignment: Alignment.center,
              height: 40,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.black45
              ),
              child: Text("Update",style: TextStyle(color: Colors.white,fontSize: 16),),
            ),
          ),
        ],
      ),
    );
  }
}
