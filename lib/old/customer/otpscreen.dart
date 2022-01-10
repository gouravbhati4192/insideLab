import 'dart:async';
import 'dart:convert';
import 'package:financial_freedom/old/Model/customerData.dart';
import 'package:financial_freedom/old/components.dart';
import 'package:financial_freedom/old/widgets/common/ApiConstants.dart';
import 'package:financial_freedom/old/widgets/common/CallApi.dart';
import 'package:financial_freedom/old/widgets/common/ShowSnackBar.dart';
import 'package:financial_freedom/old/widgets/common/colors.dart';
import 'package:financial_freedom/old/widgets/common/mycolors.dart';
import 'package:financial_freedom/old/widgets/common/routes.dart';
import 'package:financial_freedom/old/widgets/customer/customer-profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:url_launcher/url_launcher.dart';

class OtpScreen extends StatefulWidget {
  final Customer customerData;
  OtpScreen({this.customerData});
  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController textEditingController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  StreamController<ErrorAnimationType> errorController;
  Future<String> sendOTPResponse;
  bool hasError = false;

  String currentText = "";
  int caseID;
  bool isOtpVerified;
  CallApi callApi = new CallApi();

  void sendOTP(String resend) {
    time.value = 120;
    startTimer();
    try {
      String url = ApiConstants.BASE_URL + ApiConstants.SEND_OTP_API;
      Map<String, String> requestMap = {
        'mobile': '',
        'email': widget.customerData.emailID,
        'type': widget.customerData.otpType,
        'resend': resend
      };
      sendOTPResponse = callApi.callPostApi(url, requestMap, flag: 1);
    } catch (e) {
      print("Exception caught calling send otp api $e");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    if (widget.customerData != null) {
      sendOTP('false');
    }
    // onTapRecognizer = TapGestureRecognizer()
    //   ..onTap = () {
    //     sendOTP('true');
    //   };
    errorController = StreamController<ErrorAnimationType>();

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    errorController.close();
    if (timer.isActive) {
      timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // CustomComponents.showBackStopDialog(context);
        return true;
      },
      child: Scaffold(
        key: _scaffoldKey,
        bottomNavigationBar: Row(
          children: [],
        ),
        body: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.all(20),
            child: FutureBuilder(
                future: sendOTPResponse,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var resJson = json.decode(snapshot.data);
                    if (resJson['case'] != null &&
                        resJson['case']['id'] != null) {
                      caseID = resJson['case']['id'];
                      widget.customerData.userID = caseID.toString();
                    }
                    return ListView(
                      children: [
                        Text(
                          'We have send an OTP to Email address of your Customer',
                          style: Theme.of(context).textTheme.headline6.merge(
                                TextStyle(fontSize: 25),
                              ),
                          textAlign: TextAlign.center,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 50, bottom: 10),
                          child: Text(
                            'Ask them to check their Inbox.',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .merge(TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ),
                        ValueListenableBuilder<int>(
                            valueListenable: time,
                            builder: (BuildContext context, int value,
                                Widget child) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: RichText(
                                  text: TextSpan(
                                      text: 'Didn\'t get one? We can',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          .merge(TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      children: <TextSpan>[
                                        TextSpan(
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              if (time.value == 0) {
                                                sendOTP('true');
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(ShowSnackBar(
                                                            "OTP Resent")
                                                        .showSuccess());
                                              }
                                            },
                                          text: " send another.",
                                          style: value == 0
                                              ? TextStyle(
                                                  color: yellowColor(),
                                                  fontWeight: FontWeight.bold,
                                                  decoration:
                                                      TextDecoration.underline,
                                                )
                                              : TextStyle(
                                                  color: Colors.white,
                                                ),
                                        ),
                                      ]),
                                ),
                              );
                            }),
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ValueListenableBuilder<int>(
                                valueListenable: time,
                                builder: (BuildContext context, int value,
                                    Widget child) {
                                  return Text(
                                    value.toString() + " Seconds",
                                    style: TextStyle(color: Colors.white),
                                  );
                                }),
                          ),
                        ),
                        // Center(
                        //   child: Text(
                        //     'Enter OTP here for Email Verification',
                        //     style: Theme.of(context).textTheme.headline6.merge(
                        //           TextStyle(color: Colors.white, fontSize: 20),
                        //         ),
                        //   ),
                        // ),
                        Padding(
                          padding: const EdgeInsets.only(top: 25),
                          child: PinCodeTextField(
                            length: 6,
                            animationType: AnimationType.fade,
                            keyboardType: TextInputType.number,
                            appContext: context,
                            pinTheme: PinTheme(
                              shape: PinCodeFieldShape.box,
                              inactiveColor: GetColor.lightgray,
                              borderRadius: BorderRadius.circular(10),
                              fieldHeight: 50,
                              fieldWidth: 40,
                              activeFillColor: Colors.white,
                              inactiveFillColor: GetColor.lightgray,
                            ),
                            animationDuration: Duration(milliseconds: 300),
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            enableActiveFill: true,
                            controller: textEditingController,
                            onCompleted: (v) {
                              print("Completed");
                            },
                            onChanged: (value) {
                              print(value);
                              setState(() {
                                currentText = value;
                              });
                            },
                            beforeTextPaste: (text) {
                              print("Allowing to paste $text");
                              //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                              //but you can show anything you want here, like your pop up saying wrong paste format or etc
                              return true;
                            },
                          ),
                        ),

                        Container(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Align(
                            child: SizedBox(
                              width: 100,
                              child: RaisedButton(
                                onPressed: () async {
                                  //call verify-otp api
                                  String url = ApiConstants.BASE_URL +
                                      ApiConstants.VERIFY_OTP_API;
                                  Map<String, String> requestJson = {
                                    'case_id': caseID.toString(),
                                    'type': widget.customerData.otpType,
                                    'otp': currentText,
                                    'email': widget.customerData.emailID
                                  };

                                  // if ( widget.customerData.otpType == 'product_selection') {
                                  //   requestJson.update('product_id',
                                  //       (productID) => widget.screenArgs.productID);
                                  //   // requestJson['product_id'] = productID;
                                  // }
                                  String resJson = await callApi
                                      .callPostApi(url, requestJson, flag: 1);
                                  int error = json.decode(resJson)['error'];
                                  print('ResJson Error : $error');
                                  // conditions for validating
                                  if (error > 0) {
                                    isOtpVerified = false;
                                    errorController.add(ErrorAnimationType
                                        .shake); // Triggering error shake animation
                                    setState(() {
                                      hasError = true;
                                    });
                                  } else {
                                    setState(
                                      () {
                                        isOtpVerified = true;
                                        hasError = false;
                                        _scaffoldKey.currentState.showSnackBar(
                                            ShowSnackBar(
                                                    "OTP verified. Click next to proceed.")
                                                .showSuccess());
                                      },
                                    );
                                  }
                                },
                                child: Text(
                                  'Verify',
                                  style: Theme.of(context).textTheme.button,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          isOtpVerified == null
                              ? ''
                              : (isOtpVerified
                                  ? 'OTP Verification Successful !'
                                  : 'OTP does not match'),
                          style: Theme.of(context).textTheme.headline6.merge(
                                TextStyle(
                                  fontSize: 20,
                                  color: isOtpVerified ?? false
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              ),
                          textAlign: TextAlign.center,
                        ),
                        isOtpVerified ?? false
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Text(
                                      'Your customers has agreed to share the OTP because they trust us for managing their personal information.',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          .merge(TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: RichText(
                                      text: TextSpan(
                                          text:
                                              'It is our responsibility as per the compliances in\n',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2
                                              .merge(TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: 'privacy policy',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2
                                                    .merge(
                                                      TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          decoration:
                                                              TextDecoration
                                                                  .underline,
                                                          color: GetColor
                                                              .sandybrown),
                                                    ),
                                                recognizer:
                                                    TapGestureRecognizer()
                                                      ..onTap = () {
                                                        launch(
                                                            "https://www.insiderlab.in/app-privacy-component");
                                                      }),
                                            TextSpan(
                                              text:
                                                  ' to ethically and carefully manage all data.',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2
                                                  .merge(TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                          ]),
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                        text: 'Please read carefully the',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            .merge(TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: ' DOs & DONTs',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2
                                                  .merge(
                                                    TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        decoration:
                                                            TextDecoration
                                                                .underline,
                                                        color: GetColor
                                                            .sandybrown),
                                                  ),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  print('tapped');
                                                }),
                                          TextSpan(
                                            text:
                                                ' to\ncollect and manage customers data.',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2
                                                .merge(TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                        ]),
                                  ),
                                ],
                              )
                            : SizedBox(
                                height: 100.0,
                              ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Align(
                                child: SizedBox(
                                  width: 100,
                                  child: RaisedButton(
                                    color: Colors.grey,
                                    onPressed: () {
                                      // CustomComponents.showBackStopDialog(
                                      //     context);
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'Back',
                                      style: Theme.of(context)
                                          .textTheme
                                          .button
                                          .copyWith(
                                            color: MyColors.yellowColor(),
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                child: SizedBox(
                                  width: 100,
                                  child: RaisedButton(
                                    onPressed: () {
                                      // Navigator.pushNamed(context, Routes.personalInfo);
                                      print('next $isOtpVerified');
                                      if (isOtpVerified) {
                                        setState(() {
                                          widget.customerData.userID =
                                              caseID.toString();
                                          widget.customerData.caseID =
                                              caseID.toString();
                                        });
                                        Navigator.pushReplacementNamed(
                                            context, Routes.personalInfo,
                                            arguments: widget.customerData);
                                      } else {
                                        _scaffoldKey.currentState.showSnackBar(
                                            ShowSnackBar('Please verify OTP.')
                                                .showError());
                                      }
                                    },
                                    child: Text(
                                      'Next',
                                      style: Theme.of(context).textTheme.button,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          ),
        ),
      ),
    );
  }

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
}
