import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kDebugMode;

class TestUnitIds {
  static String get appOpenUnit {
    if (Platform.isAndroid) {
      if (kDebugMode) {
        return 'ca-app-pub-3940256099942544/3419835294';
      }
    }
    return 'ca-app-pub-3940256099942544/5662855259';
  }

  static String get bannerUnit {
    if (Platform.isAndroid) {
      if (kDebugMode) {
        return 'ca-app-pub-3940256099942544/6300978111';
      }
    }
    return 'ca-app-pub-3940256099942544/2934735716';
  }

  static String get interstitialUnit {
    if (Platform.isAndroid) {
      if (kDebugMode) {
        return 'ca-app-pub-3940256099942544/1033173712';
      }
    }
    return 'ca-app-pub-3940256099942544/4411468910';
  }

  static String get rewardedUnit {
    if (Platform.isAndroid) {
      if (kDebugMode) {
        return 'ca-app-pub-3940256099942544/5224354917';
      }
    }
    return 'ca-app-pub-3940256099942544/1712485313';
  }
}
