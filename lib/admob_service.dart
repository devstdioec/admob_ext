import 'package:admob_ext/admob_lifecycle.dart';
import 'package:flutter/material.dart';
import 'test_unit_ids.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdmobService extends GetxService {
  late final InterstitialAd _interstitialAd;
  late final RewardedAd _rewardedAd;
  late final AppOpenAd _appOpenAd;

  Future<AdmobService> init({String? interstitialUnit, String? rewardedUnit, String? openAppUnit}) async {
    try {
      await MobileAds.instance.initialize();
      if (openAppUnit != null) {
        await initializeAppOpen(adUnit: openAppUnit);
      }
      if (interstitialUnit != null) {
        initializeInterstitial(adUnit: interstitialUnit);
      }
      if (rewardedUnit != null) {
        initializeRewarded(adUnit: rewardedUnit);
      }
      return this;
    } catch (e) {
      return this;
    }
  }

  Future initializeInterstitial({String? adUnit}) async {
    try {
      await InterstitialAd.load(
        adUnitId: adUnit ?? TestUnitIds.interstitialUnit,
        request: const AdRequest(httpTimeoutMillis: 5000),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) => _interstitialAd = ad,
          onAdFailedToLoad: (LoadAdError error) => print('InterstitialAd failed to load'),
        ),
      );
    } catch (e) {
      print('InterstitialAd failed to load');
    }
  }

  Future initializeRewarded({String? adUnit}) async {
    try {
      await RewardedAd.load(
        adUnitId: adUnit ?? TestUnitIds.rewardedUnit,
        request: const AdRequest(httpTimeoutMillis: 5000),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            _rewardedAd = ad;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('RewardedAd failed to load: $error');
          },
        ),
      );
      _rewardedAd.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (RewardedAd ad) =>
            print('$ad onAdShowedFullScreenContent.'),
        onAdDismissedFullScreenContent: (RewardedAd ad) {
          print('$ad onAdDismissedFullScreenContent.');
          ad.dispose();
        },
        onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
          print('$ad onAdFailedToShowFullScreenContent: $error');
          ad.dispose();
        },
        onAdImpression: (RewardedAd ad) => print('$ad impression occurred.'),
      );
    } catch (e) {
      print('RewardedAd failed to load');
    }
  }

  Future initializeAppOpen({String? adUnit}) async {
    try {
      await AppOpenAd.load(
        adUnitId: adUnit ?? TestUnitIds.appOpenUnit,
        orientation: AppOpenAd.orientationPortrait,
        request: const AdRequest(),
        adLoadCallback: AppOpenAdLoadCallback(
          onAdLoaded: (ad) => _appOpenAd = ad,
          onAdFailedToLoad: (error) => print('AppOpenAd failed to load'),
        ),
      );
      WidgetsBinding.instance.addObserver(AppLifecycleReactor());
    } catch (e) {
      print('AppOpenAd error');
    }
  }

  Future showInterstitial() async {
    try {
      await _interstitialAd.show();
    } catch (e) {
      print('InterstitialAd failed to show');
    }
  }

  Future showRewarded(Function callback) async {
    try {
      await _rewardedAd.show(onUserEarnedReward: (AdWithoutView ad, RewardItem reward) => callback());
    } catch (e) {
      callback();
      print('InterstitialAd failed to show');
    }
  }

  Future showAppOpenAd() async {
    try {
      await _appOpenAd.show();
    } catch (e) {
      print('AppOpenAd failed to show');
    }
  }
}
