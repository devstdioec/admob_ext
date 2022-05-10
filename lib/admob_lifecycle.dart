import 'package:admob_ext/admob_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppLifecycleReactor extends WidgetsBindingObserver {

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      Get.find<AdmobService>().showAppOpenAd();
    }
  }
}
