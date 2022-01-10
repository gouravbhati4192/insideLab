import 'dart:convert';
import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:financial_freedom/old/Model/Agent.dart';
import 'package:financial_freedom/old/Model/OTPScreenArgs.dart';
import 'package:financial_freedom/old/widgets/common/ApiConstants.dart';
import 'package:financial_freedom/old/widgets/common/BottomNavigationWidgets.dart';
import 'package:financial_freedom/old/widgets/common/CallApi.dart';
import 'package:financial_freedom/old/widgets/common/ShowSnackBar.dart';
import 'package:financial_freedom/old/widgets/common/UploadDocument.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class RegisterWithUs extends StatefulWidget {
  final String title;
  RegisterWithUs({Key key, this.title}) : super(key: key);
  @override
  _RegisterWithUs createState() => _RegisterWithUs();
}

class _RegisterWithUs extends State<RegisterWithUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: RegistrationForm(),
      ),
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
    );
  }
}

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

final _formKey = GlobalKey<FormState>();
String password, confirmPassword;
bool is_adharUpload = false;
bool is_PanUpload = false;
Agent agentDetails = new Agent();

class _RegistrationFormState extends State<RegistrationForm> {
  TextEditingController firstName = new TextEditingController();
  TextEditingController lastName = new TextEditingController();
  TextEditingController location = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController mobile = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();
  UploadDocument obj = new UploadDocument();
  File _aadharCard;
  File _panCard;
  var result;

  Future<bool> uploadImage(String docType) async {
    File image = File((await FilePicker.platform.pickFiles(type: FileType.image)).files[0].path);
    var res = await obj.uploadFile(image,"","");
    if (res != null) {
      print('res $res');
      setState(() {
        result = json.decode(res)["data"];
        if (docType == 'aadhar') {
          _aadharCard = image;
        } else {
          _panCard = image;
        }
      });
      return true;
    } else
      return false;
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    firstName.dispose();
    lastName.dispose();
    location.dispose();
    email.dispose();
    mobile.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    is_PanUpload = false;
    is_adharUpload = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(10),
            child: Text(
              'Register With Us',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              controller: firstName, //firstName
              validator: (value) {
                if (value.isEmpty || value.length < 2) {
                  return 'Please enter valid First Name';
                } else {
                  return null;
                }
              },
              onSaved: (value) {
                agentDetails.firstName = value;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                labelText: 'First Name',
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              controller: lastName, //lastName
              validator: (value) {
                if (value.isEmpty || value.length < 2) {
                  return 'Please enter valid Last Name';
                } else {
                  return null;
                }
              },
              onSaved: (value) {
                agentDetails.lastName = value;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                labelText: 'Last Name',
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              controller: location, //location
              validator: (value) {
                if (value.isEmpty || value.length < 3) {
                  return 'Please enter valid Location';
                } else {
                  return null;
                }
              },
              onSaved: (value) {
                agentDetails.location = value;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                labelText: 'Location',
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              controller: email, //email
              validator: (value) {
                if (!EmailValidator.validate(value)) {
                  return 'Please enter valid Email ID';
                } else {
                  return null;
                }
              },
              onSaved: (value) {
                agentDetails.emailID = value;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                labelText: 'Email ID',
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              controller: mobile, //mobile
              keyboardType: TextInputType.phone,
              validator: (value) => validateMobile(context, value),
              onSaved: (value) {
                agentDetails.mobileNumber = value;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                labelText: 'Mobile Number',
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              obscureText: true,
              controller: passwordController, //passwordController
              validator: (value) {
                password = value;
                if (value.isEmpty || value.length < 6) {
                  return 'Please enter valid password';
                }
                return null;
              },
              onSaved: (value) {
                agentDetails.password = value;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                labelText: 'Password',
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              controller: confirmPasswordController, //confirmPasswordController
              obscureText: true,
              validator: (value) {
                confirmPassword = value;
                if (value.isEmpty || value.length < 6) {
                  return 'Please enter valid confirm password';
                }
                return null;
              },
              onSaved: (value) {
                agentDetails.confirmPassword = value;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                labelText: 'Confirm Password',
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                flex: 8,
                child: Container(
                  height: 50,
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Builder(
                    builder: (context) => RaisedButton(
                      shape: StadiumBorder(),
                      textColor: Colors.white,
                      color: Theme.of(context).primaryColor,
                      child: Text('Upload Your Aadhar'),
                      onPressed: () async {
                        print("RESULT data : $result");
                        if (await uploadImage('aadhar')) {
                          setState(() {
                            is_adharUpload = true;
                            agentDetails.aadharCard = result['file'];
                          });
                          scaffoldKey.currentState.showSnackBar(
                              ShowSnackBar('Aadhar uploaded').showSuccess());
                        } else {
                          is_adharUpload = false;
                        }
                        print('Adhar Upload: $is_adharUpload');
                      },
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  height: 50,
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Container(
                    child: Center(
                        child: !is_adharUpload || _aadharCard == null
                            ? Text('No Image Uploaded')
                            : Image.file(_aadharCard)),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 8,
                child: Container(
                  height: 50,
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Builder(
                    builder: (context) => RaisedButton(
                      shape: StadiumBorder(),
                      textColor: Colors.white,
                      color: Theme.of(context).primaryColor,
                      child: Text('Upload Your PAN'),
                      onPressed: () async {
                        if (await uploadImage('pan')) {
                          setState(() {
                            is_PanUpload = true;
                            agentDetails.panCard = result['file'];

                            print(
                                'PAN card file link : ${agentDetails.panCard}');
                          });
                          scaffoldKey.currentState.showSnackBar(
                              ShowSnackBar('PAN Card uplodaed').showSuccess());
                        } else {
                          is_PanUpload = false;
                        }
                        print('PAN Card Upload: $is_PanUpload');
                      },
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  height: 50,
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Container(
                    child: Center(
                        child: !is_PanUpload || _panCard == null
                            ? Text('No Image Uploaded')
                            : Image.file(_panCard)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

String validateMobile(BuildContext context, String mobileNumber) {
  Pattern pattern = r'^[6-9]\d{9}$';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(mobileNumber)) {
    return 'Enter valid Mobile Number';
  } else {
    return null;
  }
}

void onNextClick(BuildContext buildContext) {
  if (_formKey.currentState.validate()) {
    if (password != confirmPassword) {
      scaffoldKey.currentState.showSnackBar(
          ShowSnackBar('Password and Confirm Password should be same')
              .showError());
    } else if (!(is_adharUpload && is_PanUpload)) {
      scaffoldKey.currentState.showSnackBar(
          ShowSnackBar('Please Upload require Documents').showError());
    } else {
      _formKey.currentState.save();
      OTPScreenArgs args = new OTPScreenArgs(
          '/conflictOfInterest', 'agent', '', '', agentDetails.emailID);
      Navigator.pushNamed(buildContext, '/otpScreen', arguments: args);
    }
  } else {
    scaffoldKey.currentState
        .showSnackBar(ShowSnackBar('Please Enter required fields').showError());
  }
}
