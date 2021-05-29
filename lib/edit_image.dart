import 'package:admin_copon/model/model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditIamgesAda extends StatefulWidget {
  @override
  _EditIamgesAdaState createState() => _EditIamgesAdaState();
}

class _EditIamgesAdaState extends State<EditIamgesAda> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            Expanded(child: _drawProducts()),
          ],
        ),
      ),
    );
  }

  Widget _drawProducts() {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('adaIamge').snapshots(),
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
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 200,
                      width: 300,
                      decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: NetworkImage(
                              model.thumbnailUrl,
                            ),
                            fit: BoxFit.contain),
                      ),
                      child: IconButton(
                        iconSize: 40,
                        color: Colors.white,
                        icon: Icon(
                          Icons.delete,
                        ),
                        onPressed: () {
                          Firestore.instance
                              .collection("adaIamge")
                              .document(model.uid)
                              .delete();
                          setState(() {});
                        },
                      ),
                    ),
                  );
                });
        }
      },
    );
  }
}
