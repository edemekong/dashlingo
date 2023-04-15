import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/logs.dart';

class StorageService {
  StorageService._();

  static StorageService? _instance;

  static StorageService get instance {
    _instance ??= StorageService._();
    return _instance!;
  }

  late SharedPreferences _sharedPreferences;

  Future<void> initialisePreference() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<bool> getBoolean(String key) async {
    await initialisePreference();

    if (key.isEmpty) return false;
    return _sharedPreferences.getBool(key) ?? false;
  }

  Future<bool> removeStorageKey(String key) async {
    try {
      await initialisePreference();

      await _sharedPreferences.remove(key);
    } catch (e) {
      dashPrint(e);
    }
    return false;
  }

  Future<bool> setBoolean(String key, bool value) async {
    if (key.isEmpty) return false;
    try {
      await initialisePreference();

      return await _sharedPreferences.setBool(key, value);
    } catch (e) {
      dashPrint(e);
    }
    return false;
  }

  Future<bool> setInteger(String key, int value) async {
    try {
      await initialisePreference();

      await _sharedPreferences.setInt(key, value);
      return true;
    } catch (e) {
      dashPrint(e);
    }
    return false;
  }

  Future<int?> getInteger(String key) async {
    try {
      await initialisePreference();

      return _sharedPreferences.getInt(key);
    } catch (e) {
      dashPrint(e);
    }
    return null;
  }

  Future<bool> setString(String key, String value) async {
    try {
      await initialisePreference();

      await _sharedPreferences.setString(key, value);
      return true;
    } catch (e) {
      dashPrint(e);
    }
    return false;
  }

  Future<String?> getString(String key) async {
    try {
      await initialisePreference();

      return _sharedPreferences.getString(key);
    } catch (e) {
      dashPrint(e);
    }
    return null;
  }
}
