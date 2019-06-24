import 'package:flutter/material.dart';
import 'package:pauzr/src/helpers/fonts.dart';

class NoNetwork extends StatefulWidget {
  @override
  _NoNetwork createState() => _NoNetwork();
}

class _NoNetwork extends State<NoNetwork> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Text(
            "No Internet",
            style: TextStyle(
              color: Colors.white,
              fontSize: 36.0,
              fontFamily: Fonts.titilliumWebRegular,
            ),
          ),
        ),
      ),
    );
  }
}
