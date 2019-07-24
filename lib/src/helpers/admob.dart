import 'package:firebase_admob/firebase_admob.dart';
import 'package:pauzr/src/helpers/vars.dart';

MobileAdTargetingInfo getTargetingInfo() {
  return MobileAdTargetingInfo(
    keywords: <String>[
      "Insurance",
      "Loans",
      "Mortgage",
      "Attorney",
      "Credit",
      "Lawyer",
      "Donate",
      "Degree",
      "Hosting",
      "Claim",
      "Conference Call",
      "Trading",
      "Software",
      "Recovery",
      "Transfer",
      "Gas/Electicity",
      "Classes",
      "Rehab",
      "Treatment",
      "Cord Blood",
    ],
    testDevices: <String>['FBD5A4FE639B651322908CE1EC03A61C'],
  );
}

createInterstitialAd() {
  return InterstitialAd(
    adUnitId: admobUnitId,
    targetingInfo: getTargetingInfo(),
  );
}
