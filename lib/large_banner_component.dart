import 'package:admob_ext/admob_component.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class LargeComponent extends AdMobComponent {
  LargeComponent({Key? key, String? adUnitId}) : super(key: key, size: AdSize.largeBanner, adUnitId: adUnitId);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: banner.load(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Container(
              alignment: Alignment.center,
              child: AdWidget(ad: banner),
              width: banner.size.width.toDouble(),
              height: banner.size.height.toDouble(),
            );
          }
          return const SizedBox();
        });
  }
}
