import 'package:flutter/material.dart';

Future<bool> showConfirmationPopup(
  BuildContext context, {
  yesText: "Yes",
  noText: "No",
  message: "Are you sure ?",
  onPressYes,
}) {
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
              noText,
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
              yesText,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              onPressYes();
            },
          ),
        ],
      );
    },
  );
}
