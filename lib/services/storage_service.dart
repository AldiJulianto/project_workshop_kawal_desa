import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  Future <void> clearStorage()async {
    try {
      final SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.clear();
    } catch (e){
      print ("[clear storage] Error Occured $e");
    }
  }

  Future<void> setString (String key, String value) async {
    try {
      final SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.setString(key, value);
    } catch (e) {
      print("[setString] Error Occurred$e");
    }
  }

  Future<void> setInt(String key, int value) async {
    try {
      final SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.setInt(key, value);
    } catch(e) {
      print("[setInt] Error Occrrued $e");
    }
  }

  Future<void> setDouble(String key, bool value) async {
    try {
      final SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.setBool(key, value);
    }catch(e) {
      print("[setBool] Error Occurred$e");
    }
  }

  Future getString(String key) async {
    try {
      final SharedPreferences preferences = await SharedPreferences.getInstance();
      final data = preferences.getString(key);

      return data;
    }catch (e){
      print("[getString] Error Occurred $e");
      return null;
    }
  }

  Future<void> getInt(String key) async {
    try {
      final SharedPreferences preferences = await SharedPreferences.getInstance();
      final data = preferences.getInt(key);

      return data;
    }catch(e) {
      print("[getInt] Error Occurred $e");
      return null;
    }
  }

  Future<void> getDouble(String key) async {
    try {
      final SharedPreferences preferences = await SharedPreferences.getInstance();
      final data = preferences.getDouble(key);

      return data;
    }catch(e) {
      print("[getDouble] Error Occurred $e");
      return null;
    }
  }

  Future<void> getBool(String key) async {
    try {
      final SharedPreferences preferences = await SharedPreferences.getInstance();
      final data = preferences.getBool(key);

      return data;
    }catch(e) {
      print("[getBool] Error Occurred $e");
      return null;
    }
  }
}