import 'package:financial_freedom/old/Model/Agent.dart';
import 'package:financial_freedom/old/widgets/common/BottomNavigationWidgets.dart';
import 'package:financial_freedom/old/widgets/common/ShowSnackBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BankDetails extends StatefulWidget {
  final String title;
  final Agent agent;
  BankDetails({Key key, this.title, this.agent}) : super(key: key);
  @override
  _BankDetailsState createState() => _BankDetailsState();
}

final _formKey = GlobalKey<FormState>();
final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
bool _checkValue = false;

class _BankDetailsState extends State<BankDetails> {
  TextEditingController bankNameController = new TextEditingController();
  TextEditingController accountNameController = new TextEditingController();
  TextEditingController accountNumberController = new TextEditingController();
  TextEditingController ifscController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    print('ans1 ${widget.agent.ans1},ans2 ${widget.agent.ans2}');

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      bottomNavigationBar: BottomNavigationWidgets(
        onPressedNext: (BuildContext btncontext) {
          onNextClick(btncontext);
        },
        onPressedCancel: (BuildContext buildContext) {
          Navigator.pop(buildContext);
        },
        nextButtonName: 'Next',
        cancelButtonName: 'Cancel',
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        // padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Center(
                child: Text(
                  'Bank Details',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: bankNameController,
                validator: (value) => validateTextfields(value),
                onSaved: (value) {
                  widget.agent.bankName = value;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  labelText: 'Bank Name',
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: accountNameController,
                validator: (value) => validateTextfields(value),
                onSaved: (value) {
                  widget.agent.accountName = value;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  labelText: 'Account Holders Name',
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: accountNumberController,
                validator: (value) => validateAccountNumber(value),
                onSaved: (value) {
                  if (value != null && value != '')
                    widget.agent.accountNumber = int.parse(value);
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  labelText: 'Account Number',
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: ifscController,
                validator: (value) => validateTextfields(value),
                onSaved: (value) {
                  widget.agent.ifscCode = value;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  labelText: 'IFSC Code',
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Checkbox(
                    value: _checkValue,
                    onChanged: (bool value) {
                      if (_checkValue == false) {
                        setState(() {
                          _checkValue = true;
                        });
                      } else if (_checkValue == true) {
                        setState(() {
                          _checkValue = false;
                        });
                      }
                    },
                  ),
                  Expanded(
                    child: Text(
                      'All earnings shall be transferred to this account. Please ensure the account given is linked to PAN-aadhaar.',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String validateTextfields(String value) {
  if (value.isEmpty) {
    return "*All fields are mandatary";
  }
  return null;
}

String validateAccountNumber(String value) {
  Pattern pattern = r'^\d{9,18}$';
  RegExp regExp = new RegExp(pattern);
  if (!regExp.hasMatch(value)) {
    return 'Please enter valid Bank Account number';
  }
  return null;
}

onNextClick(BuildContext buildContext) {
  // if (!_formKey.currentState.validate()) {
  //   scaffoldKey.currentState.showSnackBar(
  //       ShowSnackBar('Please fill all the Bank Details').showError());
  // } else
  if (!_checkValue) {
    scaffoldKey.currentState.showSnackBar(
        ShowSnackBar('Please check the Bank Details by clicking given checkbox')
            .showError());
  } else {
    _formKey.currentState.save();
    Navigator.pushNamed(buildContext, '/termsCondition');
  }
}
