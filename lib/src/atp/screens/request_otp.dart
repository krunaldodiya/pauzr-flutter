import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class RequestOtp {
  Color backgroundColor;

  RequestOtp({
    @required this.backgroundColor,
  });

  factory RequestOtp.initial() {
    return RequestOtp(
      backgroundColor: Colors.black87,
    );
  }
}
