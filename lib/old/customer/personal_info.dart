import 'package:financial_freedom/old/Model/customerData.dart';
import 'package:financial_freedom/old/components.dart';
import 'package:financial_freedom/old/widgets/common/ShowSnackBar.dart';
import 'package:financial_freedom/old/widgets/common/colors.dart';
import 'package:financial_freedom/old/widgets/common/mycolors.dart';
import 'package:financial_freedom/old/widgets/common/routes.dart';
import 'package:financial_freedom/old/widgets/common/textfield.dart';
import 'package:flutter/material.dart';

class PersonalInfo extends StatefulWidget {
  final Customer customerData;
  PersonalInfo({this.customerData});

  @override
  _PersonalInfoState createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  TextEditingController _fullname = new TextEditingController();
  TextEditingController _dob = new TextEditingController();
  TextEditingController _isanypastloan = new TextEditingController();
  TextEditingController _address = new TextEditingController();
  TextEditingController _residentialstatus = new TextEditingController();
  TextEditingController _purposeOfLoan = new TextEditingController();
  TextEditingController _gender = new TextEditingController();
  TextEditingController _maritalStatus = new TextEditingController();
  var addressTypeList = [
    'Permanent Address',
    'Present Address',
    'Any Other Address'
  ];
  var residentialStatusList = [
    'Owned',
    'Rented',
    'Parental Owned',
    'Accomadation provided by employer',
    'PG',
    'Sharing with Friends',
    'Living with Relatives'
  ];

  final _formKey = GlobalKey<FormState>();
  var purposeOfLoanList = [
    'Financial security',
    'Loan/Card Repayment',
    'Household Expenses',
    'Education/related Expense',
    'Travel/Relocation Related',
    'renovation/Home buying',
    'Urgent Medical Expenses',
    'Marriage/Events Expenses',
    'Purchase of goods/electronic/households',
    'Others'
  ];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1920, 1),
        lastDate: DateTime(2999));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        _dob.text = selectedDate.toLocal().toString().split(' ')[0];
      });
  }

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
    return WillPopScope(
      onWillPop: () async {
        // CustomComponents.showBackStopDialog(context);
        return true;
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.yellow,
            ),
            onPressed: () {
              CustomComponents.showBackStopDialog(context);
            },
          ),
          // title:
          centerTitle: true,
        ),
        body: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  Text(
                    'Personal Information',
                    style: Theme.of(context).textTheme.headline6.merge(
                          TextStyle(fontSize: 25),
                        ),
                    textAlign: TextAlign.center,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     IconButton(
                  //       icon: Icon(Icons.arrow_back_ios_new,color: Colors.yellow,),
                  //       onPressed: (){
                  //         CustomComponents.showBackStopDialog(context);
                  //       },
                  //     ),
                  //     Text(
                  //       'Personal Information',
                  //       style: Theme.of(context).textTheme.headline6.merge(
                  //             TextStyle(fontSize: 25),
                  //           ),
                  //       textAlign: TextAlign.center,
                  //     ),
                  //     SizedBox(width: 30,)
                  //   ],
                  // ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: GetTextField(
                      hinttext: 'Full Name(same as KYC)',
                      isobscure: false,
                      controller: _fullname,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide full name';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        widget.customerData.fullName = value;
                      },
                    ),
                  ),
                  InkWell(
                    onTap: () => _selectDate(context),
                    child: IgnorePointer(
                      child: GetTextField(
                        hinttext: 'Date of Birth',
                        isobscure: false,
                        controller: _dob,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please select Date Of Birth';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          widget.customerData.dob = value;
                        },
                      ),
                    ),
                  ),
                  // widget.customerData.loanType == "Professional" ? SizedBox.shrink() : Column(
                  //   children: [
                  //     Padding(
                  //       padding: const EdgeInsets.symmetric(vertical: 30),
                  //       child: GetTextField(
                  //         hinttext: 'Gender',
                  //         isobscure: false,
                  //         controller: _gender,
                  //         validator: (value) {
                  //           if (value == null) {
                  //             return 'Please enter the required field';
                  //           } else
                  //             return null;
                  //         },
                  //         onSaved: (value) {
                  //           widget.customerData.gender = _gender.text;
                  //         },
                  //       ),
                  //     ),
                  //     Padding(
                  //       padding: const EdgeInsets.only(),
                  //       child: GetTextField(
                  //         hinttext: 'Marital Status',
                  //         isobscure: false,
                  //         controller: _maritalStatus,
                  //         validator: (value) {
                  //           if (value == null) {
                  //             return 'Please enter the required field';
                  //           } else
                  //             return null;
                  //         },
                  //         onSaved: (value) {
                  //           widget.customerData.maritalStatus = _maritalStatus.text;
                  //         },
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: dropDown(['Yes', 'No'], 'Any Past Loans?',
                        onSaveValue: (String value) {
                      widget.customerData.pastLoans = value;
                    }),
                  ),
                  dropDown(addressTypeList, 'Address Reflecting on Aadhaar?',
                      onSaveValue: (String value) {
                    widget.customerData.address = value;
                  }),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: dropDown(residentialStatusList, 'Residential Status',
                        onSaveValue: (String value) {
                      widget.customerData.residentialStatus = value;
                    }),
                  ),
                  widget.customerData.loanType == "Professional"
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: dropDown(purposeOfLoanList, 'Purpose Of Loan',
                              onSaveValue: (String value) {
                            widget.customerData.purposeOfLoan = value;
                          }),
                        )
                      : SizedBox.shrink(),
                  Container(
                    padding: EdgeInsets.only(top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 100,
                          child: RaisedButton(
                            color: Colors.grey,
                            onPressed: () {
                              // CustomComponents.showBackStopDialog(context);
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Back',
                              style:
                                  Theme.of(context).textTheme.button.copyWith(
                                        color: MyColors.yellowColor(),
                                      ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: RaisedButton(
                            onPressed: () {
                              if (!_formKey.currentState.validate()) {
                                _scaffoldKey.currentState.showSnackBar(
                                    ShowSnackBar('Please fill valid fields.')
                                        .showError());
                              } else {
                                _formKey.currentState.save();

                                Navigator.pushNamed(
                                        context, Routes.uploadAdhaar,
                                        arguments: widget.customerData)
                                    .then((_) => _formKey.currentState.reset());
                              }
                            },
                            child: Text(
                              'Next',
                              style: Theme.of(context).textTheme.button,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
