import 'package:flutter/material.dart';

class TappableFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String errorText;

  TappableFormField({
    Key key,
    @required this.controller,
    @required this.labelText,
    @required this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
      child: TextField(
        enabled: false,
        controller: controller,
        style: TextStyle(
          color: Colors.white,
          fontSize: 14.0,
          fontFamily: 'TitilliumWeb-Regular',
        ),
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          errorText: errorText,
          contentPadding: EdgeInsets.all(15.0),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
            ),
          ),
          errorStyle: TextStyle(
            color: Colors.red,
          ),
          labelText: labelText,
          labelStyle: TextStyle(
            color: Colors.white,
            fontSize: 14.0,
            fontFamily: 'TitilliumWeb-Regular',
          ),
        ),
      ),
    );
  }
}
