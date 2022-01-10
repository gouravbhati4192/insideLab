import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:financial_freedom/old/Model/ProductsArguments.dart';
import 'package:financial_freedom/old/Model/customerData.dart';
import 'package:financial_freedom/old/components.dart';
import 'package:financial_freedom/old/customer/congratulations-screen.dart';
import 'package:financial_freedom/old/widgets/common/ApiConstants.dart';
import 'package:financial_freedom/old/widgets/common/CallApi.dart';
import 'package:financial_freedom/old/widgets/common/SharedPref.dart';
import 'package:financial_freedom/old/widgets/common/colors.dart';
import 'package:financial_freedom/old/widgets/common/mycolors.dart';
import 'package:financial_freedom/old/widgets/common/routes.dart';
import 'package:financial_freedom/old/widgets/common/textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class EmploymentDetails extends StatefulWidget {
  final Customer customerData;
  EmploymentDetails({this.customerData});
  @override
  _EmploymentDetailsState createState() => _EmploymentDetailsState();
}

class _EmploymentDetailsState extends State<EmploymentDetails> {
  CallApi _callApi = new CallApi();
  TextEditingController _organizationtype = new TextEditingController();
  TextEditingController _empname = new TextEditingController();
  TextEditingController _currentworkexp = new TextEditingController();
  TextEditingController _totalworkexp = new TextEditingController();
  TextEditingController _occupation = new TextEditingController();
  TextEditingController _monthlyTakeHomeSalary = new TextEditingController();
  TextEditingController _salaryRecieved = new TextEditingController();
  TextEditingController _industryOfBusiness = new TextEditingController();
  TextEditingController _businessName = new TextEditingController();
  TextEditingController _companyType = new TextEditingController();
  TextEditingController _howOldIsTheBusiness = new TextEditingController();
  TextEditingController _natureOfBusiness = new TextEditingController();
  TextEditingController _purposeOfLoan = new TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  var selectedEmployment = '';

  var employmentTypeList = [
    'Salaried',
    'Self Employed',
    'Salaried + Self-Employed',
  ];
  var organisationTypeList = [
    'Properitorship Firm',
    'Partnership Firm',
    'Limited Liability Partnership',
    'Private Limited Company',
    'Public Limited Company',
    'Public Sector Undertaking(PSUs)',
    'Central Government',
    'State Government',
    'Private & Gov Educational Institute',
    'Society',
    'Trust'
  ];

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
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.fromLTRB(10, 20, 20, 0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            // labelText: hint,
            labelStyle: Theme.of(context)
                .textTheme
                .bodyText2
                .merge(TextStyle(color: GetColor.hintColor)),
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
                            height: 5.0,
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
        key: scaffoldKey,
        body: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Form(
              key: _formkey,
              child: widget.customerData.loanType == "Business"
                  ? ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Text(
                            'Employment Details',
                            style: Theme.of(context).textTheme.headline6.merge(
                                  TextStyle(fontSize: 25),
                                ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Theme(
                          data: Theme.of(context).copyWith(
                            inputDecorationTheme: InputDecorationTheme(
                              isDense: true,
                              contentPadding:
                                  EdgeInsets.fromLTRB(10, 25, 25, 0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .merge(TextStyle(color: GetColor.hintColor)),
                              fillColor: GetColor.lightgray,
                              filled: true,
                            ),
                          ),
                          child: Column(
                            children: [
                              dropDown([
                                "Micro, Small & Medium Enterprises",
                                "Mining",
                                "Chemicals and Petrochemicals",
                                "Corporate Governance",
                                "Cottage",
                                "Defence Products",
                                "Fertilizers",
                                "Food Processing",
                                "Heavy Industries",
                                "Manufacturing",
                                "Oil and Natural Gas",
                                "Pharmaceuticals",
                                "Retail",
                                "Textiles",
                                "Tourism",
                                "OTHER",
                              ], 'Select Industry of Business',
                                  onSaveValue: (String value) {
                                widget.customerData.industryOfBusiness = value;
                              }),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: _businessName, //value
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter valid value';
                                  } else {
                                    return null;
                                  }
                                },
                                onSaved: (value) {
                                  // agentDetails.emailID = value;
                                  widget.customerData.businessName = value;
                                },
                                decoration: InputDecoration(
                                  hintText: 'Enter Business/Company Name',
                                ),
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              dropDown([
                                "Partnership Firm",
                                "Private Limited Company",
                                "Proprietorship Firm",
                                "Limited Liability Partnership",
                                "Public Limited Company / PSU",
                                "Central Government",
                                "State Government",
                                "Local Government / Municipal Corporation",
                                "Co-operative Societies",
                                "Trust / NGO",
                                "Educational Institute"
                              ], 'Select Company Type',
                                  onSaveValue: (String value) {
                                widget.customerData.companyType = value;
                              }),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller:
                                    _howOldIsTheBusiness, //employee name
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter valid value';
                                  } else {
                                    return null;
                                  }
                                },
                                onSaved: (value) {
                                  widget.customerData.howOldIsTheBusiness =
                                      value;
                                  // agentDetails.emailID = value;
                                },
                                decoration: InputDecoration(
                                  hintText:
                                      'How Old is the Business (In years) ?',
                                ),
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: _natureOfBusiness, //employee name
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter valid value';
                                  } else {
                                    return null;
                                  }
                                },
                                onSaved: (value) {
                                  widget.customerData.natureOfBusiness = value;
                                  // agentDetails.emailID = value;
                                },
                                decoration: InputDecoration(
                                  hintText:
                                      'What is the business of your Customer ?',
                                ),
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        'Eg: Restaurant, Electronic Retail, Garment Manufacture',
                                        textAlign: TextAlign.justify,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              dropDown(
                                  widget.customerData.loanType == 'professional'
                                      ? [
                                          "Working Capital",
                                          "Purchase of equipments & supplies",
                                          "Expansion or renovation ",
                                          "Setting up private Practice ",
                                          "Operational costs",
                                          "Education/professional course",
                                          "Personal Use",
                                          "Other"
                                        ]
                                      : [
                                          "Increase Working Capital",
                                          "Purchase of equipments & supplies",
                                          "Purchase inventory",
                                          "Purchase or setup of business property",
                                          "Setup of office/store/shop/factory",
                                          "Improve Cash Flow",
                                          "Debt consolidation",
                                          "Expansion or renovation",
                                          "Operational costs",
                                          "Clearing Expenses or Debt",
                                          "Trading",
                                          "Clearing bills/vendors/suppliers",
                                          "Other"
                                        ],
                                  'Purpose Of Loan',
                                  onSaveValue: (String value) {
                                widget.customerData.purposeOfLoan = value;
                              }),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  : ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Text(
                            'Employment Details',
                            style: Theme.of(context).textTheme.headline6.merge(
                                  TextStyle(fontSize: 25),
                                ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        widget.customerData.loanType == "Professional"
                            ? Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    child: dropDown(employmentTypeList,
                                        'Select Employment Type',
                                        onSaveValue: (String value) {
                                      widget.customerData.employmentType =
                                          value;
                                    }),
                                  ),
                                  dropDown(organisationTypeList,
                                      'Select Organisation Type',
                                      onSaveValue: (String value) {
                                    widget.customerData.organisationType =
                                        value;
                                  }),
                                ],
                              )
                            : SizedBox.shrink(),
                        widget.customerData.loanType == "Professional"
                            ? SizedBox.shrink()
                            : Column(
                                children: [
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  GetTextField(
                                    hinttext: 'Occupation',
                                    isobscure: false,
                                    controller: _occupation,
                                    keyboardType: TextInputType.name,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please provide value';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      widget.customerData.professionName =
                                          value;
                                    },
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  GetTextField(
                                    hinttext: 'Enter monthly Take Home Salary',
                                    isobscure: false,
                                    controller: _monthlyTakeHomeSalary,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [NumericTextFormatter()],
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please provide value';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      var stringValue =
                                          value.replaceAll(',', '');
                                      widget.customerData.netmonthlySalary =
                                          double.tryParse(stringValue);
                                    },
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  dropDown([
                                    "Cash",
                                    "Cheque",
                                    "HDFC Bank",
                                    "IDFC First Bank",
                                    "SBI Bank",
                                    "ICICI Bank",
                                    "Axis Bank",
                                    "Standard Chartered Bank",
                                    "UCO Bank",
                                    "Any Other Bank",
                                  ], 'How is salary received ?',
                                      onSaveValue: (String value) {
                                    widget.customerData.salarymode = value;
                                  }),
                                ],
                              ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: GetTextField(
                            hinttext: 'Company (Employer) Name',
                            isobscure: false,
                            controller: _empname,
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please provide Employer full name';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              widget.customerData.empname = value;
                            },
                          ),
                        ),
                        GetTextField(
                          keyboardType: TextInputType.number,
                          hinttext: 'Current Work Experience',
                          isobscure: false,
                          controller: _currentworkexp,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please provide experience with current employer';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            widget.customerData.currentworkexp = value;
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: GetTextField(
                            hinttext: 'Total Work Experience',
                            isobscure: false,
                            keyboardType: TextInputType.number,
                            controller: _totalworkexp,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please provide Total Work Experience';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              widget.customerData.totalworkExp = value;
                            },
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(30.0),
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
                    style: Theme.of(context).textTheme.button.copyWith(
                          color: MyColors.yellowColor(),
                        ),
                  ),
                ),
              ),
              SizedBox(
                width: 100,
                child: RaisedButton(
                  onPressed: () async {
                    if (!_formkey.currentState.validate()) {
                      return;
                    }
                    _formkey.currentState.save();
                    if (widget.customerData.loanType == "Personal") {
                      Map<String, dynamic> data1 = {
                        "id": widget.customerData.userID,
                        "pin_code": widget.customerData.pincode,
                        "load_amount": widget.customerData.loanAmount,
                        "loan_period": widget.customerData.loanTenure,
                        "email": widget.customerData.emailID,
                        "mobile": widget.customerData.mobileNumber,
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
                        "designation": widget.customerData.professionName,
                        "occupation": widget.customerData.professionName,
                        "monthlySalary": widget.customerData.netmonthlySalary,
                        "mode_of_salary": widget.customerData.salarymode,
                        "exp_with_current_employer":
                            widget.customerData.currentworkexp,
                        "work_experience": widget.customerData.totalworkExp,
                        "load_type": widget.customerData.loanType,
                        "total_loans": widget.customerData.loanAmount,
                      };

                      /*"primaryAccount": widget.customerData.primaryAccount,
                        "informClientIncome": widget.customerData.annualIncome,
                        "ownershipStatus": widget.customerData.ownershipStatus,
                        "workingFromHome": null,
                        "industry": widget.customerData.industryOfBusiness,
                        "organisationType":
                            widget.customerData.organisationType,
                        "employmentType": widget.customerData.employmentType,
                        "occupation": widget.customerData.professionName,
                        "tenure": widget.customerData.loanTenure,
                        "firmName": widget.customerData.businessName,
                        "companyName": widget.customerData.businessName,
                        "purposeOfLoan": widget.customerData.purposeOfLoan,
                        "totalLoans": widget.customerData.loanAmount,
                        "yearsInBusiness":
                            widget.customerData.howOldIsTheBusiness,
                        "highestDegree": widget.customerData.degreename,
                        "expCurrentEmployer":
                            widget.customerData.currentworkexp,
                        "workExp": widget.customerData.totalworkExp,
                        "monthlySalary": widget.customerData.netmonthlySalary,
                        "ongoingMonthlyObligation": null,
                        "mode": widget.customerData.salarymode
                            .toString()
                            .toLowerCase(),
                        "loanType": widget.customerData.loanType,
                        "loanAmount": widget.customerData.loanAmount,
                        "residentialStatus":
                            widget.customerData.residentialStatus,
                        "addressType": widget.customerData.address,
                        "dob": widget.customerData.dob,
                        "pinCode": widget.customerData.pincode,
                        "mobileNumber": widget.customerData.mobileNumber,
                        "emailID": widget.customerData.emailID,
                        "panCardNumber": null,
                        "panCard": null,
                        "aadharCardNumber": null,
                        "aadharCard": null,
                        "pastLoans": widget.customerData.pastLoans,
                        "gender": widget.customerData.gender,
                        "maritalStatus": widget.customerData.maritalStatus,
                        "full_name": widget.customerData.fullName,
                        "employment_type": widget.customerData.employmentType,*/

                      log(data1.toString());

                      //   "first_name": widget.customerData.fullName
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
                      //   "last_name": widget.customerData.fullName
                      //       .toString()
                      //       .split(" ")
                      //       .last,
                      //   "mobile": widget.customerData.mobileNumber,
                      //   "pin_code": widget.customerData.pincode,
                      //   "date_of_birth": widget.customerData.dob,
                      //   "company": widget.customerData.businessName,
                      //   "monthly_salary": widget.customerData.netmonthlySalary,
                      //   "load_type": widget.customerData.loanType,
                      //   "load_amount": widget.customerData.loanAmount,
                      //   "disbursed_tenure": widget.customerData.loanTenure,
                      //   "mode_of_salary": widget.customerData.salarymode,
                      //   "load_purpose": widget.customerData.purposeOfLoan,
                      //   "email": widget.customerData.emailID,
                      //   "gender": widget.customerData.gender,
                      //   "marital_status": widget.customerData.maritalStatus,
                      //   "past_loans": widget.customerData.pastLoans,
                      //   "address_type": widget.customerData.address,
                      //   "residential_status":
                      //       widget.customerData.residentialStatus,
                      //   "work_experience": widget.customerData.totalworkExp,
                      //   "exp_with_current_employer":
                      //       widget.customerData.currentworkexp,
                      //   "highest_degree": widget.customerData.degreename,
                      //   "employer_name": widget.customerData.empname,
                      //   "firm_name": widget.customerData.businessName,
                      //   "occupation": widget.customerData.professionName,
                      //   "employment_type": widget.customerData.employmentType,
                      //   "organisation_type": widget.customerData.organisationType,
                      //   "premise_ownership_status":
                      //       widget.customerData.ownershipStatus,
                      //   "primary_account": widget.customerData.primaryBankAccount,
                      //   "client_income": widget.customerData.annualIncome,
                      //   "loan_amount": widget.customerData.loanAmount,
                      //   "name": widget.customerData.fullName,
                      //   "business_industry":
                      //       widget.customerData.industryOfBusiness,
                      //   "how_old_business":
                      //       widget.customerData.howOldIsTheBusiness,
                      //   "business_health": widget.customerData.healthOfBusiness,
                      //   "profitability_years":
                      //       widget.customerData.latestYearsOfProfitability,
                      //   "income_method":
                      //       widget.customerData.incomeOfSelectedMethod
                      // };

                      bool isadded = await sendData(data1);
                      print('submit pressed after api $isadded');

                      if (isadded) {
                        print(widget.customerData.userID);
                        ProductsArguments args = new ProductsArguments(
                            widget.customerData.userID,
                            null,
                            widget.customerData.emailID);

                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => CongratulationsScreen(
                                      id: widget.customerData.userID,
                                      email: widget.customerData.emailID,
                                      loanType: widget.customerData.loanType,
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
                  child: Text(
                    widget.customerData.loanType == "Personal"
                        ? 'Submit'
                        : 'Next',
                    style: Theme.of(context).textTheme.button.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> sendData(Map<String, dynamic> data) async {
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
      log(response.data.toString(), name: 'response');
      if (response.statusCode == 200) {
        print(response.data["data"]["id"].toString());
        widget.customerData.userID = response.data["data"]["id"].toString();
        return true;
      }
      return false;
    } on DioError catch (e) {
      print(e.response.data);
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
