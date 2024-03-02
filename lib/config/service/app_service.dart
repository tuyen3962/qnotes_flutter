import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:qnotes_flutter/config/constant/admob_helper.dart';
import 'package:qnotes_flutter/config/constant/app_config.dart';
import 'package:qnotes_flutter/config/repository/account/account_repository.dart';
import 'package:qnotes_flutter/config/repository/account/iaccount_repository.dart';
import 'package:qnotes_flutter/config/repository/upload/iupload_repository.dart';
import 'package:qnotes_flutter/config/service/account_service.dart';
import 'package:qnotes_flutter/config/service/admob_service.dart';
import 'package:qnotes_flutter/config/service/server_service.dart';
import 'package:qnotes_flutter/config/service/storage_service.dart';

final locator = GetIt.instance;

class AppService {
  /// init your service here for global using
  static Future<void> initAppService() async {
    await dotenv.load(fileName: 'assets/.env');
    final appConfig = AppConfig(
      supabaseApiKey: '',
      supabaseUrl: '',
      androidBannerId: dotenv.get('ANDROID_BANNER_AD_ID'),
      iosBannerId: dotenv.get('IOS_BANNER_AD_ID'),
      androidInterstitialAdId: dotenv.get('ANDROID_INTERSTITIAL_AD_ID'),
      iosInterstitialAdId: dotenv.get('IOS_INTERSTITIAL_AD_ID'),
      androidRewatdAdId: dotenv.get('ANDROID_REWARD_AD_ID'),
      iosRewatdAdId: dotenv.get('IOS_REWARD_AD_ID'),
    );
    locator.registerSingleton<AppConfig>(appConfig);

    final storage = StorageService();
    await storage.initService();
    locator.registerSingleton<StorageService>(storage);

    locator.registerSingleton<AdmobService>(
        AdmobService(admobHelper: AdmobHelper(appConfig: locator.get())));

    final server =
        ServerService(storageService: locator.get(), appConfig: locator.get());
    await server.init();

    locator.registerSingleton<ServerService>(server);

    locator.registerSingleton<AccountService>(AccountService(
      storageService: locator.get(),
      serverService: locator.get(),
    ));
  }
}
