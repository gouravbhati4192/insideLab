import 'dart:async';
import 'dart:convert';
import 'package:financial_freedom/old/Model/Customer.dart';
import 'package:financial_freedom/old/Model/OTPScreenArgs.dart';
import 'package:financial_freedom/old/widgets/common/ApiConstants.dart';
import 'package:financial_freedom/old/widgets/common/BottomNavigationWidgets.dart';
import 'package:financial_freedom/old/widgets/common/CallApi.dart';
import 'package:financial_freedom/old/widgets/common/ShowSnackBar.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class CustomerOtpScreen extends StatefulWidget {
  final String title;
  final Customer customer;
  final OTPScreenArgs screenArgs;
  CustomerOtpScreen({Key key, this.title, this.customer, this.screenArgs})
      : super(key: key);
  @override
  _CustomerOtpScreen createState() => _CustomerOtpScreen();
}

class _CustomerOtpScreen extends State<CustomerOtpScreen> {
  var onTapRecognizer;
  var timerText;
  Future<String> sendOTPResponse;
  bool isOtpVerified = false;
  CallApi callApi = new CallApi();
  Map<String, String> registerJson;
  TextEditingController textEditingController = TextEditingController();
  int caseID;
  StreamController<ErrorAnimationType> errorController;
  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  Timer _timer;
  int _start = 120;
  String startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            timer.cancel();
            timerText = " RESEND";
            _start = 120;
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
        'mobile': '',
        'email': widget.screenArgs.emailID,
        'type': widget.screenArgs.type,
        'resend': resend
      };
      sendOTPResponse = callApi.callPostApi(url, requestMap, flag: 1);
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
                var resJson = json.decode(snapshot.data);
                if (resJson['case'] != null && resJson['case']['id'] != null) {
                  caseID = resJson['case']['id'];
                  widget.customer.userID = caseID.toString();
                }
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
                            style:
                                TextStyle(color: Colors.black54, fontSize: 15),
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
                                //call verify-otp api
                                String url = ApiConstants.BASE_URL +
                                    ApiConstants.VERIFY_OTP_API;
                                Map<String, String> requestJson = {
                                  'case_id': caseID.toString(),
                                  'type': widget.screenArgs.type,
                                  'otp': currentText,
                                  'email': widget.screenArgs.emailID
                                };

                                if (widget.screenArgs.type ==
                                    'product_selection') {
                                  requestJson.update(
                                      'product_id',
                                      (productID) =>
                                          widget.screenArgs.productID);
                                  // requestJson['product_id'] = productID;
                                }
                                String resJson = await callApi
                                    .callPostApi(url, requestJson, flag: 1);
                                int error = json.decode(resJson)['error'];
                                print('ResJson Error : $error');
                                // conditions for validating
                                if (error > 0) {
                                  isOtpVerified = false;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      ShowSnackBar("OTP Does Not Match")
                                          .showError());
                                  setState(() {
                                    hasError = true;
                                  });
                                } else {
                                  setState(
                                    () {
                                      isOtpVerified = true;
                                      hasError = false;
                                      scaffoldKey.currentState.showSnackBar(
                                          ShowSnackBar(
                                                  "OTP verified. Click next to proceed.")
                                              .showSuccess());
                                    },
                                  );
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
            }));
  }

  onNextClick(BuildContext buildContext) {
    if (isOtpVerified) {
      if (widget.screenArgs.caseID != null &&
          widget.screenArgs.caseID.isEmpty) {
        Navigator.pushNamed(buildContext, widget.screenArgs.nextClickURL);
      } else {
        if (widget.screenArgs.type == 'product_selection') {
          Map<String, String> requestMap = {
            'selected_loan': widget.screenArgs.productID,
          };

          callApi
              .callPutApi(ApiConstants.CASE_DETAILS + widget.screenArgs.caseID,
                  requestMap)
              .then((result) {
            if (result == '200')
              Navigator.pushNamed(buildContext, widget.screenArgs.nextClickURL,
                  arguments: widget.screenArgs.caseID);
          });
        } else {
          setState(() {
            widget.customer.userID = caseID.toString();
          });
          Navigator.pushNamed(buildContext, widget.screenArgs.nextClickURL,
              arguments: caseID.toString());
        }
      }
    } else {
      scaffoldKey.currentState
          .showSnackBar(ShowSnackBar('Please verify OTP.').showError());
    }
  }
}
