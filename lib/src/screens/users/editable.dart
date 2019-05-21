import 'package:flutter/material.dart';
import 'package:pauzr/src/helpers/fonts.dart';

class EditableFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String errorText;
  final Function onChanged;
  final Color borderColor;
  final Color textColor;
  final Color labelColor;
  final int maxLength;
  final TextInputType keyboardType;

  EditableFormField({
    Key key,
    this.controller,
    this.labelText,
    this.errorText,
    this.onChanged,
    this.textColor,
    this.labelColor,
    this.borderColor,
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
        onChanged: (data) => onChanged(data),
        style: TextStyle(
          color: textColor ?? Colors.white,
          fontSize: 14.0,
          fontFamily: Fonts.titilliumWebRegular,
        ),
        keyboardType: this.keyboardType ?? TextInputType.text,
        decoration: InputDecoration(
          errorText: errorText,
          contentPadding: EdgeInsets.all(15.0),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: borderColor ?? Colors.white,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: borderColor ?? Colors.white,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: borderColor ?? Colors.white,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: borderColor ?? Colors.white,
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
            color: labelColor ?? Colors.white,
            fontSize: 14.0,
            fontFamily: Fonts.titilliumWebRegular,
          ),
        ),
      ),
    );
  }
}
