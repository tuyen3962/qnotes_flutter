import 'dart:io';

import 'package:qnotes_flutter/config/constant/app_config.dart';

class AdmobHelper {
  final AppConfig appConfig;

  AdmobHelper({required this.appConfig});

  String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return appConfig.androidBannerId;
    } else if (Platform.isIOS) {
      return appConfig.iosBannerId;
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return appConfig.androidInterstitialAdId;
    } else if (Platform.isIOS) {
      return appConfig.iosInterstitialAdId;
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return appConfig.androidRewatdAdId;
    } else if (Platform.isIOS) {
      return appConfig.iosRewatdAdId;
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}
