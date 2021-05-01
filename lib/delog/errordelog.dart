import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorAlertDialog extends StatelessWidget
{
  final String message;
  const ErrorAlertDialog({Key key, this.message}) : super(key: key);


  @override
  Widget build(BuildContext context)
  {
    return AlertDialog(
      elevation: 1000,
      key: key,
      content: SizedBox(
        height: 200,
        width: double.infinity,
        child: Column(
          children: [
            Text(message),
            SizedBox(height: 20,),
            Image.asset('images/welcome.png')
          ],
        ),
      ),
      actions: <Widget>[
        RaisedButton(onPressed: ()
        {
          Navigator.pop(context);
        },
          color: Colors.red,
          child: Center(
            child: Text("OK"),
          ),
        )
      ],
    );
  }
}
