import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdmobService {
  static InterstitialAd? _interstitialAd;
  static RewardedAd? _rewardedAd;
  static AppOpenAd? _appOpenAd;

  static Future<void> initialize() async {
    await MobileAds.instance.initialize();
    loadInterstitialAd();
    loadRewardedAd();
    loadAppOpenAd();
  }

  /// Get Ad Unit IDs (Replace with your own Ad Unit IDs)
  static String get bannerAdUnitId =>
      // 'ca-app-pub-3940256099942544/9214589741'; // testing id
      Platform.isAndroid ? 'ca-app-pub-2794202314500041/4458924688' : '';

  static String get interstitialAdUnitId =>
      // 'ca-app-pub-3940256099942544/1033173712'; // testing id
      Platform.isAndroid ? 'ca-app-pub-2794202314500041/7109138755' : '';

  static String get rewardedAdUnitId =>
      // 'ca-app-pub-3940256099942544/5224354917';
      Platform.isAndroid ? 'ca-app-pub-2794202314500041/7021508847' : '';

  static String get appOpenAdUnitId =>
      //  'ca-app-pub-3940256099942544/9257395921';
      Platform.isAndroid ? 'ca-app-pub-2794202314500041/8206598008' : '';

  // ✅ **Banner Ad (Created Per Screen)**
  static BannerAd createBannerAd() {
    return BannerAd(
      size: AdSize.banner,
      adUnitId: bannerAdUnitId,
      listener: BannerAdListener(
        onAdFailedToLoad: (ad, error) {
          // print('Banner Ad Failed: $error');
          ad.dispose();
        },
      ),
      request: const AdRequest(),
    );
  }

  // ✅ **Load Interstitial Ad**
  static void loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
        },
        onAdFailedToLoad: (error) {
          _interstitialAd = null;
        },
      ),
    );
  }

  // ✅ **Show Interstitial Ad**
  static void showInterstitialAd() {
    if (_interstitialAd != null) {
      _interstitialAd!.show();
      _interstitialAd = null; // Dispose after showing
      loadInterstitialAd(); // Reload for next use
    }
  }

  // ✅ **Load Rewarded Ad**
  static void loadRewardedAd() {
    RewardedAd.load(
      adUnitId: rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAd = ad;
        },
        onAdFailedToLoad: (error) {
          _rewardedAd = null;
        },
      ),
    );
  }

  // ✅ **Show Rewarded Ad**
  static void showRewardedAd() {
    if (_rewardedAd != null) {
      _rewardedAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
          // print('User Earned Reward: ${reward.amount} ${reward.type}');
        },
      );
      _rewardedAd = null;
      loadRewardedAd(); // Reload for next use
    }
  }

  // ✅ **Load App Open Ad (Fixed Version)**
  static void loadAppOpenAd() {
    AppOpenAd.load(
      adUnitId: appOpenAdUnitId,
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          _appOpenAd = ad;
        },
        onAdFailedToLoad: (error) {
          _appOpenAd = null;
        },
      ),
    );
  }

  // ✅ **Show App Open Ad**
  static void showAppOpenAd() {
    if (_appOpenAd != null) {
      _appOpenAd!.show();
      _appOpenAd = null;
      loadAppOpenAd(); // Reload for next use
    }
  }
}
