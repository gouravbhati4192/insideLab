import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:financial_freedom/api/api.dart';
import 'package:financial_freedom/main.dart';
import 'package:financial_freedom/models/user.model.dart';
import 'package:flutter/material.dart';

class UserController extends ChangeNotifier {
  String token;
  User user;

  Future<bool> login({
    String email,
    String password,
  }) async {
    Response response;
    try {
      response = await Dio().post(
        API.login,
        data: {
          "email": email,
          "password": password,
        },
        options: Options(
          headers: {
            "verify-myself": "banana",
          },
        ),
      );
      if (response.statusCode != 200) {
        log(response.statusMessage, name: "Login API Failed");
        FinancialFreedom.sMKey.currentState
            .showSnackBar(SnackBar(content: Text(response.statusMessage)));
        return false;
      }
      if (response.statusCode == 200 && response.data['error'] != 0) {
        log(response.statusMessage, name: "Login API Failed");
        FinancialFreedom.sMKey.currentState
            .showSnackBar(SnackBar(content: Text(response.data["message"])));
        return false;
      }
    } on DioError catch (e) {
      if (e.response == null) {
        log(e.message.toString(), name: "Login API Error");
        FinancialFreedom.sMKey.currentState
            .showSnackBar(SnackBar(content: Text("Network not available")));
      } else {
        log(e.response.data.toString(), name: "Login API Error");
        FinancialFreedom.sMKey.currentState
            .showSnackBar(SnackBar(content: Text("Network not available")));
      }
      return false;
    }

    try {
      log(json.encode(response.data), name: "Login API Data");
      this.token = response.data['data']['token'];
      notifyListeners();
      return true;
    } catch (e) {
      log(e.toString(), name: "Login API Exception");
      FinancialFreedom.sMKey.currentState
          .showSnackBar(SnackBar(content: Text(e.toString())));
      return false;
    }
  }

  void logout() {
    token = null;
    notifyListeners();
  }

  Future<bool> getUserDetails({@required String token}) async {
    Response response;
    try {
      response = await Dio().get(
        API.agentDetails,
        options: Options(
          headers: {
            "verify-myself": "banana",
            "Authorization": "Bearer $token",
          },
        ),
      );
      if (response.statusCode != 200) {
        log(response.statusMessage, name: "Get User Details API Failed");
        FinancialFreedom.sMKey.currentState
            .showSnackBar(SnackBar(content: Text(response.statusMessage)));
        return false;
      }
      if (response.statusCode == 200 && response.data['error'] != 0) {
        log(response.statusMessage, name: "Get User Details API Failed");
        FinancialFreedom.sMKey.currentState
            .showSnackBar(SnackBar(content: Text(response.data["message"])));
        return false;
      }
    } on DioError catch (e) {
      if (e.response == null) {
        log(e.message.toString(), name: "Get User Details API Error");
        FinancialFreedom.sMKey.currentState
            .showSnackBar(SnackBar(content: Text("Network not available")));
      } else {
        log(e.response.data.toString(), name: "Get User Details API Error");
        FinancialFreedom.sMKey.currentState
            .showSnackBar(SnackBar(content: Text("Network not available")));
      }
      return false;
    }

    try {
      log(json.encode(response.data), name: "Get User Details API Data");
      this.user = User.fromJson(response.data['data']);
      notifyListeners();
      return true;
    } catch (e) {
      log(e.toString(), name: "Get User Details API Exception");
      FinancialFreedom.sMKey.currentState
          .showSnackBar(SnackBar(content: Text(e.toString())));
      return false;
    }
  }
}
