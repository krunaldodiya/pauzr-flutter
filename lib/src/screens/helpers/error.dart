import 'package:flutter/material.dart';

Future<bool> showErrorPopup(
  BuildContext context, {
  yesText: "OK",
  message: "Something bad happened.",
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
            },
          ),
        ],
      );
    },
  );
}
