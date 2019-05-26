import 'package:flutter/material.dart';

Future<bool> showConfirmationPopup(BuildContext context, message, onPressYes) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          message,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(
              "No",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          RaisedButton(
            color: Colors.red,
            child: Text(
              "Yes",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: () {
              onPressYes();
              Navigator.popUntil(context, (route) => route.isFirst);
            },
          ),
        ],
      );
    },
  );
}
