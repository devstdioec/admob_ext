import 'package:admob_ext/admob_component.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class MediumComponent extends AdMobComponent {

  MediumComponent({Key? key, String? adUnitId}) : super(key: key, size: AdSize.mediumRectangle, adUnitId: adUnitId);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: banner.load(),
      builder: (BuildContext ctx, AsyncSnapshot snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Container(
            alignment: Alignment.center,
            child: AdWidget(ad: banner),
            width: banner.size.width.toDouble(),
            height: banner.size.height.toDouble(),
          );
        }
        return const SizedBox();
      },
    );
  }
}
