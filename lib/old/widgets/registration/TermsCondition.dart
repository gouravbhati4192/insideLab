import 'dart:convert';
import 'package:financial_freedom/old/Home/app-channel-partner.dart';
import 'package:financial_freedom/old/Model/Agent.dart';
import 'package:financial_freedom/old/widgets/common/ApiConstants.dart';
import 'package:financial_freedom/old/widgets/common/BottomNavigationWidgets.dart';
import 'package:financial_freedom/old/widgets/common/CallApi.dart';
import 'package:financial_freedom/old/widgets/common/ShowSnackBar.dart';
import 'package:financial_freedom/old/widgets/common/TextLink.dart';
import 'package:financial_freedom/old/widgets/registration/registration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TermsCondition extends StatefulWidget {
  final String title;
  final Agent agent;

  TermsCondition({Key key, this.title, this.agent}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _TermsConditionState();
}

bool _termsAndConditionCheck = false;
bool _userAgreementCheck = false;

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class _TermsConditionState extends State<TermsCondition> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(15),
        child: ListView(
          children: [
            Center(
              child: Text(
                'Terms & Conditions',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Card(
              color: Colors.indigo.shade50,
              elevation: 3.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Row(
                children: [
                  Checkbox(
                    value: _termsAndConditionCheck,
                    onChanged: (bool value) {
                      if (_termsAndConditionCheck == false) {
                        setState(() {
                          _termsAndConditionCheck = true;
                        });
                      } else if (_termsAndConditionCheck == true) {
                        setState(() {
                          _termsAndConditionCheck = false;
                        });
                      }
                    },
                  ),
                  Expanded(
                    child: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: 'I have read the ',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.grey[700],
                          ),
                        ),
                        WidgetSpan(
                          child: TextLink(
                            textMsg: 'terms & condition',
                            url:
                                "https://www.insiderlab.in/app-terms-component.html",
                          ),
                        ),
                        TextSpan(
                          text: ' and I agree to it.',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.grey[700],
                          ),
                        ),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              color: Colors.indigo.shade50,
              elevation: 3.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Row(
                children: [
                  Checkbox(
                    value: _userAgreementCheck,
                    onChanged: (bool value) {
                      if (_userAgreementCheck == false) {
                        setState(() {
                          _userAgreementCheck = true;
                        });
                      } else if (_userAgreementCheck == true) {
                        setState(() {
                          _userAgreementCheck = false;
                        });
                      }
                    },
                  ),
                  Expanded(
                    child: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: 'I have read the ',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.grey[700],
                          ),
                        ),
                        TextSpan(
                          text: 'user & service agreement',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => AppChannelPartner(),
                                ),
                              );
                            },
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.blue[700],
                          ),
                        ),
                        TextSpan(
                          text: ' and I agree to it.',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.grey[700],
                          ),
                        ),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationWidgets(
        onPressedNext: (BuildContext btncontext) {
          onNextClick(btncontext, widget.agent);
        },
        onPressedCancel: (BuildContext buildContext) {
          Navigator.pop(buildContext);
        },
        nextButtonName: 'Register',
        cancelButtonName: 'Cancel',
      ),
    );
  }

  onNextClick(BuildContext buildContext, Agent agent) {
    if (_termsAndConditionCheck && _userAgreementCheck) {
      apiCall(agent);
      scaffoldKey.currentState.showSnackBar(
        ShowSnackBar('Registration Completed').showSuccess(),
      );
      Future.delayed(Duration(seconds: 2), () {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
      });
    } else {
      scaffoldKey.currentState.showSnackBar(ShowSnackBar(
              'Please read the Terms and Condition and click given checkbox')
          .showError());
    }
  }

  Future<void> apiCall(Agent agent) async {
    Map<String, dynamic> questionList = agent.questionListJson;
    print('Question list ${jsonEncode(questionList)}');
    questionList['1']['answer'] = agent.ans1;
    print('Answer 1${agent.ans1}');
    questionList['2']['answer'] = agent.ans2;
    questionList['3']['answer'] = agent.ans3;
    questionList['4']['answer'] = agent.ans4;
    questionList['5']['answer'] = agent.ans5;
    questionList['6']['answer'] = agent.ans6;

    Map<String, dynamic> reqJson = {
      'user_id': agent.uid,
      'questions': questionList,
      "bank_details": {
        "bank_name": agent.bankName,
        "account_name": agent.accountName,
        "account_number": agent.accountNumber,
        "ifsc_code": agent.ifscCode,
      },
      "terms_conditions": {
        "data_privacy": "yes",
        "compliances": "yes",
        "duties_consumer_protection": "yes",
        "training_requirements": "yes"
      }
    };

    print('Register json : ${reqJson}');
    CallApi callApi = new CallApi();
    String reply = await callApi.callPostApi(
        ApiConstants.BASE_URL + ApiConstants.SAVE_LISTING, reqJson);
    print("FINAL : $reply");
  }
}
