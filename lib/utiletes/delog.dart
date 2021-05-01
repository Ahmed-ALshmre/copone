import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../classMuilteN.dart';


allCatoEnInFirebase(BuildContext context,List list) => showDialog(
  context: context,
  builder: (context) {
    final _multipleNotifier = Provider.of<MultipleNotifier>(context);
    return AlertDialog(
      title: Text("الرجاء تحديد البلد"),
      content: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: list
                .map((e) => CheckboxListTile(
              title: Text(e),
              onChanged: (value) {
                value
                    ? _multipleNotifier.addItemEn(e)
                    : _multipleNotifier.removeItemEn(e);
                print(Provider.of<MultipleNotifier>(context,
                    listen: false)
                    .selectedItemsEn);
              },
              value: _multipleNotifier.isHaveItemEn(e),
            ))
                .toList(),
          ),
        ),
      ),
      actions: [
        FlatButton(
          child: Text("Yes"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  },
);

allCatoArInFirebase(BuildContext context,List list) => showDialog(
  context: context,
  builder: (context) {
    final _multipleNotifier = Provider.of<MultipleNotifier>(context);
    return AlertDialog(
      title: Text("الرجاء تحديد البلد"),
      content: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: list
                .map((e) => CheckboxListTile(
              title: Text(e),
              onChanged: (value) {
                value
                    ? _multipleNotifier.addItemAr(e)
                    : _multipleNotifier.removeItemAr(e);
                print(Provider.of<MultipleNotifier>(context,
                    listen: false)
                    .selectedItemsAr);
              },
              value: _multipleNotifier.isHaveItemAr(e),
            ))
                .toList(),
          ),
        ),
      ),
      actions: [
        FlatButton(
          child: Text("Yes"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  },
);

allContInFirebase(BuildContext context,List list) => showDialog(
  context: context,
  builder: (context) {
    final _multipleNotifier = Provider.of<MultipleNotifier>(context);
    return AlertDialog(
      title: Text("الرجاء تحديد البلد"),
      content: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: list
                .map((e) => CheckboxListTile(
              title: Text(e),
              onChanged: (value) {
                value
                    ? _multipleNotifier.addItem(e)
                    : _multipleNotifier.removeItem(e);
                print(Provider.of<MultipleNotifier>(context,
                    listen: false)
                    .selectedItems);
              },
              value: _multipleNotifier.isHaveItem(e),
            ))
                .toList(),
          ),
        ),
      ),
      actions: [
        FlatButton(
          child: Text("Yes"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  },
);