import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class PrefClass {
  static SharedPreferences pref;

  static initialize(context) async {
    pref = await SharedPreferences.getInstance();
  }

  static void setUserData(Map userData) {
    pref.setString(
        "userDataPG", (userData == null ? "" : json.encode(userData)));
  }

  static Map getUserData() {
    String userData = pref.getString("userDataPG");
    return userData == null || userData == "" ? null : json.decode(userData);
  }
}
