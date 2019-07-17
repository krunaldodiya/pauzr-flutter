import 'package:flutter/material.dart';
import 'package:pauzr/src/helpers/fonts.dart';

class NotificationsScreen extends StatefulWidget {
  final Map message;

  NotificationsScreen({Key key, this.message}) : super(key: key);

  @override
  _NotificationsScreen createState() => _NotificationsScreen();
}

class _NotificationsScreen extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    final title = widget.message['data']['title'];
    final body = widget.message['data']['body'];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 10.0, left: 10.0),
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24.0,
                  fontFamily: Fonts.titilliumWebSemiBold,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10.0, left: 10.0),
              child: Text(
                body,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontFamily: Fonts.titilliumWebRegular,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
