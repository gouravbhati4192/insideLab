import 'package:financial_freedom/controller/user.controller.dart';
import 'package:financial_freedom/pref/pref.class.dart';
import 'package:financial_freedom/screens/home/dashboard.screen.dart';
import 'package:financial_freedom/style/color.style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  UserController userController;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    userController = Provider.of<UserController>(context);
    return Scaffold(
      body: SafeArea(
        child: LoadingOverlay(
          isLoading: loading,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 40.0),
            children: [
              SizedBox(
                height: 100.0,
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
                controller: email,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.fromLTRB(10, 25, 25, 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: 'Email',
                  hintStyle:
                      Theme.of(context).textTheme.bodyText2.merge(TextStyle(
                            color: ColorStyle.hintColor,
                          )),
                  fillColor: ColorStyle.lightGray,
                  filled: true,
                ),
                style: Theme.of(context).textTheme.bodyText2,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                style: Theme.of(context).textTheme.bodyText2,
                controller: password,
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
                      .merge(TextStyle(color: ColorStyle.hintColor)),
                  fillColor: ColorStyle.lightGray,
                  filled: true,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  primary: ColorStyle.sandyBrown,
                ),
                child: Text(
                  'Login',
                  style: Theme.of(context).textTheme.button,
                ),
                onPressed: () {
                  login();
                },
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: InkWell(
                  onTap: () {},
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
              Center(
                child: Text(
                  'Don\'t have an account yet?',
                  style: Theme.of(context).textTheme.bodyText2.merge(
                        TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  primary: ColorStyle.sandyBrown,
                ),
                child: Text(
                  'Register',
                  style: Theme.of(context).textTheme.button,
                ),
                onPressed: () {
                  // Navigator.of(context).push(CupertinoPageRoute(builder: (context) =>))
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void login() async {
    setState(() {
      loading = true;
    });
    bool status = await userController.login(
      email: email.text,
      password: password.text,
    );
    if (status ?? false) {
      PrefClass.setUserData(
        {
          "email": email.text,
          "password": password.text,
        },
      );
      bool status1 =
          await userController.getUserDetails(token: this.userController.token);
      Navigator.of(context).pushAndRemoveUntil(
        CupertinoPageRoute(builder: (context) => DashboardScreen()),
        (route) => false,
      );
    }
    setState(() {
      loading = true;
    });
  }
}
