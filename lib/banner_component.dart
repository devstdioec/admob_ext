import 'package:admob_ext/admob_component.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerComponent extends AdMobComponent {

  BannerComponent({Key? key, String? adUnitId}) : super(key: key, size: AdSize.fullBanner, adUnitId: adUnitId);

  @override
  Widget build(BuildContext context) {
    try {
      banner.load();
      if (kDebugMode) {
        return const SizedBox();
      }
      return Container(
        alignment: Alignment.center,
        child: AdWidget(ad: banner),
        width: banner.size.width.toDouble(),
        height: banner.size.height.toDouble(),
      );
    } catch (e) {
      return const SizedBox();
    }
  }
}
