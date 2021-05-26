import 'package:admin_copon/ctogre/comupuneImageupdet.dart';
import 'package:admin_copon/toolsCatogreAndContry/addCatogry.dart';
import 'package:admin_copon/upaute/iteam.dart';
import 'package:admin_copon/webNotf/web_not.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'ctogre/cato.dart';
import 'ctogre/dielog.dart';
import 'ctogre/imageupdate.dart';
import 'ctogre/uploadvompne.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> namePush = [
    "لا شي",
    "ارسال اشعارات",
    "تحديث الاعلانات",
    "اضافة العلامات التجاريه",
    "تحديث الكوبون",
    "اضافة فئه جديده",
    "اضافة كوبون",
    "اضافة بلد",
  ];
  String formattedDate = "";
  List<Widget> listWidget = [
  WebViewExample(),
    WebViewExample(),
    UpImageFirst(),
    CustomDialog(),
    UpItem(),
    Cato(),
    UploadPage(),
    AddCountry(),
  ];
  List<Color> colorList = [
    Color(0xff221D71),
    Color(0xffFBFBFB),
    Color(0xffFBFBFB),
    Color(0xff221D71),
    Color(0xff221D71),
    Color(0xffFBFBFB),
    Color(0xffFBFBFB),
    Color(0xff221D71),
  ];
  @override
  Widget build(BuildContext context) {
    var now = new DateTime.now();
    var formatter = new DateFormat("dd-MM-yyyy h:mma");
    formattedDate = formatter.format(now);
    print("1");
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Admin"),
        backgroundColor: Color(0xff221D71),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(7),
        crossAxisSpacing: 4,
        children: List.generate(namePush.length, (index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => listWidget[index],
                  ));
            },
            child: Card(
              elevation: 10,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: colorList[index],
                ),
                child: Center(
                  child: Text(namePush[index]),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
