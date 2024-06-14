import 'package:shared_preferences/shared_preferences.dart';

class SharedModel {
  late SharedPreferences prefs;

  // static String ipKey() => "IP_Key";
  static String accessKey() => "Access";
  static String refresh() => "Refresh";
  static String tokenDecoder() => "TokenDecoder";
  // const SharedModel({required this.prefs});

  Future<bool> setItem(String key, String value) async {
    prefs = await SharedPreferences.getInstance();
    return await prefs.setString(key, value);
  }

  Future<String?> getItem(String key) async {
    prefs = await SharedPreferences.getInstance();
    final res = prefs.getString(key);
    return res;
  }

  Future<bool> removeItem(String key) async {
    prefs = await SharedPreferences.getInstance();
    final res = await prefs.remove(key);
    return res;
  }

  Future<bool> clearItems() async {
    prefs = await SharedPreferences.getInstance();
    final res = await prefs.clear();
    return res;
  }

  Future<bool> saveJwt({
    required String access,
    required String refresh,
  }) async {
    final res_1 = await setItem(SharedModel.accessKey(), access);
    final res_2 = await setItem(SharedModel.refresh(), refresh);
    return res_1 && res_2;
  }

  static Future<bool> setKeyValue(String key, String value) async {
    final sharedModel = SharedModel();
    if (key != SharedModel.accessKey() || key != SharedModel.refresh()) {
      return false;
    }
    final currentkey = await sharedModel.getItem(key);
    if (currentkey != null && currentkey == key) {
      return true;
    } else if (currentkey != null && currentkey != key) {
      await sharedModel.removeItem(key);
      final res = await sharedModel.setItem(key, value);
      return res;
    } else {
      final res = await sharedModel.setItem(key, value);
      return res;
    }
  }

  static Future<String?> getKeyValue(String key) async {
    final sharedModel = SharedModel();
    if (key != SharedModel.accessKey() || key != SharedModel.refresh()) {
      return null;
    }
    final value = await sharedModel.getItem(key);
    return value;
  }
}
