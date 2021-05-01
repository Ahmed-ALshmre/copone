import 'package:admin_copon/model/model.dart';
import 'package:admin_copon/upadet/homeScreenUp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UpItem extends StatefulWidget {
  @override
  _UpItemState createState() => _UpItemState();
}

class _UpItemState extends State<UpItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _drawProducts(),
    );
  }

  Widget _drawProducts() {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('items').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Center(
              child: CircularProgressIndicator(),
            );
          default:
            return ListView.builder(
              scrollDirection: Axis.vertical,
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  ItemModel model =
                      ItemModel.fromJson(snapshot.data.documents[index].data);
                  return Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Card(
                      child: Container(
                        height: 150,
                        decoration: BoxDecoration(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  height: 40,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                  ),
                                  child: Text(
                                    "${model.code}",
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Container(
                                  height: 30,
                                  width: 250,
                                  child: Text(
                                    "${model.titleEn}",
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                            Divider(),
                            Container(
                              alignment: Alignment.center,
                              height: 30,
                              child: Text(
                                "${model.title}",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                    child: Icon(Icons.delete),
                                    onTap: () {
                                      Firestore.instance
                                          .collection("items")
                                          .document(model.id)
                                          .delete();
                                      setState(() {});
                                    }),
                                IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (co) => UpdateHomeScreen(
                                                    code: model.code,
                                                    textAir: model.title,
                                                    id: model.id,
                                                    textEn: model.titleEn,
                                                  )));
                                    })
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
        }
      },
    );
  }
}
