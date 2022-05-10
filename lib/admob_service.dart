import 'package:admob_ext/admob_lifecycle.dart';
import 'package:flutter/material.dart';
import 'test_unit_ids.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdmobService extends GetxService {
  late final InterstitialAd _interstitialAd;
  late final RewardedAd _rewardedAd;
  late final AppOpenAd _appOpenAd;

  Future<AdmobService> init({String? interstitialUnit, String? rewardedUnit, String? openAppUnit, bool showAdsOnResume = false}) async {
    try {
      await MobileAds.instance.initialize();
      await initializeAppOpen(adUnit: openAppUnit);
      if (showAdsOnResume) {
        WidgetsBinding.instance!.addObserver(AppLifecycleReactor());
      }
      initializeInterstitial(adUnit: interstitialUnit);
      return this;
    } catch (e) {
      return this;
    }
  }

  Future initializeInterstitial({String? adUnit}) async {
    try {
      InterstitialAd.load(
        adUnitId: adUnit ?? TestUnitIds.interstitialUnit,
        request: const AdRequest(),
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
      RewardedAd.load(
        adUnitId: adUnit ?? TestUnitIds.rewardedUnit,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            _rewardedAd = ad;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('RewardedAd failed to load: $error');
          },
        ),
      );
    } catch (e) {
      print('RewardedAd failed to load');
    }
  }

  Future initializeAppOpen({String? adUnit}) async {
    try {
      AppOpenAd.load(
        adUnitId: adUnit ?? TestUnitIds.appOpenUnit,
        orientation: AppOpenAd.orientationPortrait,
        request: const AdRequest(),
        adLoadCallback: AppOpenAdLoadCallback(
          onAdLoaded: (ad) => _appOpenAd = ad,
          onAdFailedToLoad: (error) => print('AppOpenAd failed to load'),
        ),
      );
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
      await _rewardedAd.show(onUserEarnedReward: (AdWithoutView ad, RewardItem reward) => callback);
    } catch (e) {
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
