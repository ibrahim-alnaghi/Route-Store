import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  CacheHelper._();
  static late SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> saveData(
      {required String key, required dynamic value}) async {
    if (value is String) {
      return await sharedPreferences.setString(key, value);
    } else if (value is int) {
      return await sharedPreferences.setInt(key, value);
    } else if (value is double) {
      return await sharedPreferences.setDouble(key, value);
    } else if (value is Map<String, dynamic>) {
      String jsonString = json.encode(value);
      return await sharedPreferences.setString(key, jsonString);
    } else {
      return await sharedPreferences.setBool(key, value);
    }
  }

  static dynamic getData(String key) {
    return sharedPreferences.get(key);
  }

  static Map<String, dynamic>? getMapData(String key) {
    String? jsonString = sharedPreferences.getString(key);
    return jsonString != null ? json.decode(jsonString) : null;
  }

  static Future<bool> removeData(String key) async {
    return await sharedPreferences.remove(key);
  }

  static Future<bool> clearAllData() async {
    return await sharedPreferences.clear();
  }
}
