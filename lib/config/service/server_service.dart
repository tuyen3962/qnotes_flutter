import 'package:base_flutter_source/config/constant/app_config.dart';
import 'package:base_flutter_source/config/service/storage_service.dart';

class ServerService {
  final StorageService storageService;
  final AppConfig appConfig;

  ServerService({required this.storageService, required this.appConfig});

  init() async {}
}
