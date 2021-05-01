import 'dart:io';
import 'package:admin_copon/delog/toolsdelog.dart';
import 'package:admin_copon/utiletes/delog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f_datetimerangepicker/f_datetimerangepicker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:admin_copon/appData/appData.dart';
import '../classMuilteN.dart';
import '../modelList.dart';

class ItemClass {
  String name;
  String id;
  ItemClass({this.name, this.id});
}

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage>
    with AutomaticKeepAliveClientMixin<UploadPage> {
  TextEditingController _titleArTextEditingController = TextEditingController();
  TextEditingController _codeTextEditingController = TextEditingController();
  TextEditingController _titleEnlTextEditingController =
      TextEditingController();

  String productId = DateTime.now().microsecondsSinceEpoch.toString();
  File file;
  List<String> listEnAr;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget getListCatogre() {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('list').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Center(
              child: CircularProgressIndicator(),
            );
          default:
            return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  ModelListItem modelListItem = ModelListItem.fromJson(
                      snapshot.data.documents[index].data);
                  print(modelListItem.listEr);
                  Provider.of<AppData>(context, listen: false)
                      .conterIndex(modelListItem.listCon);
                  Provider.of<AppData>(context, listen: false)
                      .catoFirebase(modelListItem.listEr, modelListItem.listAr);
                  print(modelListItem.listAr);
                  print(modelListItem.listCon);
                  return Container(
                    child: Text(modelListItem.listEr[index]),
                  );
                });
        }
      },
    );
  }

  final List<String> countries = [
    'United Kingdom',
    'USA',
    'France',
    'Australia',
    'New Zealand',
    'Germany',
    'Vietnam',
    'India'
  ];

  String endE;
  String startS;
  TextEditingController teamController = TextEditingController();
  bool upLoding = false;
  bool get wantKeepAlive => true;
  String formattedDate;
  @override
  Widget build(BuildContext context) {
    var now = new DateTime.now();
    var formatter = new DateFormat("dd-MM-yyyy h:mma");
    formattedDate = formatter.format(now);
    teamController.text = formattedDate;
    print("1");
    return file == null ? displayAAdmin() : displayUplaodHome();
  }

  displayAAdmin() {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Colors.lightGreenAccent,
                  Colors.pink,
                ],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(1.0, 0.0),
                stops: [0, 1.0],
                tileMode: TileMode.clamp),
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.border_color,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        actions: [
          FlatButton(
              child: Text(
            'LogOut',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ))
        ],
      ),
      body: getAdninScreenBodey(),
    );
  }

  getAdninScreenBodey() {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.lightGreenAccent, Colors.pink],
              begin: FractionalOffset(1.0, 0.0),
              end: FractionalOffset(1.0, 1))),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(height: 10, child: getListCatogre()),
            Icon(
              Icons.shopping_bag,
              size: 200,
              color: Colors.white,
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: Text(
                  'Add New Items',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                color: Colors.green,
                onPressed: () => tickImage(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<ItemClass> _selectedAnimals3 = [];
  tickImage(myContext) {
    showDialog(
        context: myContext,
        builder: (c) {
          return SimpleDialog(
            title: Text(
              'Itam Image',
              style: TextStyle(
                color: Colors.green,
              ),
            ),
            children: [
              SimpleDialogOption(
                child: Text(
                  'Capture with Camera',
                  style: TextStyle(
                    color: Colors.green,
                  ),
                ),
                onPressed: cupturePhotoith,
              ),
              SimpleDialogOption(
                child: Text(
                  'Select from gallery',
                  style: TextStyle(
                    color: Colors.green,
                  ),
                ),
                onPressed: pickPhotoWithCom,
              ),
              SimpleDialogOption(
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: Colors.green,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  cupturePhotoith() async {
    Navigator.pop(context);
    File ImageFile = await ImagePicker.pickImage(
        source: ImageSource.camera, maxHeight: 680.0, maxWidth: 970.0);
    setState(() {
      file = ImageFile;
    });
  }

  pickPhotoWithCom() async {
    Navigator.pop(context);
    File ImageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      file = ImageFile;
    });
  }

  displayUplaodHome() {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Colors.lightGreenAccent,
                  Colors.pink,
                ],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(1.0, 0.0),
                stops: [0, 1.0],
                tileMode: TileMode.clamp),
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_outlined,
            color: Colors.white,
          ),
          onPressed: clearFormInfo,
        ),
        title: Text(
          'New Product',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24.0),
        ),
        actions: [
          FlatButton(
            onPressed: upLoding ? null : () => upLodingImageToItim(),
            child: Text(
              'Add',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          upLoding ? linearProgress() : Text('a'),
          Container(
            height: 150.0,
            width: MediaQuery.of(context).size.width * 0.9,
            child: Center(
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: FileImage(file), fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 12.0)),
          Divider(),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 20,left: 10),
              height: 55,
              width: MediaQuery.of(context).size.width * 0.6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(),
              ),
              child: TextField(
                controller: teamController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'ارجاء كتابة التاريخ النتهاء كما موضح لك'
              ),
              ),
            ),
          ),
          //2
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                allContInFirebase(context,
                    Provider.of<AppData>(context, listen: false).listAppData);
              },
              child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(),
                  ),
                  child: Text(
                    "اختار البلد",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  )),
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                allCatoArInFirebase(
                    context,
                    Provider.of<AppData>(context, listen: false)
                        .listAppDataCatoAr);
              },
              child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(),
                  ),
                  child: Text(
                    "حداد الفئه",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  )),
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                allCatoEnInFirebase(
                    context,
                    Provider.of<AppData>(context, listen: false)
                        .listAppDataCatEn);
              },
              child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(),
                  ),
                  child: Text(
                    "select Cato...",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  )),
            ),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 10),
              height: 50,
              width: MediaQuery.of(context).size.width * 0.6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(),
              ),
              child: TextField(
                controller: _titleEnlTextEditingController,
                scrollPadding: EdgeInsets.all(3),
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: "Product Description"),
              ),
            ),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 10),
              height: 50,
              width: MediaQuery.of(context).size.width * 0.6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(),
              ),
              child: TextField(
                controller: _titleArTextEditingController,
                textAlign: TextAlign.end,
                scrollPadding: EdgeInsets.all(3),
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: "وصف النتج"),
              ),
            ),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 10),
              height: 50,
              width: MediaQuery.of(context).size.width * 0.6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(),
              ),
              child: TextField(
                controller: _codeTextEditingController,
                textAlign: TextAlign.center,
                scrollPadding: EdgeInsets.all(3),
                decoration:
                    InputDecoration(border: InputBorder.none, hintText: "Code"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  clearFormInfo() {
    setState(() {
      file = null;
      _titleArTextEditingController.clear();
      _codeTextEditingController.clear();
      _titleEnlTextEditingController.clear();
    });
  }

  upLodingImageToItim() async {
    setState(() {
      upLoding = true;
    });
    String imageDawalosUrl = await uploadeItmimImage(file);
    SavaItimInfo(imageDawalosUrl);
  }

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
    final itmeRef = Firestore.instance.collection('items');
    itmeRef.document(productId).setData({
      'titleAr': _titleArTextEditingController.text.trim(),
      "conter": 1,
      "id": productId,
      'titleEn': _titleEnlTextEditingController.text.trim(),
      'code': _codeTextEditingController.text.trim(),
      'publishedDate': DateTime.now(),
      'thumbnailUrl': url,
      "listCatoAr":
          Provider.of<MultipleNotifier>(context, listen: false).selectedItemsAr,
      "listCatoEn":
          Provider.of<MultipleNotifier>(context, listen: false).selectedItemsEn,
      "selectCaont":
          Provider.of<MultipleNotifier>(context, listen: false).selectedItems,
      'endE': teamController.text.trim().toString(),
      'startS': formattedDate.toString(),
    });
    setState(() {
      file = null;
      upLoding = false;
      productId = DateTime.now().microsecondsSinceEpoch.toString();
      _titleEnlTextEditingController.clear();
      _titleArTextEditingController.clear();
      _codeTextEditingController.clear();
    });
  }
}
