import 'package:base_flutter_source/config/service/app_service.dart';

class AppConfig {
  AppConfig({
    required this.supabaseUrl,
    required this.supabaseApiKey,
  });

  final String supabaseUrl;
  final String supabaseApiKey;
}

class AppwirteStorageConfig {
  static late final AppConfig _appConfig = locator.get();

  static String getImageLink(String bucketId, String fileId) {
    return '';
  }
}
