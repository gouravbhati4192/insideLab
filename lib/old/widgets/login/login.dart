import 'dart:convert';
import 'dart:developer';

import 'package:financial_freedom/controller/user.controller.dart';
import 'package:financial_freedom/main.dart';
import 'package:financial_freedom/old/widgets/common/ApiConstants.dart';
import 'package:financial_freedom/old/widgets/common/CallApi.dart';
import 'package:financial_freedom/old/widgets/common/SharedPref.dart';
import 'package:financial_freedom/old/widgets/common/ShowSnackBar.dart';
import 'package:financial_freedom/old/widgets/common/StringConstants.dart';
import 'package:financial_freedom/old/widgets/common/colors.dart';
import 'package:financial_freedom/old/widgets/common/routes.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
SharedPref _pref = new SharedPref();
CallApi _callApi = new CallApi();

class FinancialFreedomLogin extends StatefulWidget {
  FinancialFreedomLogin({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _FinancialFreedomLogin createState() => _FinancialFreedomLogin();
}

class _FinancialFreedomLogin extends State<FinancialFreedomLogin> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _emailid = new TextEditingController();
  TextEditingController _password = new TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.

    _emailid.dispose();
    _password.dispose();
    super.dispose();
  }

  /* {
  "email" : "sankalp@kriyawantika.com",
  "password" : "12345678"
  }*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(40),
          child: ListView(
            children: [
              SizedBox(
                height: 40.0,
              ),
              SizedBox(
                height: 80.0,
                child: Image.asset(
                  "assets/yellow-full.png",
                ),
              ),
              SizedBox(
                height: 60,
              ),
              TextFormField(
                controller: _emailid,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.fromLTRB(10, 25, 25, 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: 'Email',
                  hintStyle:
                      Theme.of(context).textTheme.bodyText2.merge(TextStyle(
                            color: GetColor.hintColor,
                          )),
                  fillColor: GetColor.lightgray,
                  filled: true,
                ),
                style: Theme.of(context).textTheme.bodyText2,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                style: Theme.of(context).textTheme.bodyText2,
                controller: _password,
                obscureText: true,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.fromLTRB(10, 25, 25, 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: 'Password',
                  hintStyle: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .merge(TextStyle(color: GetColor.hintColor)),
                  fillColor: GetColor.lightgray,
                  filled: true,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Builder(
                builder: (btncontext) => RaisedButton(
                  child: Text(
                    'Login',
                    style: Theme.of(context).textTheme.button,
                  ),
                  onPressed: () {
                    //TODO: call login api and got to home page
                    //Navigator.pushNamed(btncontext, Routes.home);
                    loginValidation(context);
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 0, 10, 0),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.forgotpassword);
                  },
                  child: Text(
                    'Forgot Password?',
                    style: Theme.of(context).textTheme.bodyText2.merge(
                          TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                  ),
                ),
              ),
              SizedBox(
                height: 100,
              ),
              Text(
                'Don\'t have an account yet?',
                style: Theme.of(context).textTheme.bodyText2.merge(
                      TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
              ),
              SizedBox(
                height: 5,
              ),
              RaisedButton(
                child: Text(
                  'Register',
                  style: Theme.of(context).textTheme.button,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, Routes.registration);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  loginValidation(BuildContext context) async {
    Map<String, String> requestJson = {
      'email': _emailid.text,
      'password': _password.text
    };
    var result = await _callApi.callPostApi(
        ApiConstants.BASE_URL + ApiConstants.LOGIN_API, requestJson);
    log('Login api result ${json.decode(result)}');
    var decodeJson = json.decode(result);
    int error = decodeJson['error'];
    if (error == 0) {
      var token = decodeJson['data']['token'];
      print('token $token');
      if (await _pref.setAuthToken(token) &&
          await _pref.setLoginDetails(_emailid.text, _password.text)) {
        _emailid.clear();
        _password.clear();
        Navigator.pushNamedAndRemoveUntil(
            context, Routes.home, (route) => false);
      } else {
        log('token not saved');
      }
    } else {
      _scaffoldKey.currentState
          .showSnackBar(ShowSnackBar(decodeJson['message']).showError());
    }
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: Theme.of(context).primaryColor,
        child: Image.asset("assets/blue-full.png"),
      ),
    );
  }

  @override
  initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              color: Colors.blue,
              playSound: true,
              icon: '@mipmap/ic_launcher',
            ),
          ),
        );
      }
    });
    Future.delayed(Duration(seconds: 3), () {
      checkLogin().then((value) {
        print("Hello");
        print(value);
        if (value) {
          Navigator.pushReplacementNamed(
              context, Routes.home); //if alraedy login then go to home page
        } else {
          Navigator.pushReplacementNamed(
              context, Routes.login); //if not login then go to login screen
        }
      });
    });
  }

  Future<bool> checkLogin() async {
    bool isLogin;
    String _uid = await _pref.getUid();
    String _pass = await _pref.getPass();
    if ((_uid != null) && (_pass != null)) {
      Map<String, String> requestJson = {'email': _uid, 'password': _pass};
      var result = await _callApi.callPostApi(
          ApiConstants.BASE_URL + ApiConstants.LOGIN_API, requestJson);
      var decodeJson = json.decode(result);
      int error = decodeJson['error'];
      if (error == 0) {
        var token = decodeJson['data']['token'];
        if (await _pref.setAuthToken(token) &&
            await _pref.setLoginDetails(_uid, _pass)) {
          isLogin = true;
        } else {
          log('error in saving login detials in SF');
          isLogin = false;
        }
      }
    } else {
      isLogin = false;
    }
    return isLogin;
  }
}
