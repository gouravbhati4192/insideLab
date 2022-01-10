import 'dart:async';
import 'dart:convert';
import 'package:financial_freedom/old/Model/Agent.dart';
import 'package:financial_freedom/old/Model/OTPScreenArgs.dart';
import 'package:financial_freedom/old/widgets/common/ApiConstants.dart';
import 'package:financial_freedom/old/widgets/common/BottomNavigationWidgets.dart';
import 'package:financial_freedom/old/widgets/common/CallApi.dart';
import 'package:financial_freedom/old/widgets/common/ShowSnackBar.dart';
import 'package:financial_freedom/old/widgets/registration/registration.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class OtpScreen extends StatefulWidget {
  final String title;
  final Agent agent;
  final OTPScreenArgs screenArgs;

  OtpScreen({Key key, this.title, this.agent, this.screenArgs})
      : super(key: key);
  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  bool isOtpVerified = false;
  CallApi callApi = new CallApi();
  Map<String, String> registerJson;
  var onTapRecognizer;
  var timerText;
  Future sendOTPResponse;
  TextEditingController textEditingController = TextEditingController();

  StreamController<ErrorAnimationType> errorController;
  bool hasError = false;
  String currentText = "";
  String receivedOTP = '';
  final formKey = GlobalKey<FormState>();

  Timer _timer;
  int _start = 30;
  String startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            timer.cancel();
            timerText = " RESEND";
            _start = 30;
          } else {
            _start = _start - 1;
            timerText = " $_start Seconds";
          }
        },
      ),
    );
    return timerText;
  }

  void sendOTP(String resend) {
    try {
      String url = ApiConstants.BASE_URL + ApiConstants.SEND_OTP_API;
      Map<String, String> requestMap = {
        'email': widget.screenArgs.emailID,
        'type': widget.screenArgs.type,
        'resend': resend
      };
      sendOTPResponse = callApi.callPostApi(url, requestMap, flag: 0);
    } catch (e) {
      print("Exception caught calling send otp api $e");
    }
  }

  @override
  void initState() {
    if (widget.screenArgs != null) {
      sendOTP('false');
    }
    onTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        // Navigator.pop(context);
        startTimer();
        sendOTP('true');
      };
    errorController = StreamController<ErrorAnimationType>();
    timerText = " $_start Seconds";
    startTimer();

    super.initState();
  }

  @override
  void dispose() {
    errorController.close();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        key: scaffoldKey,
        bottomNavigationBar: BottomNavigationWidgets(
          nextButtonName: 'Next',
          cancelButtonName: 'Cancel',
          onPressedNext: (BuildContext btncontext) {
            onNextClick(btncontext);
          },
          onPressedCancel: (BuildContext buildContext) {
            Navigator.pop(buildContext);
          },
        ),
        body: FutureBuilder(
          future: sendOTPResponse,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: ListView(
                    children: <Widget>[
                      SizedBox(height: 30),
                      Container(
                        height: MediaQuery.of(context).size.height / 3,
                        child: FlareActor(
                          "assets/otp.flr",
                          animation: "otp",
                          fit: BoxFit.fitHeight,
                          alignment: Alignment.center,
                        ),
                      ),
                      SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'Email Verification',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 8),
                        child: RichText(
                          text: TextSpan(
                              text: "Enter the code",
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 15)),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Form(
                        key: formKey,
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 30),
                            child: PinCodeTextField(
                              length: 6,
                              obscureText: true,
                              appContext: context,
                              animationType: AnimationType.fade,
                              pinTheme: PinTheme(
                                shape: PinCodeFieldShape.underline,
                                borderRadius: BorderRadius.circular(5),
                                fieldHeight: 50,
                                fieldWidth: 40,
                              ),
                              animationDuration: Duration(milliseconds: 300),
                              backgroundColor: Colors.indigo.shade50,
                              errorAnimationController: errorController,
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
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Text(
                          hasError
                              ? "*Please fill up all the cells properly"
                              : "",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: "Didn't receive the code? ",
                          style: TextStyle(color: Colors.black54, fontSize: 15),
                          children: [
                            TextSpan(
                              text: timerText,
                              recognizer: onTapRecognizer,
                              style: TextStyle(
                                  color: Colors.lightBlue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 14,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 30),
                        child: ButtonTheme(
                          height: 50,
                          child: FlatButton(
                            onPressed: () async {
                              int userId = 0;
                              print(
                                  'Mobile number : ${widget.agent.mobileNumber}');
                              //call verify-otp api
                              String url = ApiConstants.BASE_URL +
                                  ApiConstants.VERIFY_OTP_API;
                              Map<String, String> requestJson = {
                                'mobile': widget.agent.mobileNumber,
                                'email': widget.agent.emailID,
                                'otp': currentText,
                                'type': 'agent'
                              };
                              String resJson =
                                  await callApi.callPostApi(url, requestJson);
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
                                    scaffoldKey.currentState.showSnackBar(
                                        ShowSnackBar("OTP verified")
                                            .showSuccess());
                                    userId = json.decode(resJson)['data']['id'];
                                  },
                                );
                                Map<String, String> registerReqJson = {
                                  "name": widget.agent.firstName +
                                      ' ' +
                                      widget.agent.lastName,
                                  "email": widget.agent.emailID,
                                  "password": widget.agent.password,
                                  "password_confirmation":
                                      widget.agent.confirmPassword,
                                  "location": widget.agent.location,
                                  "aadhar_card": widget.agent.aadharCard,
                                  "pan_card": widget.agent.panCard,
                                  "mobile": widget.agent.mobileNumber
                                };
                                print("registerJson : $registerReqJson");
                                if (isOtpVerified && userId > 0) {
                                  String successJson = await callApi.callPutApi(
                                      ApiConstants.REGISTER_API +
                                          '/' +
                                          userId.toString(),
                                      registerReqJson);
                                  agentDetails.uid = userId;
                                }
                              }
                            },
                            child: Center(
                              child: Text(
                                "VERIFY".toUpperCase(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green.shade300,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.green.shade200,
                                offset: Offset(1, -2),
                                blurRadius: 5),
                            BoxShadow(
                                color: Colors.green.shade200,
                                offset: Offset(-1, 2),
                                blurRadius: 5)
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Container(
                padding: new EdgeInsets.all(32.0),
                child: Center(
                  child: Column(
                    children: [
                      Card(
                        child: Container(
                          padding: new EdgeInsets.all(32.0),
                          child: Column(
                            children: [
                              Icon(
                                Icons.error_outline_outlined,
                                color: Colors.red[900],
                              ),
                              Text('Something went wrong')
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }

  onNextClick(BuildContext buildContext) {
    if (isOtpVerified) {
      Navigator.pushNamed(buildContext, '/conflictOfInterest');
    } else {
      scaffoldKey.currentState
          .showSnackBar(ShowSnackBar('Please verify OTP.').showError());
    }
  }
}
