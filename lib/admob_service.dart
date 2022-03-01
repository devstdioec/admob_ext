import 'dart:io' show Platform;
import 'package:app_tracking_transparency/app_tracking_transparency.dart';

import 'test_unit_ids.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdmobService extends GetxService {

  late final InterstitialAd interstitialAd;

  Future<AdmobService> init({String? adUnit}) async {
    try {
      if (Platform.isIOS) {
        await AppTrackingTransparency.requestTrackingAuthorization();
      }
      await MobileAds.instance.initialize();
      InterstitialAd.load(
        adUnitId: adUnit ?? TestUnitIds.interstitialUnit,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) => interstitialAd = ad,
          onAdFailedToLoad: (LoadAdError error) => print('InterstitialAd failed to load'),
        ),
      );
      return this;
    } catch (e) {
      return this;
    }
  }

  Future show() async {
    try {
      await interstitialAd.show();
    } catch (e) {
      print('InterstitialAd failed to show');
    }
  }
}
