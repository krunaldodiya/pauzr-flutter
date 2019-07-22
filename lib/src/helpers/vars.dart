import 'package:flutter/foundation.dart' show kReleaseMode;

String appName = "PauzR";
String appId = "https://play.google.com/store/apps/details?id=com.pauzr.org";
String shareText =
    "PauzR app is helping me put down my phone and increase my productivity. I use it everyday. You might like it too! Take the PauzR challenge: $appId";

String webUrl = "https://www.pauzr.com";
String emailAddress = "support@pauzr.com";
String admobAppId = "ca-app-pub-8693156356265683~5180433123";
String admobUnitId = "ca-app-pub-8693156356265683/1297916487";

// String baseUrl =
//     kReleaseMode ? "https://api.pauzr.com" : "http://192.168.1.103:8000";

String baseUrl =
    kReleaseMode ? "https://api.pauzr.com" : "https://api.pauzr.com";
