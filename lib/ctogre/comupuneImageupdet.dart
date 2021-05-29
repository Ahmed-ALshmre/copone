import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import '../edit_image.dart';

class UpImageFirst extends StatefulWidget {
  @override
  _UpImageFirstState createState() => _UpImageFirstState();
}

class _UpImageFirstState extends State<UpImageFirst> {
  // ignore: unused_field
  List<String> _list = [];
  // ignore: unused_field
  bool _upLoding = false;
  File file;
  String productId = DateTime.now().microsecondsSinceEpoch.toString();
  bool uploud = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("تحديث الاعلانات"),
        actions: [
          IconButton(
            iconSize: 30,
            icon: Icon(Icons.edit),
            onPressed: () {
              Route route =
                  MaterialPageRoute(builder: (context) => EditIamgesAda());
              Navigator.push(context, route);
            },
          ),
          SizedBox(
            width: 10,
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              File ImageFile =
                  await ImagePicker.pickImage(source: ImageSource.gallery);
              setState(() {
                file = ImageFile;
              });
              Fluttertoast.showToast(msg: "تم اضافة الصوره");
            },
          ),
        ],
      ),
      body: uploud
          ? Center(
              child: CircularProgressIndicator(),
            )
          : bodyCen(),
    );
  }

  Widget bodyCen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FlatButton(
            onPressed: () {
              if (file == null) {
                Fluttertoast.showToast(msg: "لا توجد صور");
              } else {
                setState(() {
                  uploud = true;
                });
                upLodingImageToItim();
              }
            },
            child: Container(
              height: 30,
              alignment: Alignment.center,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.blueAccent,
              ),
              child: Text(
                "تحديث",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  upLodingImageToItim() async {
    setState(() {
      _upLoding = true;
    });
    String imageDawalosUrl = await uploadeItmimImage(file);
    SavaItimInfo(imageDawalosUrl);
  }

  Future<String> uploadeItmimImage(myFile) async {
    final StorageReference storageReference =
        FirebaseStorage.instance.ref().child("Itmi");
    StorageUploadTask storageUploadTask =
        storageReference.child("product $productId.png").putFile(myFile);
    StorageTaskSnapshot taskSnapshot = await storageUploadTask.onComplete;
    String dionlodeUrl = await taskSnapshot.ref.getDownloadURL();
    return dionlodeUrl;
  }

  SavaItimInfo(String url) {
    Firestore.instance.collection('adaIamge').document(productId).setData({
      'uid': productId,
      "image": url,
    }).then((value) {
      Navigator.pop(context);
    });
  }
}
