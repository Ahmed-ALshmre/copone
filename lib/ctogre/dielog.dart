import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class CustomDialog extends StatefulWidget {
  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  File file;
  TextEditingController arTextEd = TextEditingController();
  TextEditingController enTextEd = TextEditingController();
  TextEditingController codeTextEd = TextEditingController();
  TextEditingController titleTextEd = TextEditingController();
  TextEditingController titleEnTextEd = TextEditingController();

  bool full = true;
  bool isLod = false;
  cupturePhotoith() async {
    File ImageFile = await ImagePicker.pickImage(
        source: ImageSource.gallery, maxHeight: 680.0, maxWidth: 970.0);
    setState(() {
      file = ImageFile;
      full = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: isLod
          ? Center(
              child: CircularProgressIndicator(),
            )
          : body(),
    );
  }

  Widget body() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            full
                ? InkWell(
                    onTap: cupturePhotoith,
                    child: Container(
                      alignment: Alignment.center,
                      height: 45,
                      width: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blueAccent,
                      ),
                      child: Text(
                        'اضافة صوره',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  )
                : Container(
                    height: 300,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: FileImage(file)),
                    ),
                  ),
            SizedBox(
              height: 40,
            ),
            Container(
              padding: EdgeInsets.only(right: 6),
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(),
              ),
              child: TextField(
                controller: titleTextEd,
                textAlign: TextAlign.right,
                style: TextStyle(color: Colors.black, fontSize: 16),
                decoration: InputDecoration(
                  hintText: "العنوان",
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              padding: EdgeInsets.only(left: 6),
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(),
              ),
              child: TextField(
                controller: titleEnTextEd,
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.black, fontSize: 16),
                decoration: InputDecoration(
                  hintText: "Title",
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              padding: EdgeInsets.only(right: 6),
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(),
              ),
              child: TextField(
                controller: arTextEd,
                textAlign: TextAlign.right,
                maxLines: 3,
                style: TextStyle(color: Colors.black, fontSize: 16),
                decoration: InputDecoration(
                  hintText: "هل تريد اضافة نص ؟",
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              padding: EdgeInsets.only(right: 6),
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(),
              ),
              child: TextField(
                controller: codeTextEd,
                textAlign: TextAlign.right,
                style: TextStyle(color: Colors.black, fontSize: 16),
                decoration: InputDecoration(
                  hintText: "هل تريد اضافة كود ؟",
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              padding: EdgeInsets.only(left: 6),
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(),
              ),
              child: TextField(
                controller: enTextEd,
                textAlign: TextAlign.left,
                maxLines: 3,
                style: TextStyle(color: Colors.black, fontSize: 16),
                decoration: InputDecoration(
                  hintText: "Do you want to add text ?",
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  isLod = true;
                });
                if (file != null) {
                  print("file is not null ");
                  upLodingImageToItim();
                } else {
                  print("file is null");
                  SavaItimInfoImageNull();
                }
                upLodingImageToItim();
              },
              child: Container(
                alignment: Alignment.center,
                height: 35,
                width: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.blueAccent,
                ),
                child: Text("تحديث"),
              ),
            ),
          ],
        ),
      ),
    );
  }
  upLodingImageToItim() async {
    String imageDawalosUrl = await uploadeItmimImage(file);
    SavaItimInfo(imageDawalosUrl);
  }
  String productId = DateTime.now().microsecondsSinceEpoch.toString();
  Future<String> uploadeItmimImage(myFile) async {
    final StorageReference storageReference =
        FirebaseStorage.instance.ref().child("Itmi");
    StorageUploadTask storageUploadTask =
        storageReference.child("product $productId.jpg").putFile(myFile);
    StorageTaskSnapshot taskSnapshot = await storageUploadTask.onComplete;
    String dionlodeUrl = await taskSnapshot.ref.getDownloadURL();
    return dionlodeUrl;
  }

  SavaItimInfo(String url) {
    final itmeRef = Firestore.instance.collection('diel');
    itmeRef.document('1616341640957456').updateData({
      'artitle': arTextEd.text,
      'entitle': enTextEd.text,
      'publishedDate': DateTime.now(),
     "code":codeTextEd.text.trim().toString(),
      "titleAr" : titleTextEd.text.trim().toString(),
      "titleEn" : titleEnTextEd.text.trim().toString(),
      'thumbnailUrl': url,
    });
    setState(() {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "تم تحديث");
      file = null;
      // upLoding = false;
      // productId = DateTime.now().microsecondsSinceEpoch.toString();
      // _titelTextEditingController.clear();
    });
  }
  // ignore: non_constant_identifier_names
  void SavaItimInfoImageNull() {
    final itmeRef = Firestore.instance.collection('diel');
    itmeRef.document('1616341640957456').updateData({
      'artitle': arTextEd.text,
      'entitle': enTextEd.text,
      'publishedDate': DateTime.now(),
      'thumbnailUrl': null,
    });
    setState(() {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "تم تحديث");
      file = null;
      // upLoding = false;
      // productId = DateTime.now().microsecondsSinceEpoch.toString();
      // _titelTextEditingController.clear();
    });
  }
}
