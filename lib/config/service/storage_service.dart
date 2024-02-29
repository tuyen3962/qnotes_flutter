import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:base_flutter_source/config/constant/storage_key.dart';

class StorageService {
  late final FlutterSecureStorage _secureStorage;
  late final SharedPreferences _preferences;

  StorageService();

  Future<void> initService() async {
    _secureStorage = const FlutterSecureStorage();
    _preferences = await SharedPreferences.getInstance();
  }

  Future saveUid(String userId) async {
    return _secureStorage.write(key: StorageKey.USER_UID, value: userId);
  }

  Future saveAccountType(String type) async {
    return _preferences.setString(StorageKey.ACCOUNT_TYPE, type);
  }

  Future saveSessionId(String id) =>
      _preferences.setString(StorageKey.SESSION_ID, id);

  Future<String> getSessionId() async =>
      await _secureStorage.read(key: StorageKey.SESSION_ID) ?? '';

  Future clear() async {
    await Future.wait([_secureStorage.deleteAll(), _preferences.clear()]);
  }
}
