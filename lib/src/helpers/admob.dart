import 'package:firebase_admob/firebase_admob.dart';
import 'package:pauzr/src/helpers/vars.dart';

MobileAdTargetingInfo getTargetingInfo(List<String> keywords) {
  return MobileAdTargetingInfo(
    keywords: keywords,
    testDevices: <String>[],
  );
}

createBannerAd(List<String> keywords) {
  return BannerAd(
    size: AdSize.banner,
    adUnitId: admobBannerAdUnitId,
    targetingInfo: getTargetingInfo(keywords),
  );
}

createInterstitialAd(List<String> keywords) {
  return InterstitialAd(
    adUnitId: admobInterstitialAdUnitId,
    targetingInfo: getTargetingInfo(keywords),
  );
}

createRewardedVideoAd(
  RewardedVideoAdEvent event, {
  String rewardType,
  int rewardAmount,
  List<String> keywords,
}) {
  if (event == RewardedVideoAdEvent.loaded) {
    RewardedVideoAd.instance
        .load(
          adUnitId: admobVideoAdUnitId,
          targetingInfo: getTargetingInfo(keywords),
        )
        .then((status) => RewardedVideoAd.instance.show());
  }
}
