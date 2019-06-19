import 'package:flutter/foundation.dart' show kReleaseMode;

String appName = "PauzR";
String appId = "https://play.google.com/store/apps/details?id=com.pauzr.org";

String baseUrl =
    kReleaseMode ? "https://api.pauzr.com" : "http://192.168.2.200:8000";

// String baseUrl =
//     kReleaseMode ? "https://api.pauzr.com" : "https://api.pauzr.com";
