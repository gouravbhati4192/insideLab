import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:financial_freedom/old/Home/app-channel-partner.dart';
import 'package:financial_freedom/old/components.dart';
import 'package:financial_freedom/old/customer/agent-congratulation-screen.dart';
import 'package:financial_freedom/old/widgets/common/ApiConstants.dart';
import 'package:financial_freedom/old/widgets/common/CallApi.dart';
import 'package:financial_freedom/old/widgets/common/ShowSnackBar.dart';
import 'package:financial_freedom/old/widgets/common/UploadDocument.dart';
import 'package:financial_freedom/old/widgets/common/colors.dart';
import 'package:financial_freedom/old/widgets/common/mycolors.dart';
import 'package:financial_freedom/old/widgets/registration/expandable.dart';
import 'package:financial_freedom/old/widgets/registration/otpscreen.dart';
import 'package:financial_freedom/old/widgets/registration/registration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:url_launcher/url_launcher.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class RegisterMain extends StatefulWidget {
  final String title;
  RegisterMain({Key key, this.title}) : super(key: key);
  @override
  _RegisterMain createState() => _RegisterMain();
}

class _RegisterMain extends State<RegisterMain> {
  CallApi callApi = new CallApi();
  int userId = 0;
  List<File> aadhaarFiles = [];
  List<File> panFiles = [];
  File aadhaarFrontImage;
  File aadhaarBackImage;
  File panFrontImage;
  UploadDocument obj = new UploadDocument();
  TextEditingController email = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController otp = TextEditingController();
  TextEditingController fullName = TextEditingController();
  TextEditingController mobileNumber = TextEditingController();
  TextEditingController whatsappNumber = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController currentProfession = TextEditingController();
  TextEditingController employmentType = TextEditingController();
  TextEditingController workExperience = TextEditingController();
  TextEditingController employeeName = TextEditingController();
  TextEditingController bankName = TextEditingController();
  TextEditingController accountHolderName = TextEditingController();
  TextEditingController accountNumber = TextEditingController();
  TextEditingController ifscCode = TextEditingController();
  TextEditingController address = TextEditingController();
  GlobalKey<FormState> getStartedFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> otpVerificationFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> setupProfileFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> employmentDetailsFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> aadhaarVerificationFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> panVerificationFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> bankDetailsFormKey = GlobalKey<FormState>();
  bool isSameWhatsappNumber = false;
  bool workedInFinancialSector = false;
  bool holdGovOffice = false;
  bool sendEarnings = false;
  bool termsAndConditions = false;
  bool servicePartnerAgreement = false;
  List<ExpandableController> panels = [
    ExpandableController(),
    ExpandableController(),
    ExpandableController(),
    ExpandableController(),
    ExpandableController(),
    ExpandableController(),
    ExpandableController(),
  ];

  bool isOtpVerified;

  bool hasError;
  bool loading = false;

  void active(int index) {
    panels[index].expanded = true;
    for (var i = 0; i < panels.length; i++) {
      if (i != index) {
        if (panels[i].expanded) {
          panels[i].expanded = false;
        }
      }
    }
    print(index);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        CustomComponents.showBackStopDialogUser(context);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.backgroundColor(),
          title: Text(
            widget.title,
            style: TextStyle(
              color: MyColors.yellowColor(),
            ),
          ),
          iconTheme: IconThemeData(color: MyColors.yellowColor()),
        ),
        body: LoadingOverlay(
          isLoading: loading,
          child: SingleChildScrollView(
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: HexColor('#ffffff'),
                    // color:/     : HexColor('#ffffff'),
                    boxShadow: [
                      BoxShadow(
                        color: HexColor('#0a000000'),
                        blurRadius: 1.5,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: ExpandablePanel(
                    onTap: () async {
                      active(0);
                      // String questions = await CallApi()
                      //     .callGetApi(ApiConstants.GET_QUESTION_LIST, false);
                      // print(questions);
                    },
                    theme: ExpandableThemeData(
                      iconColor: HexColor("#0568a3"),
                    ),
                    controller: panels[0],
                    header: ListTile(
                      // leading: Image.asset(
                      //   'images/user_3.png',
                      //   height: 25,
                      //   width: 25,
                      // ),
                      title: Row(
                        children: [
                          Row(
                            children: [
                              Text(
                                'Get Started',
                                style: GoogleFonts.roboto(
                                  color: HexColor("#212121"),
                                ),
                              ),
                              panels.indexWhere((e) => e.expanded) > 0
                                  ? SizedBox(
                                      height: 26,
                                      width: 40,
                                      child: Image.asset(
                                        'assets/check.png',
                                      ),
                                    )
                                  : SizedBox.shrink()
                            ],
                          ),
                          // SizedBox(
                          //   width: 10,
                          // ),
                          // Icon(FlutterIcons.check_circle_fea, color: Colors.green),
                        ],
                      ),
                    ),
                    expanded: buildGetStarted(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: HexColor('#ffffff'),
                    boxShadow: [
                      BoxShadow(
                        color: HexColor('#0a000000'),
                        blurRadius: 1.5,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: ExpandablePanel(
                    onTap: () {
                      if (panels.indexWhere((e) => e.expanded) < 1)
                        panels[1].expanded = !panels[1].expanded;
                      else
                        active(1);
                    },
                    controller: panels[1],
                    theme: ExpandableThemeData(
                      iconColor: HexColor("#0568a3"),
                    ),
                    header: ListTile(
                      // leading: Image.asset(
                      //   'images/visitor_identification.png',
                      //   height: 25,
                      //   width: 25,
                      // ),
                      title: Row(
                        children: [
                          Text(
                            'Email OTP Verification',
                            style: GoogleFonts.roboto(
                              color: HexColor("#212121"),
                            ),
                          ),
                          panels.indexWhere((e) => e.expanded) > 1
                              ? SizedBox(
                                  height: 26,
                                  width: 40,
                                  child: Image.asset(
                                    'assets/check.png',
                                  ),
                                )
                              : SizedBox.shrink()
                        ],
                      ),
                    ),
                    expanded: buildOTPVerification(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: HexColor('#ffffff'),
                    boxShadow: [
                      BoxShadow(
                        color: HexColor('#0a000000'),
                        blurRadius: 1.5,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: ExpandablePanel(
                    onTap: () {
                      if (panels.indexWhere((e) => e.expanded) < 2)
                        panels[2].expanded = !panels[2].expanded;
                      else
                        active(2);
                    },
                    controller: panels[2],
                    theme: ExpandableThemeData(
                      iconColor: HexColor("#0568a3"),
                    ),
                    header: ListTile(
                      // leading: Image.asset(
                      //   'images/image_16.png',
                      //   height: 20,
                      //   width: 20,
                      // ),
                      title: Row(
                        children: [
                          Text(
                            'Setup your Profile',
                            style: GoogleFonts.roboto(
                              color: HexColor("#212121"),
                            ),
                          ),
                          panels.indexWhere((e) => e.expanded) > 2
                              ? SizedBox(
                                  height: 26,
                                  width: 40,
                                  child: Image.asset(
                                    'assets/check.png',
                                  ),
                                )
                              : SizedBox.shrink()
                        ],
                      ),
                    ),
                    expanded: buildSetupProfile(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: HexColor('#ffffff'),
                    boxShadow: [
                      BoxShadow(
                        color: HexColor('#0a000000'),
                        blurRadius: 1.5,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: ExpandablePanel(
                    onTap: () {
                      if (panels.indexWhere((e) => e.expanded) < 3)
                        panels[3].expanded = !panels[3].expanded;
                      else
                        active(3);
                    },
                    controller: panels[3],
                    theme: ExpandableThemeData(
                      iconColor: HexColor("#0568a3"),
                    ),
                    header: ListTile(
                      // leading: Image.asset(
                      //   'images/library.png',
                      //   height: 20,
                      //   width: 20,
                      // ),
                      title: Row(
                        children: [
                          Text(
                            'Employment Details',
                            style: GoogleFonts.roboto(
                              color: HexColor("#212121"),
                            ),
                          ),
                          panels.indexWhere((e) => e.expanded) > 3
                              ? SizedBox(
                                  height: 26,
                                  width: 40,
                                  child: Image.asset(
                                    'assets/check.png',
                                  ),
                                )
                              : SizedBox.shrink()
                        ],
                      ),
                    ),
                    expanded: buildEmploymentDetails(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: HexColor('#ffffff'),
                    boxShadow: [
                      BoxShadow(
                        color: HexColor('#0a000000'),
                        blurRadius: 1.5,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: ExpandablePanel(
                    onTap: () {
                      if (panels.indexWhere((e) => e.expanded) < 4)
                        panels[4].expanded = !panels[4].expanded;
                      else
                        active(4);
                    },
                    controller: panels[4],
                    theme: ExpandableThemeData(
                      iconColor: HexColor("#0568a3"),
                    ),
                    header: ListTile(
                      // leading: Image.asset(
                      //   'images/family.png',
                      //   height: 20,
                      //   width: 20,
                      // ),
                      title: Row(
                        children: [
                          Text(
                            'Aadhaar Verification',
                            style: GoogleFonts.roboto(
                              color: HexColor("#212121"),
                            ),
                          ),
                          panels.indexWhere((e) => e.expanded) > 4
                              ? SizedBox(
                                  height: 26,
                                  width: 40,
                                  child: Image.asset(
                                    'assets/check.png',
                                  ),
                                )
                              : SizedBox.shrink()
                        ],
                      ),
                    ),
                    expanded: buildAadhaarVerification(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: HexColor('#ffffff'),
                    boxShadow: [
                      BoxShadow(
                        color: HexColor('#0a000000'),
                        blurRadius: 1.5,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: ExpandablePanel(
                    onTap: () {
                      if (panels.indexWhere((e) => e.expanded) < 5)
                        panels[5].expanded = !panels[5].expanded;
                      else
                        active(5);
                    },
                    controller: panels[5],
                    theme: ExpandableThemeData(
                      iconColor: HexColor("#0568a3"),
                    ),
                    header: ListTile(
                      // leading: Image.asset(
                      //   'images/family.png',
                      //   height: 20,
                      //   width: 20,
                      // ),
                      title: Row(
                        children: [
                          Text(
                            'PAN Verification',
                            style: GoogleFonts.roboto(
                              color: HexColor("#212121"),
                            ),
                          ),
                          panels.indexWhere((e) => e.expanded) > 5
                              ? SizedBox(
                                  height: 26,
                                  width: 40,
                                  child: Image.asset(
                                    'assets/check.png',
                                  ),
                                )
                              : SizedBox.shrink()
                        ],
                      ),
                    ),
                    expanded: buildPANVerification(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: HexColor('#ffffff'),
                    boxShadow: [
                      BoxShadow(
                        color: HexColor('#0a000000'),
                        blurRadius: 1.5,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: ExpandablePanel(
                    onTap: () {
                      panels[6].expanded = !panels[6].expanded;
                    },
                    controller: panels[6],
                    theme: ExpandableThemeData(
                      iconColor: HexColor("#0568a3"),
                    ),
                    header: ListTile(
                      // leading: Image.asset(
                      //   'images/family.png',
                      //   height: 20,
                      //   width: 20,
                      // ),
                      title: Row(
                        children: [
                          Text(
                            'Bank Account Details',
                            style: GoogleFonts.roboto(
                              color: HexColor("#212121"),
                            ),
                          ),
                          panels.indexWhere((e) => e.expanded) > 6
                              ? SizedBox(
                                  height: 26,
                                  width: 40,
                                  child: Image.asset(
                                    'assets/check.png',
                                  ),
                                )
                              : SizedBox.shrink()
                        ],
                      ),
                    ),
                    expanded: buildBankDetails(),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Widget buildBankDetails() => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
        ),
        child: Theme(
          data: Theme.of(context).copyWith(
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: MyColors.textBoxColor(),
              hintStyle: TextStyle(
                color: Colors.white,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  10.0,
                ),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          child: Form(
            key: bankDetailsFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: bankName, //account holder name
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter valid Bank Name';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    // agentDetails.emailID = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'Bank Name',
                  ),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: accountHolderName, //account holder name
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter valid Account Holder Name';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    // agentDetails.emailID = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'Account Holder Name',
                  ),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: accountNumber, //account number
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter valid Account Number';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    // agentDetails.emailID = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'Account Number',
                  ),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: ifscCode, //ifsc code
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter valid IFSC Code';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    // agentDetails.emailID = value;
                  },
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    hintText: 'IFSC Code',
                  ),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: address, //address
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter valid Address';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    // agentDetails.emailID = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'Location of Bank Branch',
                  ),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Checkbox(
                      activeColor: MyColors.yellowColor(),
                      value: sendEarnings,
                      onChanged: (value) {
                        setState(
                          () {
                            sendEarnings = value;
                          },
                        );
                      },
                    ),
                    Expanded(
                      child: Text(
                        "Send all my Earnings with InsiderLab Fintech Pvt. Ltd. in above mentioned account.",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "All your personal information and account details are safe with us.",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "For more details read our ",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launch(
                                "https://www.insiderlab.in/app-privacy-component");
                          },
                        text: "Privacy Policy.",
                        style: TextStyle(
                          color: Colors.blue[800],
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Checkbox(
                      activeColor: MyColors.yellowColor(),
                      value: termsAndConditions,
                      onChanged: (value) {
                        setState(
                          () {
                            termsAndConditions = value;
                          },
                        );
                      },
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "I have read and agree with the ",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  launch(
                                      "https://www.insiderlab.in/app-terms-component");
                                },
                              text: "Terms & Conditions.",
                              style: TextStyle(
                                color: Colors.blue[800],
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Checkbox(
                      activeColor: MyColors.yellowColor(),
                      value: servicePartnerAgreement,
                      onChanged: (value) {
                        setState(
                          () {
                            servicePartnerAgreement = value;
                          },
                        );
                      },
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "I have read and agree with the ",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) =>
                                              AppChannelPartner(agentName: fullName.text.trim())));
                                },
                              text: "Services Partner Agreement.",
                              style: TextStyle(
                                color: Colors.blue[800],
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FlatButton(
                      onPressed: () {
                        panels[5].expanded = true;
                        active(5);
                      },
                      child: Text("Back"),
                      color: MyColors.yellowColor(),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          10.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    FlatButton(
                      onPressed: () async {
                        FocusScopeNode currentFocus = FocusScope.of(context);

                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                        if (!bankDetailsFormKey.currentState.validate()) {
                          return;
                        }

                        setState(() {
                          loading = true;
                        });

                        List<String> aadhaarDocList = [];
                        if (aadhaarFrontImage != null &&
                            aadhaarBackImage != null) {
                          aadhaarDocList
                              .add(await uploadFile(aadhaarFrontImage));
                          aadhaarDocList
                              .add(await uploadFile(aadhaarBackImage));
                        }
                        for (var i = 0; i < aadhaarFiles.length; i++) {
                          aadhaarDocList.add(await uploadFile(aadhaarFiles[i]));
                        }
                        List<String> panDocList = [];
                        if (panFrontImage != null) {
                          panDocList.add(await uploadFile(panFrontImage));
                        }
                        for (var i = 0; i < panFiles.length; i++) {
                          panDocList.add(await uploadFile(panFiles[i]));
                        }
                        print(aadhaarDocList);
                        print(panDocList);
                        Map<String, String> registerReqJson = {
                          "name": fullName.text,
                          "email": email.text,
                          "password": passwordController.text,
                          "password_confirmation":
                              confirmPasswordController.text,
                          "location": city.text,
                          "aadhar_card": null,
                          "pan_card": null,
                          "mobile": mobileNumber.text,
                          'current_profession': currentProfession.text,
                          'employment_type': employmentType.text,
                          'work_experience': workExperience.text,
                          'employer_name': employeeName.text,
                          'financial_industry':
                              workedInFinancialSector ? "Yes" : "No",
                          'hold_gov_office': holdGovOffice ? "Yes" : "No",
                          'bank_name': bankName.text,
                          'account_holder_name': accountHolderName.text,
                          'account_number': accountNumber.text,
                          'ifsc_code': ifscCode.text,
                          'address': address.text,
                          "dob": dob.text.split("-").reversed.join("-"),
                          "gender": gender.text,
                          "whatsapp_number": whatsappNumber.text,
                        };
                        log("registerJson : $registerReqJson");
                        print("post");
                        String successJson = await callApi.callPostApi(
                            ApiConstants.BASE_URL +
                                ApiConstants.REGISTER_API +
                                '/' +
                                userId.toString(),
                            registerReqJson);
                        setState(() {
                          loading = false;
                        });
                        log(successJson);
                        if (json.decode(successJson)["error"] == 0) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) =>
                                      AgentCongratulationsScreen()),
                              (route) => false);
                          // showDialog(
                          //   barrierDismissible: false,
                          //   context: context,
                          //   builder: (context) {
                          //     return WillPopScope(
                          //       onWillPop: () async {
                          //         return false;
                          //       },
                          //       child: CupertinoAlertDialog(
                          //         title: Text("Registered Successfully"),
                          //         actions: [
                          //           TextButton(
                          //             onPressed: () {
                          //               Navigator.pop(context);
                          //               Navigator.pop(context);
                          //             },
                          //             child: Text(
                          //               "Login Now",
                          //               style: TextStyle(
                          //                 color: MyColors.darkBlue,
                          //               ),
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //     );
                          //   },
                          // );
                        }
                      },
                      child: Text("Done"),
                      color: MyColors.yellowColor(),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          10.0,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      );

  Widget buildPANVerification() => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Select option to upload ",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(
                    text: "PAN Card",
                    style: TextStyle(
                      color: Colors.black,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            FlatButton(
              height: 60,
              minWidth: 200,
              onPressed: () async {
                if (panFiles.length >= 1) {
                  showDialog(
                    context: context,
                    builder: (context) => CupertinoAlertDialog(
                      title: Text(
                          "You can add only 1 file, remove file to add new one."),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Okay"),
                        ),
                      ],
                    ),
                  );
                  return;
                }
                if (panFrontImage != null) {
                  showDialog(
                    context: context,
                    builder: (context) => CupertinoAlertDialog(
                      title: Text(
                          "You will lose captured image, if you use this option"),
                      actions: [
                        TextButton(
                          onPressed: () async {
                            Navigator.pop(context);
                            panFrontImage = null;
                            File temp = File((await FilePicker.platform.pickFiles(type: FileType.any)).files[0].path);
                            if (temp != null) {
                              panFiles.add(temp);
                            }
                            setState(() {});
                          },
                          child: Text("Proceed"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            return;
                          },
                          child: Text("Cancel"),
                        ),
                      ],
                    ),
                  );
                } else {
                  panFrontImage = null;
                  File temp = File((await FilePicker.platform.pickFiles(type: FileType.any)).files[0].path);
                  if (temp != null) {
                    panFiles.add(temp);
                  }
                }
                setState(() {});
              },
              child: Text("Upload PAN"),
              color: MyColors.yellowColor(),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  10.0,
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              "Upload e-verified copy or multiple soft copies (Front) in any format here. You can review your uploads below.",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              "Document Quality: Make sure to upload coloured scanned copy (Front). Do not upload a photocopy.",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            ListView.separated(
              separatorBuilder: (context, i) => SizedBox(
                height: 8.0,
              ),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, i) => Row(
                children: [
                  Expanded(
                    child: Text(
                      panFiles[i].path.split("/").last,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                      icon: Icon(Icons.cancel),
                      onPressed: () {
                        panFiles.removeAt(i);
                        setState(() {});
                      })
                ],
              ),
              itemCount: panFiles.length,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "OR, you may take picture of PAN Card below",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            FlatButton(
              height: 60,
              minWidth: 200,
              onPressed: () async {
                if (panFrontImage != null) {
                  showDialog(
                    context: context,
                    builder: (context) => CupertinoAlertDialog(
                      title: Text("Capture Image Again ??"),
                      actions: [
                        TextButton(
                          onPressed: () async {
                            Navigator.pop(context);
                            panFiles = [];
                            panFrontImage = File((await ImagePicker.platform.pickImage(
                                    source: ImageSource.camera))
                                .path);
                            setState(() {});
                          },
                          child: Text("Proceed"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            return;
                          },
                          child: Text("Cancel"),
                        ),
                      ],
                    ),
                  );
                } else if (panFiles.length > 0) {
                  showDialog(
                    context: context,
                    builder: (context) => CupertinoAlertDialog(
                      title: Text(
                          "You will lose picked PAN document, if you use this option"),
                      actions: [
                        TextButton(
                          onPressed: () async {
                            Navigator.pop(context);
                            panFiles = [];
                            panFrontImage = File((await ImagePicker.platform.pickImage(
                                    source: ImageSource.camera))
                                .path);
                            setState(() {});
                          },
                          child: Text("Proceed"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            return;
                          },
                          child: Text("Cancel"),
                        ),
                      ],
                    ),
                  );
                } else {
                  panFiles = [];
                  panFrontImage = File(
                      (await ImagePicker.platform.pickImage(source: ImageSource.camera))
                          .path);
                  setState(() {});
                }
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.camera_alt,
                    color: MyColors.yellowColor(),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    "Take Photo of PAN",
                    style: TextStyle(
                      color: MyColors.yellowColor(),
                    ),
                  ),
                ],
              ),
              color: MyColors.backgroundColor(),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  10.0,
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            panFrontImage == null
                ? SizedBox.shrink()
                : Text(
                    panFrontImage.path.split("/").last,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlatButton(
                  onPressed: () {
                    panels[4].expanded = true;
                    active(4);
                  },
                  child: Text("Back"),
                  color: MyColors.yellowColor(),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      10.0,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                FlatButton(
                  onPressed: () async {
                    if (panFiles.length == 0 && panFrontImage == null) {
                      showDialog(
                        context: context,
                        builder: (context) => CupertinoAlertDialog(
                          title: Text(
                              "You need to select a file or capture front image to proceed further"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Okay"),
                            ),
                          ],
                        ),
                      );
                      return;
                    }
                    panels[6].expanded = true;
                    active(6);
                  },
                  child: Text("Next"),
                  color: MyColors.yellowColor(),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      10.0,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      );

  Widget buildAadhaarVerification() => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Select option to upload ",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(
                    text: "AADHAAR",
                    style: TextStyle(
                      color: Colors.black,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            FlatButton(
              height: 60,
              minWidth: 200,
              onPressed: () async {
                if (aadhaarFiles.length >= 1) {
                  showDialog(
                    context: context,
                    builder: (context) => CupertinoAlertDialog(
                      title: Text(
                          "You can add only 1 file, remove file to add new one."),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Okay"),
                        ),
                      ],
                    ),
                  );
                  return;
                }
                if (aadhaarFrontImage != null || aadhaarBackImage != null) {
                  showDialog(
                    context: context,
                    builder: (context) => CupertinoAlertDialog(
                      title: Text(
                          "You will lose captured images, if you use this option"),
                      actions: [
                        TextButton(
                          onPressed: () async {
                            Navigator.pop(context);
                            aadhaarFrontImage = null;
                            aadhaarBackImage = null;
                            File temp = File((await FilePicker.platform.pickFiles(type: FileType.any)).files[0].path);
                            if (temp != null) {
                              aadhaarFiles.add(temp);
                            }
                            setState(() {});
                          },
                          child: Text("Proceed"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            return;
                          },
                          child: Text("Cancel"),
                        ),
                      ],
                    ),
                  );
                } else {
                  aadhaarFrontImage = null;
                  aadhaarBackImage = null;
                  File temp = File((await FilePicker.platform.pickFiles(type: FileType.any)).files[0].path);
                  if (temp != null) {
                    aadhaarFiles.add(temp);
                  }
                }
                setState(() {});
              },
              child: Text("Upload Aadhaar"),
              color: MyColors.yellowColor(),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  10.0,
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              "Upload e-verified copy or multiple soft copies (Front & Back) in any format here. You can review your uploads below.",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              "Document Quality: Make sure to upload coloured scanned copy (Front & Back). Do not upload a photocopy.",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            ListView.separated(
              separatorBuilder: (context, i) => SizedBox(
                height: 8.0,
              ),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, i) => Row(
                children: [
                  Expanded(
                    child: Text(
                      aadhaarFiles[i].path.split("/").last,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                      icon: Icon(Icons.cancel),
                      onPressed: () {
                        aadhaarFiles.removeAt(i);
                        setState(() {});
                      }),
                ],
              ),
              itemCount: aadhaarFiles.length,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "OR, you may take picture of Aadhaar below",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            FlatButton(
              height: 60,
              minWidth: 200,
              onPressed: () async {
                if (aadhaarFrontImage != null) {
                  showDialog(
                    context: context,
                    builder: (context) => CupertinoAlertDialog(
                      title: Text("Capture Image Again ??"),
                      actions: [
                        TextButton(
                          onPressed: () async {
                            Navigator.pop(context);
                            aadhaarFiles = [];
                            aadhaarFrontImage = File(
                                (await ImagePicker.platform.pickImage(
                                        source: ImageSource.camera))
                                    .path);
                            setState(() {});
                          },
                          child: Text("Proceed"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            return;
                          },
                          child: Text("Cancel"),
                        ),
                      ],
                    ),
                  );
                } else if (aadhaarFiles.length > 0) {
                  showDialog(
                    context: context,
                    builder: (context) => CupertinoAlertDialog(
                      title: Text(
                          "You will lose picked aadhaar documents, if you use this option"),
                      actions: [
                        TextButton(
                          onPressed: () async {
                            Navigator.pop(context);
                            aadhaarFiles = [];
                            aadhaarFrontImage = File(
                                (await ImagePicker.platform.pickImage(
                                        source: ImageSource.camera))
                                    .path);
                            setState(() {});
                          },
                          child: Text("Proceed"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            return;
                          },
                          child: Text("Cancel"),
                        ),
                      ],
                    ),
                  );
                } else {
                  aadhaarFiles = [];
                  aadhaarFrontImage = File(
                      (await ImagePicker.platform.pickImage(source: ImageSource.camera))
                          .path);
                  setState(() {});
                }
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.camera_alt,
                    color: MyColors.yellowColor(),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    "Take Photo of Front",
                    style: TextStyle(
                      color: MyColors.yellowColor(),
                    ),
                  ),
                ],
              ),
              color: MyColors.backgroundColor(),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  10.0,
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            aadhaarFrontImage == null
                ? SizedBox.shrink()
                : Text(
                    aadhaarFrontImage.path.split("/").last,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
            SizedBox(
              height: 20,
            ),
            FlatButton(
              height: 60,
              minWidth: 200,
              onPressed: () async {
                if (aadhaarBackImage != null) {
                  showDialog(
                    context: context,
                    builder: (context) => CupertinoAlertDialog(
                      title: Text("Capture Image Again ??"),
                      actions: [
                        TextButton(
                          onPressed: () async {
                            Navigator.pop(context);
                            aadhaarFiles = [];
                            aadhaarBackImage = File(
                                (await ImagePicker.platform.pickImage(
                                        source: ImageSource.camera))
                                    .path);
                            setState(() {});
                          },
                          child: Text("Proceed"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            return;
                          },
                          child: Text("Cancel"),
                        ),
                      ],
                    ),
                  );
                } else if (aadhaarFiles.length > 0) {
                  showDialog(
                    context: context,
                    builder: (context) => CupertinoAlertDialog(
                      title: Text(
                          "You will lose picked aadhaar documents, if you use this option"),
                      actions: [
                        TextButton(
                          onPressed: () async {
                            Navigator.pop(context);
                            aadhaarFiles = [];
                            aadhaarBackImage = File(
                                (await ImagePicker.platform.pickImage(
                                        source: ImageSource.camera))
                                    .path);
                            setState(() {});
                          },
                          child: Text("Proceed"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            return;
                          },
                          child: Text("Cancel"),
                        ),
                      ],
                    ),
                  );
                } else {
                  aadhaarFiles = [];
                  aadhaarBackImage = File(
                      (await ImagePicker.platform.pickImage(source: ImageSource.camera))
                          .path);
                  setState(() {});
                }
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.camera_alt,
                    color: MyColors.yellowColor(),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    "Take Photo of Back",
                    style: TextStyle(
                      color: MyColors.yellowColor(),
                    ),
                  ),
                ],
              ),
              color: MyColors.backgroundColor(),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  10.0,
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            aadhaarBackImage == null
                ? SizedBox.shrink()
                : Text(
                    aadhaarBackImage.path.split("/").last,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlatButton(
                  onPressed: () {
                    panels[3].expanded = true;
                    active(3);
                  },
                  child: Text("Back"),
                  color: MyColors.yellowColor(),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      10.0,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                FlatButton(
                  onPressed: () {
                    if (aadhaarFiles.length == 1 ||
                        (aadhaarFrontImage != null &&
                            aadhaarBackImage != null)) {
                      panels[5].expanded = true;
                      active(5);
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => CupertinoAlertDialog(
                          title: Text(
                              "You need to select a file or capture front and back image to proceed further"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Okay"),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  child: Text("Next"),
                  color: MyColors.yellowColor(),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      10.0,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      );

  Widget dropDown(List<String> list, String hint,
      {Function(String) onSaveValue}) {
    var selected;
    return DropdownButtonFormField<String>(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      decoration: InputDecoration(
        // labelText: hint,
        filled: true,
        fillColor: MyColors.textBoxColor(),
        labelStyle: TextStyle(
          color: Colors.white,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            10.0,
          ),
          borderSide: BorderSide.none,
        ),
      ),

      //hint: new Text(hint),
      validator: (value) {
        if (value == null) {
          return 'Please select the require field';
        } else
          return null;
      },
      dropdownColor: GetColor.darkgray_background,
      value: selected,
      items: list
          .map((label) => label == "Cheque"
              ? DropdownMenuItem(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Divider(
                        color: Colors.white,
                        height: 1,
                      ),
                    ],
                  ),
                  value: label,
                )
              : DropdownMenuItem(
                  child: Text(
                    label,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  value: label,
                ))
          .toList(),
      onChanged: (value) {
        setState(() => selected = value);
        return onSaveValue(value);
      },
    );
  }

  Widget buildEmploymentDetails() => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
        ),
        child: Theme(
          data: Theme.of(context).copyWith(
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: MyColors.textBoxColor(),
              hintStyle: TextStyle(
                color: Colors.white,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  10.0,
                ),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          child: Form(
            key: employmentDetailsFormKey,
            child: Column(
              children: [
                TextFormField(
                  controller: currentProfession, //current profession
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter valid Current Profession (Occupation)';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    // agentDetails.emailID = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'Your Current Profession (Occupation) ?',
                  ),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                dropDown([
                  'Salaried',
                  'Self Employed',
                  'Salaried + Self-Employed',
                ], 'Select Employment Type', onSaveValue: (value) {
                  employmentType.text = value;
                  print(employmentType.text);
                }),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: workExperience, //work experience
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter valid Work Experience';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    // agentDetails.emailID = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'Total Work Experience ?',
                  ),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: employeeName, //employee name
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter valid Employee`s Name';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    // agentDetails.emailID = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter Employer / Company Name ?',
                  ),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "I have worked in Financial industry / services before.",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    CupertinoSwitch(
                      activeColor: MyColors.yellowColor(),
                      value: workedInFinancialSector,
                      onChanged: (value) {
                        setState(
                          () {
                            workedInFinancialSector = value;
                          },
                        );
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "My direct family member or I don't hold any Gov. Office ?",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    CupertinoSwitch(
                      activeColor: MyColors.yellowColor(),
                      value: holdGovOffice,
                      onChanged: (value) {
                        setState(
                          () {
                            holdGovOffice = value;
                          },
                        );
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "NOTE: ",
                        style: TextStyle(
                          color: Colors.grey[600],
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      TextSpan(
                        text:
                            "Certain companies does not allow their employers to create a business, or create another source of income. So do check with your employer for their employee policy.",
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "REMEMBER: ",
                        style: TextStyle(
                          color: Colors.grey[600],
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      TextSpan(
                        text:
                            // "your are not working for InsiderLab. rather InsiderLab's App is a tool for you to Launch & Run your financial services business or operate individually.",
                            "All users of InsiderLab Fintech Pvt. Ltd are not employees of the company. Insiderlab is a financial services aggregator company, and its users are aggregating the services to earn referral incomes.",
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FlatButton(
                      onPressed: () {
                        panels[2].expanded = true;
                        active(2);
                      },
                      child: Text("Back"),
                      color: MyColors.yellowColor(),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          10.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    FlatButton(
                      onPressed: () {
                        panels[4].expanded = true;
                        active(4);
                        FocusScopeNode currentFocus = FocusScope.of(context);

                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                      },
                      child: Text("Next"),
                      color: MyColors.yellowColor(),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          10.0,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      );

  Widget buildSetupProfile() => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
        ),
        child: Theme(
          data: Theme.of(context).copyWith(
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: MyColors.textBoxColor(),
              hintStyle: TextStyle(
                color: Colors.white,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  10.0,
                ),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          child: Form(
            key: setupProfileFormKey,
            child: Column(
              children: [
                TextFormField(
                  controller: fullName, //full name
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter valid Full Name';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    // agentDetails.emailID = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'Full Name (as in KYC)',
                  ),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: mobileNumber, //mobile number
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter valid Mobile Number';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    // agentDetails.emailID = value;
                  },
                  onChanged: (value) {
                    if (isSameWhatsappNumber) {
                      setState(() {
                        whatsappNumber.text = value;
                      });
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'Mobile Number',
                  ),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "I have same number on WhatsApp.",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    CupertinoSwitch(
                      activeColor: MyColors.yellowColor(),
                      value: isSameWhatsappNumber,
                      onChanged: (value) {
                        setState(
                          () {
                            isSameWhatsappNumber = value;
                            if (value) whatsappNumber.text = mobileNumber.text;
                          },
                        );
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  readOnly: isSameWhatsappNumber,
                  controller: whatsappNumber, //whatsapp number
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter valid WhatsApp Number';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    // agentDetails.emailID = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'WhatsApp Number',
                  ),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: city, //city
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter valid Enter your City';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    // agentDetails.emailID = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter your City',
                  ),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () async {
                    FocusScopeNode currentFocus = FocusScope.of(context);

                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                    DateTime selectedDate = await showDatePicker(
                        context: context,
                        initialDate: dob.text.isEmpty
                            ? DateTime.now()
                            : DateTime.parse(
                                dob.text.split("-").reversed.join("-")),
                        firstDate: DateTime.parse("1900-01-01"),
                        lastDate: DateTime.parse("2100-01-01"));
                    if (selectedDate != null) {
                      dob.text = DateFormat('dd-MM-yyyy').format(selectedDate);
                    }
                    setState(() {});
                  },
                  child: AbsorbPointer(
                    child: TextFormField(
                      readOnly: true,
                      controller: dob, //date of birth
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter valid Date of Birth';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        // agentDetails.emailID = value;
                      },
                      decoration: InputDecoration(
                        hintText: 'Date of Birth',
                      ),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    FocusScopeNode currentFocus = FocusScope.of(context);

                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                    showDialog(
                      context: context,
                      builder: (context) => CupertinoAlertDialog(
                        title: Text("Select Gender"),
                        content: Material(
                          color: Colors.transparent,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                height: 10.0,
                              ),
                              ListTile(
                                onTap: () {
                                  gender.text = "Male";
                                  Navigator.pop(context);
                                },
                                tileColor:
                                    MyColors.backgroundColor().withOpacity(0.1),
                                dense: false,
                                visualDensity: VisualDensity.compact,
                                contentPadding: const EdgeInsets.all(0.0),
                                title: Text(
                                  "Male",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(
                                height: 8.0,
                              ),
                              ListTile(
                                onTap: () {
                                  gender.text = "Female";
                                  Navigator.pop(context);
                                },
                                tileColor:
                                    MyColors.backgroundColor().withOpacity(0.1),
                                dense: false,
                                visualDensity: VisualDensity.compact,
                                contentPadding: const EdgeInsets.all(0.0),
                                title: Text(
                                  "Female",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(
                                height: 8.0,
                              ),
                              ListTile(
                                onTap: () {
                                  gender.text = "Others";
                                  Navigator.pop(context);
                                },
                                tileColor:
                                    MyColors.backgroundColor().withOpacity(0.1),
                                dense: false,
                                visualDensity: VisualDensity.compact,
                                contentPadding: const EdgeInsets.all(0.0),
                                title: Text(
                                  "Others",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  child: AbsorbPointer(
                    child: TextFormField(
                      readOnly: true,
                      controller: gender, //gender
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter valid Gender';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        // agentDetails.emailID = value;
                      },
                      decoration: InputDecoration(
                        hintText: 'Gender',
                      ),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FlatButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => CupertinoAlertDialog(
                            title: Text(
                                "Your email is registered with us, if you go back then you need to use new email for verification."),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  panels[0].expanded = true;
                                  active(0);
                                },
                                child: Text("Proceed"),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Cancel"),
                              ),
                            ],
                          ),
                        );
                      },
                      child: Text("Back"),
                      color: MyColors.yellowColor(),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          10.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    FlatButton(
                      onPressed: () async {
                        if (setupProfileFormKey.currentState.validate()) {
                          panels[3].expanded = true;
                          active(3);
                          FocusScopeNode currentFocus = FocusScope.of(context);

                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                        }
                      },
                      child: Text("Next"),
                      color: MyColors.yellowColor(),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          10.0,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      );

  Widget buildOTPVerification() => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
        ),
        child: Theme(
          data: Theme.of(context).copyWith(
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: MyColors.textBoxColor(),
              hintStyle: TextStyle(
                color: Colors.white,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  10.0,
                ),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          child: Form(
            key: otpVerificationFormKey,
            child: Column(
              children: [
                ValueListenableBuilder<int>(
                    valueListenable: time,
                    builder: (BuildContext context, int value, Widget child) {
                      return RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  "We Sent you an Email OTP for activation. Please be sure to check your spam folder too. Didn't get one? We can ",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  if (time.value == 0) {
                                    sendOTP('true');
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        ShowSnackBar("OTP Resent")
                                            .showSuccess());
                                  }
                                },
                              text: "send another.",
                              style: value == 0
                                  ? TextStyle(
                                      color: Colors.blue[800],
                                      decoration: TextDecoration.underline,
                                    )
                                  : TextStyle(
                                      color: Colors.black,
                                    ),
                            ),
                          ],
                        ),
                      );
                    }),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  controller: otp, //otp
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'OTP',
                  ),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ValueListenableBuilder<int>(
                        valueListenable: time,
                        builder:
                            (BuildContext context, int value, Widget child) {
                          return Text(
                            value.toString() + " Seconds",
                            style: TextStyle(color: Colors.black),
                          );
                        }),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FlatButton(
                      onPressed: () {
                        panels[0].expanded = true;
                        active(0);
                      },
                      child: Text("Back"),
                      color: MyColors.yellowColor(),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          10.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    FlatButton(
                      onPressed: () async {
                        print('Mobile number : ${mobileNumber.text}');
                        //call verify-otp api
                        String url =
                            ApiConstants.BASE_URL + ApiConstants.VERIFY_OTP_API;
                        Map<String, String> requestJson = {
                          'mobile': mobileNumber.text,
                          'email': email.text,
                          'otp': otp.text,
                          'type': 'agent'
                        };
                        String resJson =
                            await callApi.callPostApi(url, requestJson);
                        print('ResJson : $resJson');
                        int error = json.decode(resJson)['error'];
                        print('ResJson Error : $error');
                        // conditions for validating
                        if (error > 0) {
                          isOtpVerified = false;
                          ScaffoldMessenger.of(context).showSnackBar(
                              ShowSnackBar("OTP Does Not Match").showError());
                          setState(() {
                            hasError = true;
                          });
                        } else {
                          setState(
                            () {
                              isOtpVerified = true;
                              hasError = false;
                              ScaffoldMessenger.of(context).showSnackBar(
                                  ShowSnackBar("OTP verified").showSuccess());
                              userId = json.decode(resJson)['data']['id'];
                            },
                          );

                          if (isOtpVerified && userId > 0) {
                            panels[2].expanded = true;
                            active(2);
                            otp.text = null;
                            setState(() {});
                            FocusScopeNode currentFocus =
                                FocusScope.of(context);

                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                          }
                        }
                      },
                      child: Text("Verify"),
                      color: MyColors.yellowColor(),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          10.0,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      );

  Widget buildGetStarted() => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
        ),
        child: Theme(
          data: Theme.of(context).copyWith(
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: MyColors.textBoxColor(),
              hintStyle: TextStyle(
                color: Colors.white,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  10.0,
                ),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          child: Form(
            key: getStartedFormKey,
            child: Column(
              children: [
                TextFormField(
                  controller: email, //email
                  validator: (value) {
                    if (!EmailValidator.validate(value)) {
                      return 'Please enter valid Email';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    agentDetails.emailID = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'Email',
                  ),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  obscureText: true,
                  controller: passwordController, //passwordController
                  validator: (value) {
                    password = value;
                    if (value.isEmpty || value.length < 6) {
                      return 'Please Enter At-least 6 Characters';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    agentDetails.password = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'Create New Password',
                  ),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller:
                      confirmPasswordController, //confirmPasswordController
                  obscureText: true,
                  validator: (value) {
                    confirmPassword = value;
                    if (value != passwordController.text) {
                      return 'Password does not Matched';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    agentDetails.confirmPassword = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'Confirm Password',
                  ),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                FlatButton(
                  onPressed: () async {
                    if (getStartedFormKey.currentState.validate()) {
                      if (await sendOTP('false')) {
                        active(1);
                        FocusScopeNode currentFocus = FocusScope.of(context);

                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                      }
                    }
                  },
                  child: Text("Next"),
                  color: MyColors.yellowColor(),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      10.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      );

  Future<bool> sendOTP(String resend) async {
    try {
      String url = ApiConstants.BASE_URL + ApiConstants.SEND_OTP_API;
      Map<String, String> requestMap = {
        'email': email.text,
        'type': 'agent',
        'resend': resend
      };
      String sendOTPResponse =
          await callApi.callPostApi(url, requestMap, flag: 0);
      if (json.decode(sendOTPResponse)['error'] == 1) {
        ScaffoldMessenger.of(context)
            .showSnackBar(ShowSnackBar("Email already verified").showError());
        return false;
      }
      time.value = 100;
      startTimer();
      return true;
    } catch (e) {
      print("Exception caught calling send otp api $e");
      return false;
    }
  }

  Future<String> uploadFile(File file) async {
    print(file.path);
    var res = await obj.uploadFile(file, null, null, userId: userId);
    print('res $res');

    if (res != null && json.decode(res)['error'] != 1) {
      print('res $res');
      return json.decode(res)["data"]["public_path"];
    }
    return null;
  }

  final ValueNotifier<int> time = ValueNotifier<int>(100);
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
