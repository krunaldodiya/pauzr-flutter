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

createBannerAd() {
  return BannerAd(
    size: AdSize.banner,
    adUnitId: admobBannerAdUnitId,
    targetingInfo: getTargetingInfo(),
  );
}

createInterstitialAd() {
  return InterstitialAd(
    adUnitId: admobInterstitialAdUnitId,
    targetingInfo: getTargetingInfo(),
  );
}

createRewardedVideoAd(
  RewardedVideoAdEvent event, {
  String rewardType,
  int rewardAmount,
}) {
  if (event == RewardedVideoAdEvent.loaded) {
    RewardedVideoAd.instance
        .load(adUnitId: admobVideoAdUnitId, targetingInfo: getTargetingInfo())
        .then((status) => RewardedVideoAd.instance.show());
  }
}
