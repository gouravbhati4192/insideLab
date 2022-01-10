import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  final String authToken = "token";
  final String userId = "userId";
  final String pass = "password";

//set data into shared preferences like this
  Future<bool> setLoginDetails(String uid, String pass) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(this.userId, uid);
      prefs.setString(this.pass, pass);
      log('Login details saved in Shared pref');
      return true;
    } catch (e) {
      log('Exception caught in Login details sharedPreference : $e');
      return false;
    }
  }

//get value from shared preferences

  Future<String> getUid() async {
    try {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      return pref.getString(this.userId) ?? null;
    } catch (e) {
      log('Exception caught while getting Login token from sharedPreference : $e');
      return null;
    }
  }

  Future<String> getPass() async {
    try {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      return pref.getString(this.pass) ?? null;
    } catch (e) {
      log('Exception caught while getting Login token from sharedPreference : $e');
      return null;
    }
  }

//set data into shared preferences like this
  Future<bool> setAuthToken(String auth_token) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(this.authToken, auth_token);
      log('Token saved in Shared pref');
      return true;
    } catch (e) {
      log('Exception caught in Login token sharedPreference : $e');
      return false;
    }
  }

//get value from shared preferences

  Future<String> getToken() async {
    try {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      String auth_token;
      auth_token = pref.getString(this.authToken) ?? null;
      return auth_token;
    } catch (e) {
      log('Exception caught while getting Login token from sharedPreference : $e');
      return null;
    }
  }

  Future<bool> checkSharedPref(String key) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.containsKey(key);
  }

  Future<bool> clearPreferences() async {
    try {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.remove(this.userId);
      await pref.remove(this.pass);
      await pref.remove(this.authToken);
      await Future.delayed(Duration(seconds: 2));
      return true;
    } catch (e) {}
    return false;
  }
}
