import 'dart:convert';

import 'package:financial_freedom/old/Model/customerData.dart';
import 'package:financial_freedom/old/widgets/common/ApiConstants.dart';
import 'package:financial_freedom/old/widgets/common/CallApi.dart';
import 'package:financial_freedom/old/widgets/common/ShowSnackBar.dart';
import 'package:financial_freedom/old/widgets/common/colors.dart';
import 'package:financial_freedom/old/widgets/common/routes.dart';
import 'package:financial_freedom/old/widgets/common/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class BasicDetailsCustomer extends StatefulWidget {
  final Customer customerData;
  BasicDetailsCustomer({this.customerData});

  @override
  _BasicDetailsCustomerState createState() => _BasicDetailsCustomerState();
}

class _BasicDetailsCustomerState extends State<BasicDetailsCustomer> {
  TextEditingController _pincode = new TextEditingController();
  TextEditingController _desiredLoan = new TextEditingController();
  TextEditingController _loanTenure = new TextEditingController();
  TextEditingController _email = new TextEditingController();
  TextEditingController _phoneNumber = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  CallApi _callApi = new CallApi();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var loanTenureList = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];

  Widget dropDown(List<String> list, String hint,
      {Function(String) onSaveValue}) {
    var selected;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hint,
          style: Theme.of(context).textTheme.bodyText2.merge(
                TextStyle(
                  color: GetColor.hintColor,
                ),
              ),
        ),
        SizedBox(
          height: 10.0,
        ),
        DropdownButtonFormField<String>(
          isExpanded: true,
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.fromLTRB(10, 25, 25, 0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            fillColor: GetColor.lightgray,
            filled: true,
          ),

          //hint: new Text(hint),
          validator: (value) {
            if (value == null) {
              return 'Please select the require field';
            } else
              return null;
          },
          onSaved: (value) {
            return onSaveValue(value);
          },
          dropdownColor: GetColor.darkgray_background,
          value: selected,
          items: list
              .map((label) => DropdownMenuItem(
                    child: Text(
                      label,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    value: label,
                  ))
              .toList(),
          onChanged: (value) {
            setState(() => selected = value);
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: ListView(
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Let Start with Basic details of your Customer',
                  style: Theme.of(context).textTheme.headline6.merge(
                        TextStyle(fontSize: 25),
                      ),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 30, 20, 20),
                  child: GetTextField(
                    hinttext: 'Pin Code',
                    isobscure: false,
                    controller: _pincode,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value.isEmpty || value.length != 6) {
                        return "Please enter a valid pincode";
                      } else
                        return null;
                    },
                    onChanged: (value) {
                      if (value.length == 6) {
                        checkPinCode(value);
                      }
                    },
                    onSaved: (value) {
                      widget.customerData.pincode = value;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: GetTextField(
                    // onChanged: (value) {
                    //   var format =
                    //       NumberFormat.currency(locale: 'HI', symbol: "");
                    //   _desiredLoan.text = format.format(
                    //       double.tryParse(value) ?? 0); //10,00,00,000.00
                    //       print()
                    //   setState(() {});
                    // },
                    hinttext: 'Desired Loan Amount',
                    isobscure: false,
                    inputFormatters: [NumericTextFormatter()],
                    controller: _desiredLoan,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please enter desired loan amount";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      var stringValue = value.replaceAll(',', '');
                      widget.customerData.loanAmount =
                          double.parse(stringValue);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: dropDown(loanTenureList, 'Loan Tenure(In Years)',
                      onSaveValue: (String value) {
                    widget.customerData.loanTenure = int.parse(value) * 12;
                  }),

                  // child: GetTextField(
                  //   hinttext: 'Loan Tenture(In Years)',
                  //   isobscure: false,
                  //   controller: _loanTenure,
                  //   keyboardType: TextInputType.number,
                  //   validator: (value) {
                  //     if (value.isEmpty) {
                  //       return "Please enter 'Loan Tenture(In Years)";
                  //     }
                  //     return null;
                  //   },
                  //   onSaved: (value) {
                  //     widget.customerData.loanTenure = int.parse(value);
                  //   },
                  // ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: GetTextField(
                    keyboardType: TextInputType.emailAddress,
                    hinttext: 'Email',
                    isobscure: false,
                    controller: _email,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please provide an email address';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      widget.customerData.emailID = value;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: GetTextField(
                    hinttext: 'Phone Number',
                    isobscure: false,
                    controller: _phoneNumber,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please provide a phone number';
                      } else if (value.length != 10) {
                        return 'Please provide a valid phone number';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      widget.customerData.mobileNumber = value;
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    top: 40,
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: RaisedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          callSendOtpApi(context);
                        } else {
                          _scaffoldKey.currentState.showSnackBar(
                              ShowSnackBar('Please Enter required fields')
                                  .showError());
                        }
                      },
                      child: Text(
                        'Send OTP to Customer`s Email',
                        style: Theme.of(context).textTheme.button,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void checkPinCode(String value) async {
    if (value != null && value.length == 6) {
      var result = await _callApi.callGetApi(
          ApiConstants.VERIFY_PINCODE + _pincode.text, true);
      if (result != null) {
        var decodeJson = json.decode(result);
        bool success = decodeJson['error'] == "0";
        _scaffoldKey.currentState.showSnackBar(
            ShowSnackBar('Great! Your client\'s location is serviceable')
                .showSuccess());
        if (success != null && success) {
          // scaffoldKey.currentState.showSnackBar(
          //     ShowSnackBar('Great! Your client\'s location is serviceable')
          //         .showSuccess());
          print('client\'s location serviceable');
        } else {
          // scaffoldKey.currentState.showSnackBar(ShowSnackBar(
          //         'Oh Sorry! We don’t yet service in your client\s location')
          //     .showError());
          print('don’t yet service in your client\s location');
        }
      }
    }
  }

  void callSendOtpApi(BuildContext buildContext) {
    CallApi _callApi = new CallApi();
    // try {
    // String url = ApiConstants.BASE_URL + ApiConstants.SEND_OTP_API;
    // Map<String, String> requestMap = {
    //   'mobile': widget.customerData.mobileNumber,
    //   'email': widget.customerData.emailID,
    //   'type': 'case'
    // };
    // _callApi.callPostApi(url, requestMap, flag: 1).then((resul) {
    //   if (resul.isEmpty) {
    //     _scaffoldKey.currentState
    //         .showSnackBar(ShowSnackBar('Error sending OTP').showError());
    //   } else {
    //     var jsonResult = json.decode(resul);
    //     if (jsonResult['error'] == 0) {
    // widget.customerData.userID = jsonResult['case']['id'] != null
    //     ? jsonResult['case']['id'].toString()
    //     : '';

    widget.customerData.otpType = 'case';

    Navigator.pushNamed(context, Routes.otpscreen,
        arguments: widget.customerData);
    //   } else {
    //     _scaffoldKey.currentState
    //         .showSnackBar(ShowSnackBar(jsonResult['message']).showError());
    //   }
    // }
    //   });
    // } catch (e) {
    //   print("Exception caught calling send otp api $e");
    // }
  }
}

class NumericTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    } else if (newValue.text.compareTo(oldValue.text) != 0) {
      final int selectionIndexFromTheRight =
          newValue.text.length - newValue.selection.end;
      final f = NumberFormat.currency(locale: 'HI', symbol: "");
      final number = int.parse(newValue.text
          .replaceAll(",", "")
          .replaceAll(".00", "")
          .replaceAll(".", ""));
      var newString = f.format(number);
      newString = newString.replaceAll(".00", "");
      return TextEditingValue(
        text: newString,
        selection: TextSelection.collapsed(
            offset: newString.length - selectionIndexFromTheRight),
      );
    } else {
      return newValue;
    }
  }
}
