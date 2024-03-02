//handle account data in here

import 'package:qnotes_flutter/config/service/server_service.dart';
import 'package:qnotes_flutter/config/service/storage_service.dart';

class AccountService {
  final StorageService storageService;
  final ServerService serverService;

  AccountService({
    required this.storageService,
    required this.serverService,
  });
}
