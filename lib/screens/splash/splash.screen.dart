import 'package:financial_freedom/controller/user.controller.dart';
import 'package:financial_freedom/old/Home/home.dart';
import 'package:financial_freedom/pref/pref.class.dart';
import 'package:financial_freedom/screens/home/dashboard.screen.dart';
import 'package:financial_freedom/screens/login/login.screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  UserController userController;
  @override
  Widget build(BuildContext context) {
    if (PrefClass.pref == null) {
      PrefClass.initialize(context);
    }
    userController = Provider.of<UserController>(context, listen: false);
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
    Future.delayed(Duration(seconds: 3), () async {
      Map userData = PrefClass.getUserData();
      if (userData == null) {
        Navigator.of(context).pushAndRemoveUntil(
          CupertinoPageRoute(builder: (context) => LoginScreen()),
          (route) => false,
        );
        return;
      }
      bool status = await userController.login(
        email: userData['email'],
        password: userData['password'],
      );
      if (status ?? false) {
        bool status1 = await userController.getUserDetails(
            token: this.userController.token);
        Navigator.of(context).pushAndRemoveUntil(
          CupertinoPageRoute(builder: (context) => DashboardScreen()),
          (route) => false,
        );
      } else {
        Navigator.of(context).pushAndRemoveUntil(
          CupertinoPageRoute(builder: (context) => LoginScreen()),
          (route) => false,
        );
      }
    });
  }
}
