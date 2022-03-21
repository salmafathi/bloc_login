import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static  SharedPreferences sharedpreferences;
  static const KEY_USERNAME = 'username';
  static const KEY_PASSWORD = 'password';


  static init() async {
    sharedpreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> putDataInSharedPreference({
     dynamic value,
     String key,
  }) async {
    if(value is String) {
      return await sharedpreferences.setString(key, value);
    }
    if(value is int) {
      return await sharedpreferences.setInt(key, value);
    }
    if(value is bool) {
      return await sharedpreferences.setBool(key, value);
    } else {
      return await sharedpreferences.setDouble(key, value);
    }
  }


  static dynamic getDataFromSharedPreference({
     String key,
  }) {
    return sharedpreferences.get(key);
  }

  static Future<bool> clearDataFromSharedPreference({
     String key,
  }) async{
    return await sharedpreferences.remove(key);
  }

  static dynamic getUserNameFromSharedPreference() {
    return sharedpreferences.get(KEY_USERNAME)  ;
  }
  static dynamic getPasswordFromSharedPreference() {
    return sharedpreferences.get(KEY_PASSWORD)  ;
  }

  static Future<bool> removePasswordFromSharedPreference() {
    return sharedpreferences.remove(KEY_PASSWORD)  ;
  }
  static Future<bool> removeUserNameFromSharedPreference() {
    return sharedpreferences.remove(KEY_USERNAME)  ;
  }

  static Future<bool> putUserNameFromSharedPreference(String name) async {
    return await sharedpreferences.setString(KEY_USERNAME, name);
  }

  static Future<bool> putPasswordFromSharedPreference(String password) async{
    return await sharedpreferences.setString(KEY_PASSWORD, password);
  }
}