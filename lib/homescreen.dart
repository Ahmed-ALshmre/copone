import 'package:admin_copon/ctogre/comupuneImageupdet.dart';
import 'package:admin_copon/toolsCatogreAndContry/addCatogry.dart';
import 'package:admin_copon/upaute/iteam.dart';
import 'package:admin_copon/webNotf/web_not.dart';
import 'package:flutter/material.dart';
import 'ctogre/cato.dart';
import 'ctogre/dielog.dart';
import 'ctogre/imageupdate.dart';
import 'ctogre/uploadvompne.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  List<String>namePush=
  ["تحديث العلامات التجارية",
    "ارسال اشعارات",
    "تحديث الاعلانات",
    "تحديث معلومات الديالوك",
    "تعديل كوبون",
    "اضافة فئه جديده",
    "اضافة كوبون",
    "اضافة بلد",
  ];
  List<Widget> listWidget=[
    UpImageLogo(),
    WebViewExample(),
    UpImageFirst(),
    CustomDialog(),
    UpItem(),
    Cato(),
    UploadPage(),
    AddCountry(),
  ];
  List<Color>colorList=[
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Admin"),
        backgroundColor: Color(0xff221D71),
      ),
      body: GridView.count(crossAxisCount: 2,
    padding: EdgeInsets.all(7),
    crossAxisSpacing: 4,
    children: List.generate(namePush.length, (index) {
    return InkWell(
      onTap:(){ Navigator.push(
                   context, MaterialPageRoute(builder: (_) =>listWidget[index],
      ));},
      child: Card(
        elevation: 10,
        child: Container(
          decoration: BoxDecoration(
            borderRadius:BorderRadius.circular(6),
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
//SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(
//               height: 20,
//             ),
//             ListTile(
//               onTap: () {
//                 Navigator.push(
//                     context, MaterialPageRoute(builder: (_) => UpImageLogo()));
//               },
//               title: Center(
//                 child: Text("تحديث العلامات التجارية"),
//               ),
//             ),
//             Divider(),
//             ListTile(
//               onTap: () {
//                 Navigator.push(
//                     context, MaterialPageRoute(builder: (_) => UpImageLogo()));
//               },
//               title: Center(
//                 child: Text("ارسال اشعارات"),
//               ),
//             ),
//             Divider(),
//             ListTile(
//               onTap: () {
//                 Navigator.push(
//                     context, MaterialPageRoute(builder: (_) => UpImageFirst()));
//               },
//               title: Center(
//                 child: Text("تحديث الاعلانات"),
//               ),
//             ),
//             Divider(),
//             ListTile(
//               onTap: () {
//                 Navigator.push(
//                     context, MaterialPageRoute(builder: (_) => CustomDialog()));
//               },
//               title: Center(
//                 child: Text("تحديث معلومات الديالوك"),
//               ),
//             ),
//             Divider(),
//             ListTile(
//               onTap: () {
//                 Navigator.push(
//                     context, MaterialPageRoute(builder: (_) => UpItem()));
//               },
//               title: Center(
//                 child: Text("تعديل كوبون"),
//               ),
//             ),
//             Divider(),
//             Divider(),
//             ListTile(
//               onTap: () {
//                 Navigator.push(
//                     context, MaterialPageRoute(builder: (_) => Cato()));
//               },
//               title: Center(
//                 child: Text("اضافة فئه جديده"),
//               ),
//             ),
//             Divider(),
//             ListTile(
//               onTap: () {
//                 Navigator.push(
//                     context, MaterialPageRoute(builder: (_) => UploadPage()));
//               },
//               title: Center(
//                 child: Text("اضافة كوبون"),
//               ),
//             ),
//             ListTile(
//               onTap: () {
//                 Navigator.push(
//                     context, MaterialPageRoute(builder: (_) => AddCountry()));
//               },
//               title: Center(
//                 child: Text("اضافة بلد"),
//               ),
//             ),
//           ],
//         ),
//       ),