import 'dart:io' show Platform;
import 'package:flutter_funding_choices/flutter_funding_choices.dart';
import 'package:get/get.dart';

class FundingChoicesService extends GetxService {

  Future<FundingChoicesService> init() async {
    try {
      ConsentInformation consentInfo = await FlutterFundingChoices.requestConsentInformation();
      if (Platform.isAndroid) {
        if (consentInfo.isConsentFormAvailable && consentInfo.consentStatus == ConsentStatus.REQUIRED_ANDROID) {
          await FlutterFundingChoices.showConsentForm();
        }
        return this;
      }
      if (consentInfo.isConsentFormAvailable && consentInfo.consentStatus == ConsentStatus.REQUIRED_IOS) {
        await FlutterFundingChoices.showConsentForm();
      }
      return this;
    } catch (e) {
      return this;
    }
  }

}