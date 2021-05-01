import 'dart:io';

import 'package:admin_copon/utiletes/tools.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class AddCountry extends StatefulWidget {
  @override
  _AddCountryState createState() => _AddCountryState();
}

class _AddCountryState extends State<AddCountry> {
  var _controller = TextEditingController();
  List<String> _list = [];
  bool _upLoding = false;
  File file;
  String productId = DateTime.now().microsecondsSinceEpoch.toString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("اضافة بلد"),
      ),
      body: _upLoding
          ?Center(
          child: CircularProgressIndicator()
            ):bodyCeantr(),
    );
  }
  Widget bodyCeantr() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () async {
              File ImageFile =
                  await ImagePicker.pickImage(source: ImageSource.gallery);
              setState(() {
                file = ImageFile;
              });
              Fluttertoast.showToast(msg: "تم اضافة العلم");
            },
            child: Container(
              alignment: Alignment.center,
              height: 40,
              width: 160,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black45,
              ),
              child: Text("اضافة العلم الدولة"),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.all(8),
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all()),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "اضافة بلد جديد",
                ),
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Center(
            child: InkWell(
              onTap: () {
                upLodingImageToItim();
              },
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text("اضافة"),
                ),
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
    Firestore.instance.collection('coon').document().setData({
      "name_c": _controller.text.trim().toString(),
      "image": url,
    }).then((value) {
      _controller.clear();
      Navigator.pop(context);
    });

  }
}
