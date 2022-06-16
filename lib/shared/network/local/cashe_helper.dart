
import 'package:shared_preferences/shared_preferences.dart';
class CasheHelper
{
  static late SharedPreferences sharedPreferences;
  static init () async
  {
     return sharedPreferences = await SharedPreferences.getInstance();
  }

  static bool getBool({
    required String key,
  })
  {
    return sharedPreferences.getBool(key)?? true;
  }

  static Future<dynamic> saveData ({
    required String key,
    required dynamic value
  })
  async {
    if (value is bool) return await sharedPreferences.setBool(key,value);
    if (value is int) return await sharedPreferences.setInt(key,value);
    if (value is String) return await sharedPreferences.setString(key,value);
    if (value is double) return await sharedPreferences.setDouble(key,value);
  }

  static dynamic getData ({
    required String key,
  })
  async
  {
    return  sharedPreferences.get(key);
  }

  static Future<bool> removeData({
  required String key
  }) async
  {
     return await sharedPreferences.remove(key);
  }
}