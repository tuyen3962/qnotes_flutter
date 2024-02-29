//handle account data in here

import 'package:base_flutter_source/config/service/server_service.dart';
import 'package:base_flutter_source/config/service/storage_service.dart';

class AccountService {
  final StorageService storageService;
  final ServerService serverService;

  AccountService({
    required this.storageService,
    required this.serverService,
  });
}
