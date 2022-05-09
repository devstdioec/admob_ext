import 'dart:io' show Platform;
import 'package:app_tracking_transparency/app_tracking_transparency.dart';

import 'test_unit_ids.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdmobService extends GetxService {

  late InterstitialAd _interstitialAd;
  late final AppOpenAd _appOpenAd;

  Future<AdmobService> init({String? adUnit}) async {
    try {
      if (Platform.isIOS) {
        try {
          await AppTrackingTransparency.requestTrackingAuthorization();
        } catch (e) {
          print('AppTrackingTransparency error');
        }
      }
      await MobileAds.instance.initialize();
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

  Future showInterstitial({String? adUnit}) async {
    try {
      await _interstitialAd.show();
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
