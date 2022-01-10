import 'dart:async';
import 'dart:convert';

import 'package:financial_freedom/old/customer/customerProductOtpScreen.dart';
import 'package:financial_freedom/old/customer/productDetails.dart';
import 'package:financial_freedom/old/widgets/common/ApiConstants.dart';
import 'package:financial_freedom/old/widgets/common/ShowSnackBar.dart';
import 'package:financial_freedom/old/widgets/common/colors.dart';
import 'package:financial_freedom/old/widgets/common/mycolors.dart';
import 'package:financial_freedom/old/widgets/common/routes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _emailId = new TextEditingController();
  TextEditingController _otp = new TextEditingController();
  TextEditingController _npassword = new TextEditingController();
  TextEditingController _cnpassword = new TextEditingController();
  bool isOtpsend = false;

  final ValueNotifier<int> time = ValueNotifier<int>(120);
  Timer timer;

  String startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer1) {
      if (time.value == 0) {
        timer.cancel();
        return;
      }
      time.value--;
    });
  }

  Future<bool> sendOTP(String emailId) async {
    time.value = 120;
    startTimer();
    try {
      String url = ApiConstants.BASE_URL + ApiConstants.FORGOTPASSWORD_API;
      Map<String, String> requestMap = {
        'email': emailId,
      };
      var res = await callApi.callPostApi(url, requestMap, flag: 0);
      if (res != null) {
        print('res forgot $res');
        var response = json.decode(res);
        if (response['error'] == 0) {
          isOtpsend = true;
        } else {
          isOtpsend = false;
        }
        setState(() {});
      }
      return isOtpsend;
    } catch (e) {
      print("Exception caught calling send otp api $e");
    }
  }

  ButtonStyle _btnstyle = ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0),
  )));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: ListView(
          children: [
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              child: Text(
                'Almost there.',
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .merge(TextStyle(fontSize: 40)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 40,
              child: TextFormField(
                style: Theme.of(context).textTheme.bodyText2,
                controller: _emailId,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.fromLTRB(10, 25, 25, 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: 'Email Address',
                  hintStyle: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .merge(TextStyle(color: GetColor.hintColor)),
                  fillColor: GetColor.lightgray,
                  filled: true,
                ),
              ),
            ),
            isOtpsend
                ? Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ValueListenableBuilder<int>(
                          valueListenable: time,
                          builder:
                              (BuildContext context, int value, Widget child) {
                            return Text(
                              value.toString() + " Seconds",
                              style: TextStyle(color: Colors.white),
                            );
                          }),
                    ),
                  )
                : SizedBox.shrink(),
            SizedBox(
              height: 5,
            ),
            isOtpsend
                ? SizedBox.shrink()
                : Container(
                    margin: EdgeInsets.symmetric(horizontal: 70),
                    child: ElevatedButton(
                      style: _btnstyle,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text('Send OTP'),
                      ),
                      onPressed: () async {
                        var issend = await sendOTP(_emailId.text);

                        if (issend) {
                          _scaffoldKey.currentState.showSnackBar(
                              ShowSnackBar('OTP send on your email id.')
                                  .showSuccess());
                        } else {
                          _scaffoldKey.currentState.showSnackBar(
                              ShowSnackBar('Something went wrong !')
                                  .showError());
                        }
                      },
                    ),
                  ),
            !isOtpsend
                ? SizedBox()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Check your email for an OTP!',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      ValueListenableBuilder<int>(
                          valueListenable: time,
                          builder:
                              (BuildContext context, int value, Widget child) {
                            return RichText(
                              text: TextSpan(
                                  text: 'Didn\'t get one? We can',
                                  style: Theme.of(context).textTheme.bodyText2,
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: ' send another.',
                                        style: value == 0
                                            ? TextStyle(
                                                color: MyColors.yellowColor(),
                                                fontWeight: FontWeight.bold,
                                                decoration:
                                                    TextDecoration.underline,
                                              )
                                            : TextStyle(
                                                color: Colors.white,
                                              ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () async {
                                            print('tapped');
                                            var issend =
                                                await sendOTP(_emailId.text);

                                            if (issend) {
                                              _scaffoldKey.currentState
                                                  .showSnackBar(ShowSnackBar(
                                                          'OTP send on your email id.')
                                                      .showSuccess());
                                            } else {
                                              _scaffoldKey.currentState
                                                  .showSnackBar(ShowSnackBar(
                                                          'Something went wrong !')
                                                      .showError());
                                            }
                                          })
                                  ]),
                            );
                          }),
                    ],
                  ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 40,
              child: TextFormField(
                style: Theme.of(context).textTheme.bodyText2,
                controller: _otp,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.fromLTRB(10, 25, 25, 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: 'Enter OTP',
                  hintStyle: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .merge(TextStyle(color: GetColor.hintColor)),
                  fillColor: GetColor.lightgray,
                  filled: true,
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            // Container(
            //   margin: EdgeInsets.symmetric(horizontal: 70),
            //   child: ElevatedButton(
            //     style: _btnstyle,
            //     child: Padding(
            //       padding: const EdgeInsets.all(10.0),
            //       child: Text('Verify'),
            //     ),
            //     onPressed: () async {
            //       try {
            //         String url = ApiConstants.BASE_URL +
            //             ApiConstants.VERIFY_OTP_RESET_API;
            //         Map<String, String> requestMap = {
            //           "email": _emailId.text,
            //           "otp": _otp.text
            //           // "new_password": "12345678",
            //           //"confirm_password": "12345678"
            //         };
            //         var res =
            //             await callApi.callPostApi(url, requestMap, flag: 0);
            //         if (res != null) {
            //           print('res verify otp reset $res');
            //         }
            //       } catch (e) {
            //         print("Exception caught calling verify otp api $e");
            //       }
            //     },
            //   ),
            // ),
            // SizedBox(
            //   height: 30,
            // ),
            Container(
              height: 40,
              child: TextFormField(
                style: Theme.of(context).textTheme.bodyText2,
                controller: _npassword,
                obscureText: true,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.fromLTRB(10, 25, 25, 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: 'New Password',
                  hintStyle: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .merge(TextStyle(color: GetColor.hintColor)),
                  fillColor: GetColor.lightgray,
                  filled: true,
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              height: 40,
              child: TextFormField(
                style: Theme.of(context).textTheme.bodyText2,
                controller: _cnpassword,
                obscureText: true,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.fromLTRB(10, 25, 25, 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: 'Confirm New Password',
                  hintStyle: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .merge(TextStyle(color: GetColor.hintColor)),
                  fillColor: GetColor.lightgray,
                  filled: true,
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 70),
              child: Builder(
                builder: (btncon) => ElevatedButton(
                  style: _btnstyle,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text('Submit'),
                  ),
                  onPressed: () async {
                    try {
                      String url = ApiConstants.BASE_URL +
                          ApiConstants.VERIFY_OTP_RESET_API;
                      Map<String, String> requestMap = {
                        "email": _emailId.text,
                        "otp": _otp.text,
                        "new_password": _npassword.text,
                        "confirm_password": _cnpassword.text,
                      };
                      var res =
                          await callApi.callPostApi(url, requestMap, flag: 0);
                      if (res != null) {
                        print('res change password  $res');
                        if (json.decode(res)['error'] == 0) {
                          _scaffoldKey.currentState.showSnackBar(
                              ShowSnackBar('Password changed successfully.')
                                  .showSuccess());
                          Navigator.pushReplacementNamed(
                              btncon, '/doneNewPassword');
                        } else {
                          _scaffoldKey.currentState.showSnackBar(
                              ShowSnackBar('Something went wrong!.')
                                  .showError());
                        }
                      }
                    } catch (e) {
                      print("Exception caught calling change password api $e");
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DoneNewPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'We are done.',
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .merge(TextStyle(fontSize: 40)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50, bottom: 20),
              child: Text(
                'You have a new password',
                style: Theme.of(context).textTheme.bodyText2.merge(
                      TextStyle(fontWeight: FontWeight.bold),
                    ),
              ),
            ),
            RichText(
              text: TextSpan(
                  text: 'You should now',
                  style: Theme.of(context).textTheme.bodyText2,
                  children: <TextSpan>[
                    TextSpan(
                        text: ' Login',
                        style: Theme.of(context).textTheme.bodyText2.merge(
                              TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.popAndPushNamed(context, Routes.login);
                          }),
                    TextSpan(
                      text: ' and check it out',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
