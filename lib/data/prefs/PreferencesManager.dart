import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class PreferencesManager {
  static const IS_LOGIN = "is_login";
  static const JWT = "AUTH_TOKEN";
  

  static SharedPreferences prefs;

  static Future<SharedPreferences> getInstance() {
    return SharedPreferences.getInstance();
  }

  static Future<bool> init() async {
    prefs = await getInstance();
    return Future.value(true);
  }

  static void savePref(String key, dynamic value) {
    if (value is bool) {
      prefs.setBool(key, value);
    } else if (value is int) {
      prefs.setInt(key, value);
    } else if (value is double) {
      prefs.setDouble(key, value);
    } else if (value is String) {
      prefs.setString(key, value);
    } else if (value is List<String>) {
      prefs.setStringList(key, value);
    } else {
      throw new Exception("Attempting to save non-primitive preference");
    }
  }

  static T getPref<T>(String key) {
    return prefs.get(key);
  }

  static T getPrefWithDefault<T>(String key, T defValue) {
    T returnValue = prefs.get(key);
    return returnValue == null ? defValue : returnValue;
  }

  static void clean(){
    prefs.clear();
    prefs.commit();
  }
}
