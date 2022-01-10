import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:financial_freedom/old/Model/ProductsArguments.dart';
import 'package:financial_freedom/old/Model/customerData.dart';
import 'package:financial_freedom/old/components.dart';
import 'package:financial_freedom/old/widgets/common/ApiConstants.dart';
import 'package:financial_freedom/old/widgets/common/CallApi.dart';
import 'package:financial_freedom/old/widgets/common/SharedPref.dart';
import 'package:financial_freedom/old/widgets/common/ShowSnackBar.dart';
import 'package:financial_freedom/old/widgets/common/colors.dart';
import 'package:financial_freedom/old/widgets/common/mycolors.dart';
import 'package:financial_freedom/old/widgets/common/routes.dart';
import 'package:financial_freedom/old/widgets/customer/customer-profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreenProduct extends StatefulWidget {
  final Customer customerData;
  final productID;
  OtpScreenProduct({this.customerData, this.productID});
  @override
  _OtpScreenProductState createState() => _OtpScreenProductState();
}

class _OtpScreenProductState extends State<OtpScreenProduct> {
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
        'type': 'product_selection',
        'product_id': widget.productID,
        'case_id': widget.customerData.caseID,
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
                      // widget.customerData.caseID = caseID.toString();
                    }
                    return ListView(
                      children: [
                        Text(
                          'Verification of Lending Product Selection',
                          style: Theme.of(context).textTheme.headline6.merge(
                                TextStyle(fontSize: 25),
                              ),
                          textAlign: TextAlign.center,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 50, bottom: 0),
                          child: Text(
                            'We have send an OTP to\nEmail address of your Customer',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .merge(TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ),
                        Text(
                          '\n${widget.customerData.emailID}\n',
                          style: Theme.of(context).textTheme.bodyText2.merge(
                              TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: MyColors.yellowColor())),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 40),
                          child: Text(
                            'Enter OTP here for Product Verification',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyText2.merge(
                                  TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
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
                                      text:
                                          'Ask them to check their inbox and share OTP.\nDidn\'t get one? We can ',
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
                          height: 10,
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
                          padding: const EdgeInsets.only(top: 10),
                          child: PinCodeTextField(
                            appContext: context,
                            length: 6,
                            animationType: AnimationType.fade,
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
                                    'type': 'product-selection',
                                    'otp': currentText,
                                    'email': widget.customerData.emailID,
                                    'product_id': widget.productID,
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
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
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
                                    onPressed: () async {
                                      // Navigator.pushNamed(context, Routes.personalInfo);
                                      print('next $isOtpVerified');
                                      if (isOtpVerified) {
                                        if (await setProductLoan()) {
                                          ProductsArguments args =
                                              new ProductsArguments(
                                                  widget.customerData.caseID
                                                      .toString(),
                                                  null,
                                                  widget.customerData.emailID
                                                      .toString(),
                                                  allowBack: false);
                                          Navigator.pushNamedAndRemoveUntil(
                                              context,
                                              Routes.home,
                                              (route) => false);
                                          Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                              pageBuilder: (context, _, __) =>
                                                  CustomerProfile(
                                                customerID: widget
                                                    .customerData.caseID
                                                    .toString(),
                                              ),
                                            ),
                                          );
                                        } else {
                                          _scaffoldKey.currentState
                                              .showSnackBar(ShowSnackBar(
                                                      'Unable to select product')
                                                  .showError());
                                        }
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

  Future<bool> setProductLoan() async {
    SharedPref _pref = new SharedPref();
    print({
      "id": widget.customerData.caseID,
      "loan_selected_id": widget.productID,
    });
    try {
      Response response = await Dio().post(
        ApiConstants.BASE_URL + 'Product-Select-Loan',
        data: FormData.fromMap({
          "id": widget.customerData.caseID,
          "loan_selected_id": widget.productID,
        }),
        options: Options(headers: {
          "verify-myself": "banana",
          "Authorization": "Bearer ${await _pref.getToken()}"
        }),
      );
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
