import 'package:flutter/material.dart';
import 'package:pauzr/src/helpers/fonts.dart';

class NotificationsScreen extends StatefulWidget {
  final message;

  NotificationsScreen({Key key, @required this.message}) : super(key: key);

  @override
  _NotificationsScreen createState() => _NotificationsScreen();
}

class _NotificationsScreen extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Notifications",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22.0,
            fontFamily: Fonts.titilliumWebRegular,
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Text(
            widget.message,
            style: TextStyle(
              color: Colors.white,
              fontSize: 22.0,
              fontFamily: Fonts.titilliumWebRegular,
            ),
          ),
        ),
      ),
    );
  }
}
