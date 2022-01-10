import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:financial_freedom/old/Model/ProductsArguments.dart';
import 'package:financial_freedom/old/Model/customerData.dart';
import 'package:financial_freedom/old/components.dart';
import 'package:financial_freedom/old/customer/congratulations-screen.dart';
import 'package:financial_freedom/old/widgets/common/ApiConstants.dart';
import 'package:financial_freedom/old/widgets/common/CallApi.dart';
import 'package:financial_freedom/old/widgets/common/SharedPref.dart';
import 'package:financial_freedom/old/widgets/common/ShowSnackBar.dart';
import 'package:financial_freedom/old/widgets/common/colors.dart';
import 'package:financial_freedom/old/widgets/common/mycolors.dart';
import 'package:financial_freedom/old/widgets/common/routes.dart';
import 'package:financial_freedom/old/widgets/common/textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class IncomeDetails extends StatefulWidget {
  final Customer customerData;
  IncomeDetails({this.customerData});
  @override
  _IncomeDetailsState createState() => _IncomeDetailsState();
}

Customer customerCase = new Customer();

class _IncomeDetailsState extends State<IncomeDetails> {
  TextEditingController _netTakeHomeSalary = new TextEditingController();
  TextEditingController _annualIncome = new TextEditingController();
  TextEditingController _healthOfBusiness = new TextEditingController();
  TextEditingController _incomeOfSelectedMethod = new TextEditingController();
  TextEditingController _primaryBankAccount = new TextEditingController();
  TextEditingController _latestYearsOfProfitability =
      new TextEditingController();
  TextEditingController _ownershipStatus = new TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  CallApi _callApi = new CallApi();

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

  Future<bool> sendDataToCases() async {
    try {
      if (customerCase != null) {
        customerCase.loanType = "Professional";
        var res = await _callApi.callPutApi(
            ApiConstants.CASE_DETAILS + customerCase.userID,
            customerCase.toJson());
        print('add cust res : ${jsonDecode(res)}');
        //         .then((value) {
        //   if (value != '200') {
        //     scaffoldKey.currentState.showSnackBar(
        //         ShowSnackBar('Error saving case details').showError());
        //     return false;
        //   }
        //   scaffoldKey.currentState.showSnackBar(
        //       ShowSnackBar('Case Details saved successfully').showSuccess());
        //   return true;
        // })
        // if (reply != null) {
        //   scaffoldKey.currentState.showSnackBar(
        //       ShowSnackBar('Error saving case details').showError());
        //   return false;
        // }
        _scaffoldKey.currentState.showSnackBar(
            ShowSnackBar('Case Details saved successfully').showSuccess());
        return true;
      }
    } catch (e) {
      log('Error occurred: ' + e.toString());
    }
    return false;
  }

  bool setVisibility(String controlName) {
    if (widget.customerData.employmentType == 'Salaried') {
      if (controlName == 'netTakeHomeSalary') {
        return true;
      } else if (controlName == 'salaryReceived') {
        return true;
      } else if (controlName == 'optionDeclareIncome') {
        return false;
      } else if (controlName == 'annualIncome') {
        return false;
      } else if (controlName == 'primaryBankingAmount') {
        return false;
      } else if (controlName == 'ownershipStatus') {
        return false;
      }
    } else if (widget.customerData.employmentType ==
        'Salaried + Self-Employed') {
      if (controlName == 'netTakeHomeSalary') {
        return true;
      } else if (controlName == 'salaryReceived') {
        return true;
      } else if (controlName == 'optionDeclareIncome') {
        return true;
      } else if (controlName == 'annualIncome') {
        return true;
      } else if (controlName == 'primaryBankingAmount') {
        return true;
      } else if (controlName == 'ownershipStatus') {
        return true;
      }
    } else {
      if (controlName == 'netTakeHomeSalary') {
        return false;
      } else if (controlName == 'salaryReceived') {
        return false;
      } else if (controlName == 'optionDeclareIncome') {
        return true;
      } else if (controlName == 'annualIncome') {
        return true;
      } else if (controlName == 'primaryBankingAmount') {
        return true;
      } else if (controlName == 'ownershipStatus') {
        return true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    customerCase = widget.customerData;
    print(widget.customerData.loanType);

    return WillPopScope(
      onWillPop: () async {
        // CustomComponents.showBackStopDialog(context);
        return true;
      },
      child: Scaffold(
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
          // title: Text(
          //   'Personal Information',
          //   style: Theme.of(context).textTheme.headline6.merge(
          //         TextStyle(fontSize: 25),
          //       ),
          //   textAlign: TextAlign.center,
          // ),
          // centerTitle: true,
        ),
        key: _scaffoldKey,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  Form(
                    key: _formkey,
                    child: widget.customerData.loanType == "Business"
                        ? ListView(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            children: [
                              Text(
                                'Income Details',
                                style:
                                    Theme.of(context).textTheme.headline6.merge(
                                          TextStyle(fontSize: 25),
                                        ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              dropDown([
                                "Last 12 months Sales (Turnover)",
                                "Profit-After-Tax for the current (or previous) year"
                              ], 'Select type to Declare health of business',
                                  onSaveValue: (String value) {
                                widget.customerData.healthOfBusiness = value;
                              }),
                              SizedBox(
                                height: 20.0,
                              ),
                              GetTextField(
                                hinttext: 'Enter Annual Income',
                                isobscure: false,
                                inputFormatters: [NumericTextFormatter()],
                                controller: _annualIncome,
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please provide value';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  widget.customerData.annualIncome = value;
                                },
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              dropDown([
                                "HDFC Bank",
                                "IDFC First Bank",
                                "SBI Bank",
                                "ICICI Bank",
                                "Axis Bank",
                                "Standard Chartered Bank",
                                "UCO Bank",
                                "Any Other Bank"
                              ], 'Primary Bank Account',
                                  onSaveValue: (String value) {
                                widget.customerData.primaryBankAccount = value;
                              }),
                              SizedBox(
                                height: 20.0,
                              ),
                              dropDown([
                                "Yes",
                                "No"
                              ], 'Has business been profitable for last 2 years',
                                  onSaveValue: (String value) {
                                widget.customerData.latestYearsOfProfitability =
                                    value;
                              }),
                              SizedBox(
                                height: 20.0,
                              ),
                              dropDown([
                                "Business Property - Owned",
                                "Business Property - Rented",
                                "Business Operated from Owned Residence",
                                "Business Operated from Rented Residence",
                              ], 'Ownership Status of business property',
                                  onSaveValue: (String value) {
                                widget.customerData.ownershipStatus = value;
                              }),
                              SizedBox(
                                height: 20.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 4.0, right: 4.0),
                                child: Text(
                                  'Business Premises is the place where professional register their business and practice their profession. which could be office, clinic, workshop, hospital, etc.',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                ),
                              ),
                            ],
                          )
                        : ListView(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            children: [
                              Text(
                                'Income Details',
                                style:
                                    Theme.of(context).textTheme.headline6.merge(
                                          TextStyle(fontSize: 25),
                                        ),
                                textAlign: TextAlign.center,
                              ),
                              Visibility(
                                visible: setVisibility('netTakeHomeSalary'),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: GetTextField(
                                    keyboardType: TextInputType.number,
                                    hinttext:
                                        'Enter monthly net Take Home Salary',
                                    isobscure: false,
                                    controller: _netTakeHomeSalary,
                                    onSaved: (value) {
                                      customerCase.netmonthlySalary =
                                          double.parse(
                                              value.replaceAll(",", ""));
                                    },
                                    inputFormatters: [NumericTextFormatter()],
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please provide net Take Home Salary';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: setVisibility('salaryReceived'),
                                child: dropDown(['Cash', 'Cheque', 'Bank'],
                                    'Select Salary Received In?',
                                    onSaveValue: (String value) {
                                  customerCase.salarymode = value;
                                }),
                              ),
                              Visibility(
                                visible: setVisibility('optionDeclareIncome'),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: dropDown([
                                          'Gross Annual Reciepts/Turnover/sales',
                                          'Profit-After-Tax',
                                          'Gross Annual Income'
                                        ], 'Select option to declare Income',
                                            onSaveValue: (String value) {
                                          customerCase.optionDeclareIncome =
                                              value;
                                        }),
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      // Tooltip(
                                      //   textStyle:
                                      //       TextStyle(color: Colors.white),
                                      //   message:
                                      //       'Gross Annual Reciepts/Turnover: Total amount recieved from all sources without subtracting any cost or expenses. (if monthly information is available * 12)\nProfit After tax: Net income left after subtracting expenses and taxes from earnings.\nGross Annual Income: Income after subtracting all expenses from earnings (if monthly information is available * 12)',
                                      //   child: Icon(
                                      //     Icons.info,
                                      //     color: Colors.blue[500],
                                      //   ),
                                      // )
                                    ],
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: setVisibility('annualIncome'),
                                child: GetTextField(
                                  hinttext: 'Enter Annual Income',
                                  isobscure: false,
                                  controller: _annualIncome,
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please provide client\'s annual income';
                                    }
                                    return null;
                                  },
                                  inputFormatters: [NumericTextFormatter()],
                                  onSaved: (value) {
                                    customerCase.annualIncome =
                                        value.toString();
                                  },
                                ),
                              ),
                              Visibility(
                                visible: setVisibility('primaryBankingAmount'),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: dropDown([
                                    'HDFC Bank',
                                    'ICICI Bank',
                                    'SBI',
                                    'IDFC',
                                    'Others'
                                  ], 'Where is your Primary Business Account?',
                                      onSaveValue: (String value) {
                                    customerCase.primaryAccount = value;
                                  }),
                                ),
                              ),
                              Visibility(
                                visible: setVisibility('ownershipStatus'),
                                child: dropDown([
                                  'Business Property - Owned',
                                  'Business Property - Rented',
                                  'Business operate from owned house',
                                  'Business operate from rented house'
                                ], 'Business Premise Ownership Status?',
                                    onSaveValue: (String value) {
                                  customerCase.ownershipStatus = value;
                                }),
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.only(
                              //       top: 50, left: 40, right: 40),
                              //   child: SizedBox(
                              //     width: 200,
                              //     child: RaisedButton(
                              //       onPressed: () async {
                              //         if (_formkey.currentState.validate()) {
                              //           _formkey.currentState.save();

                              //           print('submit pressed');
                              //           var isadded = await sendDataToCases();
                              //           print(
                              //               'submit pressed after api $isadded');

                              //           if (isadded) {
                              //             ProductsArguments args =
                              //                 new ProductsArguments(
                              //                     customerCase.userID,
                              //                     null,
                              //                     customerCase.emailID);
                              //             Navigator.push(
                              //                 context,
                              //                 CupertinoPageRoute(
                              //                     builder: (context) =>
                              //                         CongratulationsScreen(
                              //                           id: widget.customerData
                              //                               .userID,
                              //                           email: widget
                              //                               .customerData
                              //                               .emailID,
                              //                           loanType: widget
                              //                               .customerData
                              //                               .loanType,
                              //                         )));
                              //           }
                              //         }
                              //       },
                              //       child: Padding(
                              //         padding: const EdgeInsets.symmetric(
                              //             vertical: 15),
                              //         child: Text(
                              //           'Submit Application',
                              //           style: Theme.of(context)
                              //               .textTheme
                              //               .button
                              //               .merge(TextStyle(fontSize: 15)),
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 50, left: 40, right: 40),
                    child: SizedBox(
                      width: 200,
                      child: RaisedButton(
                        onPressed: () async {
                          if (_formkey.currentState.validate()) {
                            _formkey.currentState.save();

                            // Map<String, dynamic> data1 = {
                            //   "first_name": widget
                            //       .customerData.fullName
                            //       .toString()
                            //       .split(" ")
                            //       .getRange(
                            //           0,
                            //           widget.customerData.fullName
                            //                   .toString()
                            //                   .split(" ")
                            //                   .length -
                            //               1)
                            //       .join(" "),
                            //   "last_name": widget
                            //       .customerData.fullName
                            //       .toString()
                            //       .split(" ")
                            //       .last,
                            //   "mobile":
                            //       widget.customerData.mobileNumber,
                            //   "pin_code": widget.customerData.pincode,
                            //   "date_of_birth":
                            //       widget.customerData.dob,
                            //   "company":
                            //       widget.customerData.businessName,
                            //   "monthly_salary": widget
                            //       .customerData.netmonthlySalary,
                            //   "load_type":
                            //       widget.customerData.loanType,
                            //   "load_amount":
                            //       widget.customerData.loanAmount,
                            //   "disbursed_tenure":
                            //       widget.customerData.loanTenure,
                            //   "mode_of_salary":
                            //       widget.customerData.salarymode,
                            //   "load_purpose":
                            //       widget.customerData.purposeOfLoan,
                            //   "email": widget.customerData.emailID,
                            //   "gender": widget.customerData.gender,
                            //   "marital_status":
                            //       widget.customerData.maritalStatus,
                            //   "past_loans":
                            //       widget.customerData.pastLoans,
                            //   "address_type":
                            //       widget.customerData.address,
                            //   "residential_status": widget
                            //       .customerData.residentialStatus,
                            //   "work_experience":
                            //       widget.customerData.totalworkExp,
                            //   "exp_with_current_employer":
                            //       widget.customerData.currentworkexp,
                            //   "highest_degree":
                            //       widget.customerData.degreename,
                            //   "employer_name":
                            //       widget.customerData.empname,
                            //   "firm_name":
                            //       widget.customerData.businessName,
                            //   "occupation":
                            //       widget.customerData.professionName,
                            //   "employment_type":
                            //       widget.customerData.employmentType,
                            //   "organisation_type": widget
                            //       .customerData.organisationType,
                            //   "premise_ownership_status":
                            //       widget.customerData.ownershipStatus,
                            //   "primary_account": widget
                            //       .customerData.primaryBankAccount,
                            //   "client_income":
                            //       widget.customerData.annualIncome,
                            //   "loan_amount":
                            //       widget.customerData.loanAmount,
                            //   "name": widget.customerData.fullName,
                            //   "business_industry": widget
                            //       .customerData.industryOfBusiness,
                            //   "how_old_business": widget
                            //       .customerData.howOldIsTheBusiness,
                            //   "business_health": widget
                            //       .customerData.healthOfBusiness,
                            //   "profitability_years": widget
                            //       .customerData
                            //       .latestYearsOfProfitability,
                            //   "income_method": widget
                            //       .customerData.incomeOfSelectedMethod
                            // };
                            Map<String, dynamic> data1 = {
                              "id": widget.customerData.userID,
                              "occupation": widget.customerData.professionName,
                              "highest_degree": widget.customerData.degreename,
                              "pin_code": widget.customerData.pincode,
                              "load_amount": widget.customerData.loanAmount,
                              "loan_period": widget.customerData.loanTenure,
                              "email": widget.customerData.emailID,
                              "mobile": widget.customerData.mobileNumber,
                              "firt_name": widget.customerData.fullName
                                  .toString()
                                  .split(" ")
                                  .first,
                              "first_name": widget.customerData.fullName
                                  .toString()
                                  .split(" ")
                                  .first,
                              "last_name": widget.customerData.fullName
                                          .toString()
                                          .split(" ")
                                          .length >
                                      1
                                  ? widget.customerData.fullName
                                      .toString()
                                      .split(" ")
                                      .last
                                  : '',
                              "date_of_birth": widget.customerData.dob,
                              "pastLoans": widget.customerData.pastLoans,
                              "addressType": widget.customerData.address,
                              "residentialStatus":
                                  widget.customerData.residentialStatus,
                              "load_purpose": widget.customerData.purposeOfLoan,
                              "employment_type":
                                  widget.customerData.employmentType,
                              "organisation_type":
                                  widget.customerData.organisationType,
                              "employer_name": widget.customerData.empname,
                              "exp_with_current_employer":
                                  widget.customerData.currentworkexp,
                              "work_experience":
                                  widget.customerData.totalworkExp,
                              "monthly_salary":
                                  widget.customerData.netmonthlySalary,
                              "mode_of_salary": widget.customerData.salarymode,
                              "load_type": widget.customerData.loanType,
                              "inform_client_income":
                                  widget.customerData.annualIncome,
                              "primary_account":
                                  widget.customerData.primaryBankAccount,
                              "premise_ownership_status":
                                  widget.customerData.ownershipStatus,
                              "total_loans": widget.customerData.loanAmount,
                              "industry":
                                  widget.customerData.industryOfBusiness,
                              "company": widget.customerData.businessName,
                              "years_in_business":
                                  widget.customerData.howOldIsTheBusiness,
                              "firm_name": widget.customerData.businessName,
                              "business_industry":
                                  widget.customerData.industryOfBusiness,
                              "how_old_business":
                                  widget.customerData.howOldIsTheBusiness,
                              "business_health":
                                  widget.customerData.healthOfBusiness,
                              "profitability_years": widget
                                  .customerData.latestYearsOfProfitability,
                            };
                            log(data1.toString(), name: 'this is final data');

                            bool isadded = await sendData(data1);
                            print('submit pressed after api $isadded');

                            if (isadded) {
                              ProductsArguments args = new ProductsArguments(
                                  widget.customerData.userID,
                                  null,
                                  widget.customerData.emailID);

                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) =>
                                          CongratulationsScreen(
                                            id: widget.customerData.userID,
                                            email: widget.customerData.emailID,
                                            loanType:
                                                widget.customerData.loanType,
                                          )));
                            }
                          } else {
                            if (_formkey.currentState.validate()) {
                              _formkey.currentState.save();
                              Navigator.pushNamed(context, Routes.incomeDetails,
                                  arguments: widget.customerData);
                            }
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Text(
                            'Submit Application',
                            style: Theme.of(context)
                                .textTheme
                                .button
                                .merge(TextStyle(fontSize: 15)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      RaisedButton(
                        color: Colors.grey,
                        onPressed: () {
                          // CustomComponents.showBackStopDialog(context);
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Back',
                          style: Theme.of(context).textTheme.button.copyWith(
                                color: MyColors.yellowColor(),
                              ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> sendData(Map<String, dynamic> data) async {
    // log(data.toString(), name: 'in function');
    SharedPref _pref = new SharedPref();
    try {
      Response response = await Dio().post(
        ApiConstants.BASE_URL + ApiConstants.updateCases,
        options: Options(headers: {
          "verify-myself": "banana",
          "Authorization": "Bearer ${await _pref.getToken()}"
        }),
        data: FormData.fromMap(data),
      );
      // log(response.data.toString(), name: 'api response');
      // log(response.statusCode.toString(), name: 'api response');
      if (response.statusCode == 200) {
        print(response.data["data"]["id"].toString());
        widget.customerData.userID = response.data["data"]["id"].toString();
        return true;
      }
      return false;
    } on DioError catch (e) {
      log(e.response.statusCode.toString());
      // log(e.response.data.toString());
      return false;
    }
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
