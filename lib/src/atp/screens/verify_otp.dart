import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class VerifyOtp {
  var backgroundColor;

  VerifyOtp({
    @required this.backgroundColor,
  });

  factory VerifyOtp.initial() {
    return VerifyOtp(
      backgroundColor: Colors.black87,
    );
  }
}
