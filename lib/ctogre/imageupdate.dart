import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class UpImageLogo extends StatefulWidget {
  @override
  _UpImageLogoState createState() => _UpImageLogoState();
}

class _UpImageLogoState extends State<UpImageLogo> {
  List<Asset> images = List<Asset>();
  String _error = 'No Error Dectected';
  bool isUp = false;
  List<String> imageUrls = <String>[];
  Widget buildGridView() {
    return Container(
      height: 200,
      child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 4,
        children: List.generate(images.length, (index) {
          Asset asset = images[index];
          return AssetThumb(
            height: 200,
            width: 200,
            asset: asset,
          );
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            height: 300,
            child: buildGridView(),
          ),
          isUp
              ? InkWell(
                  onTap: () {
                    loadAssets();
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
                      "اضف صوره",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ))
              : InkWell(
                  onTap: () {
                    setState(() {

                    });
                    uploadImages();
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
                  )),
        ],
      ),
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 20,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "MY Luxbazr",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
      isUp = false;
      _error = error;
    });
  }

  void uploadImages() {
    for (var imageFile in images) {
      postImage(imageFile).then((downloadUrl) {
        imageUrls.add(downloadUrl.toString());
        if (imageUrls.length == images.length) {
          // ignore: unused_local_variable
          String documnetID = DateTime.now().millisecondsSinceEpoch.toString();
          Firestore.instance
              .collection('imageLogo')
              .document("1619823892652")
              .updateData({'urls': imageUrls}).then((value) {
            Navigator.pop(context);
          });
        }
      }).catchError((err) {
        print("we have e");
        print(err);
      });
    }
  }

  Future<dynamic> postImage(Asset imageFile) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    StorageReference reference = FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask =
        reference.putData((await imageFile.getByteData()).buffer.asUint8List());
    StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
    print(storageTaskSnapshot.ref.getDownloadURL());
    return storageTaskSnapshot.ref.getDownloadURL();
  }
}
