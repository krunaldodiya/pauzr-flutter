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
    testDevices: <String>[],
  );
}

createInterstitialAd() {
  return InterstitialAd(
    adUnitId: admobInterstitialAdUnitId,
    targetingInfo: getTargetingInfo(),
  );
}
