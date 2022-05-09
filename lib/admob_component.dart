import 'package:admob_ext/test_unit_ids.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobComponent extends StatelessWidget {
  late final BannerAd banner;

  AdMobComponent({Key? key, AdSize? size, String? adUnitId}) : super(key: key) {
    banner = BannerAd(
      adUnitId: adUnitId ?? TestUnitIds.bannerUnit,
      size: size ?? AdSize.fullBanner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdFailedToLoad: (ad, loadError) => ad.dispose(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}
