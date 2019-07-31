import 'package:firebase_admob/firebase_admob.dart';
import 'package:pauzr/src/helpers/vars.dart';
import 'package:pauzr/src/providers/user.dart';

MobileAdTargetingInfo getTargetingInfo(List<String> keywords) {
  return MobileAdTargetingInfo(
    keywords: keywords,
    testDevices: <String>[],
  );
}

createBannerAd(UserBloc userBloc) {
  return BannerAd(
    size: AdSize.banner,
    adUnitId: admobBannerAdUnitId,
    targetingInfo: getTargetingInfo(userBloc.adsKeywords),
    listener: (MobileAdEvent event) {
      userBloc.setAdImpression('Banner');
    },
  );
}

createInterstitialAd(UserBloc userBloc) {
  return InterstitialAd(
    adUnitId: admobInterstitialAdUnitId,
    targetingInfo: getTargetingInfo(userBloc.adsKeywords),
    listener: (MobileAdEvent event) {
      userBloc.setAdImpression('Interstitial');
    },
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
