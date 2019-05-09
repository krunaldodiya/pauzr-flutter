import 'package:flutter/material.dart';
import 'package:pauzr/src/helpers/fonts.dart';

class EditableFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String errorText;
  final Function onChanged;
  final int maxLength;
  final TextInputType keyboardType;

  EditableFormField({
    Key key,
    @required this.controller,
    @required this.labelText,
    @required this.errorText,
    @required this.onChanged,
    this.maxLength,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
      child: TextField(
        maxLength: maxLength ?? null,
        controller: controller,
        onChanged: onChanged,
        style: TextStyle(
          color: Colors.white,
          fontSize: 14.0,
          fontFamily: Fonts.titilliumWebRegular,
        ),
        keyboardType: this.keyboardType ?? TextInputType.text,
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
            fontFamily: Fonts.titilliumWebRegular,
          ),
        ),
      ),
    );
  }
}
