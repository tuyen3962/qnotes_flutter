import 'package:qnotes_flutter/config/service/app_service.dart';

class AppConfig {
  AppConfig({
    required this.supabaseUrl,
    required this.supabaseApiKey,
    this.androidBannerId = '',
    this.iosBannerId = '',
    this.androidInterstitialAdId = '',
    this.iosInterstitialAdId = '',
    this.androidRewatdAdId = '',
    this.iosRewatdAdId = '',
  });

  final String supabaseUrl;
  final String supabaseApiKey;
  final String androidBannerId;
  final String iosBannerId;
  final String androidInterstitialAdId;
  final String iosInterstitialAdId;
  final String androidRewatdAdId;
  final String iosRewatdAdId;
}

class AppwirteStorageConfig {
  static late final AppConfig _appConfig = locator.get();

  static String getImageLink(String bucketId, String fileId) {
    return '';
  }
}
