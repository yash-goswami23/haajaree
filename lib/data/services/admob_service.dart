import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdmobService {
  static String get bannerAdUnitId =>
      //ca-app-pub-3940256099942544/6300978111
      //ca-app-pub-2794202314500041~3165148609
      Platform.isAndroid ? 'ca-app-pub-3940256099942544/6300978111' : '';
  static initialize() {}

  static InterstitialAd? interstitialAd;
  static BannerAd createBannerAd() {
    BannerAd ad = BannerAd(
        size: AdSize.banner,
        adUnitId: bannerAdUnitId,
        listener: BannerAdListener(
          onAdFailedToLoad: (ad, error) {
            ad.dispose;
          },
        ),
        request: const AdRequest());
    return ad;
  }

  static void loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/1033173712',
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          interstitialAd = ad;
        },
        onAdFailedToLoad: (error) {},
      ),
    );
  }

  static RewardedAd? rewardedAd;

  static void loadRewardedAd() {
    RewardedAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/5224354917',
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          rewardedAd = ad;
        },
        onAdFailedToLoad: (error) {},
      ),
    );
  }

  static void showRewardedAd() {
    if (rewardedAd != null) {
      rewardedAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {},
      );
      rewardedAd = null; // Dispose after showing
    } else {}
  }

  static void showInterstitialAd() {
    if (interstitialAd != null) {
      interstitialAd!.show();
      interstitialAd = null; // Dispose after showing
    } else {}
  }
}
