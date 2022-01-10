import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:financial_freedom/old/Model/ProductsArguments.dart';
import 'package:financial_freedom/old/customer/income_details.dart';
import 'package:financial_freedom/old/widgets/common/ApiConstants.dart';
import 'package:financial_freedom/old/widgets/common/SharedPref.dart';
import 'package:financial_freedom/old/widgets/common/mycolors.dart';
import 'package:financial_freedom/old/widgets/common/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'customer-profile.dart';

class EditProfile extends StatefulWidget {
  final Map data;
  EditProfile({this.data});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool isEdit = false;
  TextEditingController name = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController pinCode = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController company = TextEditingController();
  TextEditingController fieldOfWork = TextEditingController();
  TextEditingController designation = TextEditingController();
  TextEditingController monthlySalary = TextEditingController();
  TextEditingController emi = TextEditingController();
  TextEditingController loanType = TextEditingController();
  TextEditingController loanAmount = TextEditingController();
  TextEditingController modeOfSalary = TextEditingController();
  TextEditingController salaryBank = TextEditingController();
  TextEditingController loanPurpose = TextEditingController();
  TextEditingController status = TextEditingController();
  TextEditingController email = TextEditingController();
  // String gender;
  // String maritalStatus;
  // List<String> genderList = [];
  // List<String> maritalStatusList = [];
  String pastLoan;
  TextEditingController addressType = TextEditingController();
  String residentialStatus;
  TextEditingController workExperience = TextEditingController();
  TextEditingController expWithCurrentEmployer = TextEditingController();
  TextEditingController highestDegree = TextEditingController();
  TextEditingController yearsInBusiness = TextEditingController();
  TextEditingController totalLoans = TextEditingController();
  TextEditingController employerName = TextEditingController();
  TextEditingController firmName = TextEditingController();
  TextEditingController occupation = TextEditingController();
  String employmentType;
  String organizationType;
  String industry;
  TextEditingController workingFromHome = TextEditingController();
  String premiseOwnershipStatus;
  TextEditingController informClientIncome = TextEditingController();
  TextEditingController primaryAccount = TextEditingController();
  TextEditingController clientIncome = TextEditingController();
  TextEditingController accountHolderName = TextEditingController();
  TextEditingController accountNumber = TextEditingController();
  TextEditingController ifscCode = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController businessIndustry = TextEditingController();
  TextEditingController howOldBusiness = TextEditingController();
  TextEditingController businessHealth = TextEditingController();
  TextEditingController profitabilityYears = TextEditingController();
  TextEditingController incomeMethod = TextEditingController();
  TextEditingController ongoingMonthlyObligations = TextEditingController();
  TextEditingController tenure = TextEditingController();
  @override
  void initState() {
    super.initState();
    name.text = widget.data["name"];
    mobile.text = widget.data["mobile"];
    pinCode.text = widget.data["pin_code"];
    dob.text =
        widget.data["date_of_birth"].toString().split("-").reversed.join("-");
    company.text = widget.data["company"];
    fieldOfWork.text = widget.data["field_of_work"];
    designation.text = widget.data["designation"];
    monthlySalary.text = widget.data["monthly_salary"];
    emi.text = widget.data["monthly_emi"];
    loanType.text = widget.data["load_type"];
    loanAmount.text = widget.data["load_amount"];
    modeOfSalary.text = widget.data["mode_of_salary"];
    salaryBank.text = widget.data["salary_bank"];
    loanPurpose.text = widget.data["load_purpose"];
    status.text = widget.data["status"];
    email.text = widget.data["email"];
    // gender.text = widget.data["gender"];
    // maritalStatus.text = widget.data["marital_status"];
    pastLoan = widget.data["past_loans"];
    addressType.text = widget.data["address_type"];
    residentialStatus = widget.data["residential_status"];
    workExperience.text = widget.data["work_experience"];
    expWithCurrentEmployer.text = widget.data["exp_with_current_employer"];
    highestDegree.text = widget.data["highest_degree"];
    yearsInBusiness.text = widget.data["years_in_business"];
    totalLoans.text = widget.data["total_loans"];
    employerName.text = widget.data["employer_name"];
    firmName.text = widget.data["firm_name"];
    occupation.text = widget.data["occupation"];
    employmentType = widget.data["employment_type"];
    organizationType = widget.data["organisation_type"];
    industry = widget.data["industry"];
    workingFromHome.text = widget.data["working_from_home"];
    premiseOwnershipStatus = widget.data["premise_ownership_status"];
    informClientIncome.text = widget.data["inform_client_income"];
    primaryAccount.text = widget.data["primary_account"];
    clientIncome.text = widget.data["client_income"];
    accountHolderName.text = widget.data["account_holder_name"];
    accountNumber.text = widget.data["account_number"];
    ifscCode.text = widget.data["ifsc_code"];
    address.text = widget.data["address"];
    businessIndustry.text = widget.data["business_industry"];
    howOldBusiness.text = widget.data["how_old_business"];
    businessHealth.text = widget.data["business_health"];
    profitabilityYears.text = widget.data["profitability_years"];
    incomeMethod.text = widget.data["income_method"];
    ongoingMonthlyObligations.text = widget.data["ongoing_monthly_obligations"];
    tenure.text = widget.data["disbursed_tenure"];
  }

  @override
  Widget build(BuildContext context) {
    // log(widget.data.toString());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Icon(
                          Icons.arrow_back,
                          color: backgroundColor(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                'Customer Profile',
                style: TextStyle(
                  color: MyColors.backgroundColor(),
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 8.0,
                ),
                child: InkWell(
                  onTap: !isEdit
                      ? () {
                          setState(() {
                            isEdit = true;
                          });
                        }
                      : () async {
                          Map<String, dynamic> data = {
                            "id": widget.data["id"],
                            "full_name": name.text,
                            "primaryAccount": primaryAccount.text,
                            "informClientIncome": informClientIncome.text,
                            "ownershipStatus": premiseOwnershipStatus,
                            "workingFromHome": workingFromHome.text,
                            "industry": industry,
                            "organisationType": organizationType,
                            "employmentType": employmentType,
                            "occupation": occupation.text,
                            "tenure": tenure.text,
                            "firmName": firmName.text,
                            "companyName": company.text,
                            "purposeOfLoan": loanPurpose.text,
                            "totalLoans": totalLoans.text,
                            "yearsInBusiness": yearsInBusiness.text,
                            "highestDegree": highestDegree.text,
                            "expCurrentEmployer": expWithCurrentEmployer.text,
                            "workExp": workExperience.text,
                            "monthlySalary": monthlySalary.text,
                            "ongoingMonthlyObligation":
                                ongoingMonthlyObligations.text,
                            "mode": modeOfSalary.text,
                            "loanType": loanType.text,
                            "loanAmount": loanAmount.text,
                            "residentialStatus": residentialStatus,
                            "addressType": addressType.text,
                            "dob": dob.text.split("-").reversed.join("-"),
                            "pinCode": pinCode.text,
                            "mobileNumber": mobile.text,
                            "emailID": email.text,
                            "panCardNumber": "",
                            "panCard": "",
                            "aadharCardNumber": "",
                            "aadharCard": "",
                            "pastLoans": pastLoan,
                            "gender": "",
                            "maritalStatus": "",
                            "primary_account": primaryAccount.text,
                            "employment_type": employmentType,
                          };

                          log(json.encode(data));

                          bool isadded = await sendData(data);
                          print('submit pressed after api $isadded');

                          if (isadded) {
                            ProductsArguments args = new ProductsArguments(
                                data['id'].toString(), null, email.text);
                            Navigator.pushNamedAndRemoveUntil(
                                context, Routes.home, (route) => false);
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, _, __) =>
                                    CustomerProfile(
                                  customerID: data['id'].toString(),
                                ),
                              ),
                            );
                          }
                        },
                  child: Container(
                    height: 35,
                    width: 80,
                    decoration: BoxDecoration(
                      color: !isEdit ? backgroundColor() : yellowColor(),
                      borderRadius: BorderRadius.circular(
                        10.0,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        !isEdit ? 'Edit' : 'Save',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: !isEdit ? Colors.white : backgroundColor(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Theme(
              data: ThemeData(
                inputDecorationTheme: InputDecorationTheme(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
                ),
                visualDensity: VisualDensity.compact,
              ),
              child: Container(
                height: 1000,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Hero(
                        tag: 'profile',
                        child: SizedBox(
                          height: 100,
                          width: 130,
                          child: CircleAvatar(
                            backgroundColor: MyColors.yellowColor(),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Image.network(
                                'https://image.flaticon.com/icons/png/512/1621/1621561.png',
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 15.0,
                        ),
                        child: Text(
                          'Case ID : #${widget.data['id']}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      personalInformation(),
                      addressW(),
                      // kyc(),
                      employmentType != "Self Employed"
                          ? occupationDetails()
                          : SizedBox.shrink(),
                      employmentType != "Salaried"
                          ? occupationDetailsSelfEmployed()
                          : SizedBox.shrink(),
                      obligation(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget personalInformation() {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Container(
            height: 30,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[400],
                    offset: Offset(1, -2),
                    blurRadius: 5),
                BoxShadow(
                    color: Colors.grey[400],
                    offset: Offset(-1, 2),
                    blurRadius: 5),
              ],
              color: yellowColor(),
              borderRadius: BorderRadius.circular(
                30.0,
              ),
            ),
            child: Center(
              child: Text(
                'Personal Information',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: backgroundColor(),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Row(
            children: [
              Text(
                'Name',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: CupertinoTextField(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(5.0)),
            readOnly: !isEdit,
            controller: name,
            placeholderStyle: TextStyle(
              color: Colors.black,
            ),
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Row(
                      children: [
                        Text(
                          'Date of Birth',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: CupertinoTextField(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 12.0),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(5.0)),
                      onTap: !isEdit
                          ? null
                          : () async {
                              DateTime date = await showDatePicker(
                                context: context,
                                initialDate: dob.text.isEmpty
                                    ? DateTime.now()
                                    : DateTime.parse(dob.text
                                        .toString()
                                        .split("-")
                                        .reversed
                                        .join("-")),
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2100),
                              );

                              setState(() {
                                dob.text =
                                    "${date.day.toString().padLeft(2, "0")}-${date.month.toString().padLeft(2, "0")}-${date.year}";
                              });
                            },
                      readOnly: true,
                      controller: dob,
                      placeholderStyle: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Expanded(
            //   child: Column(
            //     children: [
            //       Padding(
            //         padding: const EdgeInsets.only(left: 20.0),
            //         child: Row(
            //           children: [
            //             Text(
            //               'Location',
            //               style: TextStyle(
            //                 color: Colors.white,
            //                 fontSize: 16,
            //                 fontWeight: FontWeight.w700,
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //       SizedBox(
            //         height: 10,
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.symmetric(horizontal: 20.0),
            //         child: Container(
            //           color: Colors.white,
            //           child: CupertinoTextField(
            // padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),

            // readOnly: !isEdit,
            //             placeholder: 'Delhi',
            //             placeholderStyle: TextStyle(
            //               color: Colors.black,
            //             ),
            //             decoration: BoxDecoration(
            //               color: Colors.white,
            //             ),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Row(
            children: [
              Text(
                'Email',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: CupertinoTextField(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(5.0)),
            readOnly: true,
            controller: email,
            placeholderStyle: TextStyle(
              color: Colors.black,
            ),
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Row(
                      children: [
                        Text(
                          'Mobile Number',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: CupertinoTextField(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 12.0),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(5.0)),
                      readOnly: !isEdit,
                      controller: mobile,
                      placeholderStyle: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Expanded(
            //   child: Column(
            //     children: [],
            //   ),
            // )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        // Row(
        //   children: [
        //     Expanded(
        //       child: Padding(
        //         padding: const EdgeInsets.only(left: 20.0),
        //         child: Row(
        //           children: [
        //             Text(
        //               'Gender',
        //               style: TextStyle(
        //                 color: Colors.white,
        //                 fontSize: 16,
        //                 fontWeight: FontWeight.w700,
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ),
        //     Padding(
        //       padding: const EdgeInsets.symmetric(horizontal: 20.0),
        //       child: Container(
        //         height: 28,
        //         width: 135,
        //         color: Colors.white,
        //         child: Padding(
        //           padding: const EdgeInsets.symmetric(horizontal: 10.0),
        //           child: DropdownButtonFormField<String>(
        //             icon: Icon(
        //               Icons.keyboard_arrow_down,
        //             ),
        //             isExpanded: true,
        //             elevation: 5,
        //             value: gender,
        //
        //             style: TextStyle(
        //               color: Colors.black,
        //             ),
        //             items: <String>[
        //               'Choose',
        //             ].map<DropdownMenuItem<String>>((String value) {
        //               return DropdownMenuItem<String>(
        //                 value: value,
        //                 child: Text(value),
        //               );
        //             }).toList(),
        //             hint: Text(
        //               "",
        //               style: TextStyle(
        //                   color: Colors.black,
        //                   fontSize: 16,
        //                   fontWeight: FontWeight.w600),
        //             ),
        //             onChanged: !isEdit ? null : (String value) {
        //               setState(() {});
        //             },
        //           ),
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
        // SizedBox(
        //   height: 10,
        // ),
        // Row(
        //   children: [
        //     Expanded(
        //       child: Padding(
        //         padding: const EdgeInsets.only(left: 20.0),
        //         child: Row(
        //           children: [
        //             Text(
        //               'Marital Status',
        //               style: TextStyle(
        //                 color: Colors.white,
        //                 fontSize: 16,
        //                 fontWeight: FontWeight.w700,
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ),
        //     Padding(
        //       padding: const EdgeInsets.symmetric(horizontal: 20.0),
        //       child: Container(
        //         height: 28,
        //         width: 135,
        //         color: Colors.white,
        //         child: Padding(
        //           padding: const EdgeInsets.symmetric(horizontal: 10.0),
        //           child: DropdownButtonFormField<String>(
        //             icon: Icon(
        //               Icons.keyboard_arrow_down,
        //             ),
        //             isExpanded: true,
        //             elevation: 5,
        //             value: 'Choose',
        //
        //             style: TextStyle(
        //               color: Colors.black,
        //             ),
        //             items: <String>[
        //               'Choose',
        //             ].map<DropdownMenuItem<String>>((String value) {
        //               return DropdownMenuItem<String>(
        //                 value: value,
        //                 child: Text(value),
        //               );
        //             }).toList(),
        //             hint: Text(
        //               "",
        //               style: TextStyle(
        //                   color: Colors.black,
        //                   fontSize: 16,
        //                   fontWeight: FontWeight.w600),
        //             ),
        //             onChanged: !isEdit ? null : (String value) {
        //               setState(() {});
        //             },
        //           ),
        //         ),
        //       ),
        //     ),
        //   ],
        // )
      ],
    );
  }

  Widget addressW() {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Container(
            height: 30,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[400],
                    offset: Offset(1, -2),
                    blurRadius: 5),
                BoxShadow(
                    color: Colors.grey[400],
                    offset: Offset(-1, 2),
                    blurRadius: 5),
              ],
              color: yellowColor(),
              borderRadius: BorderRadius.circular(
                30.0,
              ),
            ),
            child: Center(
              child: Text(
                'Address',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: backgroundColor(),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Row(
            children: [
              Text(
                'Residential Address',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 10.0),
          child: Text(
            '''please fill your customer's complete current residential address, here. We recommend match with their address proof.''',
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                readOnly: !isEdit,
                controller: address,
                maxLines: 4,
                minLines: 1,
              ),
              // Text(
              //   'Pratap Nagar Udaipur RJ',
              //   style: TextStyle(
              //     fontSize: 16,
              //     fontWeight: FontWeight.w700,
              //   ),
              // ),
              // Divider(
              //   color: Colors.black,
              // ),
              // Row(
              //   children: [
              //     Expanded(
              //       child: Column(
              //         children: [
              //           Padding(
              //             padding: const EdgeInsets.only(left: 2.0),
              //             child: Row(
              //               children: [
              //                 Text(
              //                   'Pincode',
              //                   style: TextStyle(
              //                     fontSize: 16,
              //                     fontWeight: FontWeight.w700,
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ),
              //           SizedBox(
              //             height: 10,
              //           ),
              //           Padding(
              //             padding:
              //                 const EdgeInsets.symmetric(horizontal: 2.0),
              //             child: Container(
              //               color: Colors.white,
              //               child: CupertinoTextField(
              // padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),

              // readOnly: !isEdit,
              //                 placeholder: '313001',
              //                 placeholderStyle: TextStyle(
              //                   color: Colors.black,
              //                 ),
              //                 decoration: BoxDecoration(
              //                   border: Border.all(
              //                     color: Colors.black,
              //                   ),
              //                   color: Colors.white,
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //     Expanded(
              //       child: Column(
              //         children: [
              //           Padding(
              //             padding: const EdgeInsets.only(left: 2.0),
              //             child: Row(
              //               children: [
              //                 Text(
              //                   'City',
              //                   style: TextStyle(
              //                     fontSize: 16,
              //                     fontWeight: FontWeight.w700,
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ),
              //           SizedBox(
              //             height: 10,
              //           ),
              //           Padding(
              //             padding:
              //                 const EdgeInsets.symmetric(horizontal: 2.0),
              //             child: Container(
              //               color: Colors.white,
              //               child: CupertinoTextField(
              // padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),

              // readOnly: !isEdit,
              //                 placeholder: 'Udaipur',
              //                 placeholderStyle: TextStyle(
              //                   color: Colors.black,
              //                 ),
              //                 decoration: BoxDecoration(
              //                   border: Border.all(
              //                     color: Colors.black,
              //                   ),
              //                   color: Colors.white,
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ],
              //       ),
              //     )
              //   ],
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              // Row(
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.only(left: 5.0),
              //       child: Row(
              //         children: [
              //           Text(
              //             'State',
              //             style: TextStyle(
              //               fontSize: 16,
              //               fontWeight: FontWeight.w700,
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //     Padding(
              //       padding: const EdgeInsets.symmetric(horizontal: 20.0),
              //       child: Container(
              //         height: 28,
              //         width: 135,
              //         decoration: BoxDecoration(
              //           border: Border.all(
              //             color: Colors.black,
              //           ),
              //           color: Colors.white,
              //         ),
              //         child: Padding(
              //           padding:
              //               const EdgeInsets.symmetric(horizontal: 10.0),
              //           child: DropdownButtonFormField<String>(
              //             icon: Icon(
              //               Icons.keyboard_arrow_down,
              //             ),
              //             isExpanded: true,
              //             elevation: 5,
              //             value: 'Choose',
              //
              //             style: TextStyle(
              //               color: Colors.black,
              //             ),
              //             items: <String>[
              //               'Choose',
              //             ].map<DropdownMenuItem<String>>((String value) {
              //               return DropdownMenuItem<String>(
              //                 value: value,
              //                 child: Text(value),
              //               );
              //             }).toList(),
              //             hint: Text(
              //               "",
              //               style: TextStyle(
              //                   color: Colors.black,
              //                   fontSize: 16,
              //                   fontWeight: FontWeight.w600),
              //             ),
              //             onChanged: !isEdit ? null : (String value) {
              //               setState(() {});
              //             },
              //           ),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        // Row(
        //   children: [
        //     Expanded(
        //       child: Padding(
        //         padding: const EdgeInsets.only(left: 20.0),
        //         child: Row(
        //           children: [
        //             Text(
        //               'Address On Aadhaar',
        //               style: TextStyle(
        //                 color: Colors.white,
        //                 fontSize: 16,
        //                 fontWeight: FontWeight.w700,
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ),
        //     Padding(
        //       padding: const EdgeInsets.symmetric(horizontal: 20.0),
        //       child: Container(
        //         height: 28,
        //         width: 135,
        //         color: Colors.white,
        //         child: Padding(
        //           padding: const EdgeInsets.symmetric(horizontal: 10.0),
        //           child: DropdownButtonFormField<String>(
        //             icon: Icon(
        //               Icons.keyboard_arrow_down,
        //             ),
        //             isExpanded: true,
        //             elevation: 5,
        //             value: 'Choose',
        //
        //             style: TextStyle(
        //               color: Colors.black,
        //             ),
        //             items: <String>[
        //               'Choose',
        //             ].map<DropdownMenuItem<String>>((String value) {
        //               return DropdownMenuItem<String>(
        //                 value: value,
        //                 child: Text(value),
        //               );
        //             }).toList(),
        //             hint: Text(
        //               "",
        //               style: TextStyle(
        //                   color: Colors.black,
        //                   fontSize: 16,
        //                   fontWeight: FontWeight.w600),
        //             ),
        //             onChanged: !isEdit ? null : (String value) {
        //               setState(() {});
        //             },
        //           ),
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                children: [
                  Text(
                    'Residential Status',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: DropdownButtonFormField<String>(
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                    ),
                    isExpanded: true,
                    elevation: 5,
                    value: residentialStatus,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    items: <String>[
                      'Owned',
                      'Rented',
                      'Parental Owned',
                      'Accomadation provided by employer',
                      'PG',
                      'Sharing with Friends',
                      'Living with Relatives'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    hint: Text(
                      "",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    onChanged: !isEdit
                        ? null
                        : (String value) {
                            setState(() {
                              residentialStatus = value;
                            });
                          },
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget kyc() {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Container(
            height: 30,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[400],
                    offset: Offset(1, -2),
                    blurRadius: 5),
                BoxShadow(
                    color: Colors.grey[400],
                    offset: Offset(-1, 2),
                    blurRadius: 5),
              ],
              color: yellowColor(),
              borderRadius: BorderRadius.circular(
                30.0,
              ),
            ),
            child: Center(
              child: Text(
                'KYC',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: backgroundColor(),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Row(
            children: [
              Text(
                'Aadhaar Card',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 2 - 38,
                  height: 150,
                  child: Card(
                    color: Colors.white,
                    elevation: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Image.network(
                          'https://findicons.com/files/icons/1637/file_icons_vs_2/256/jpg.png',
                          scale: 2.5,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'images1.jpg',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 2 - 38,
                  height: 150,
                  child: Card(
                    color: Colors.white,
                    elevation: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Image.network(
                          'https://img.icons8.com/cotton/2x/upload.png',
                          scale: 2.5,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Row(
            children: [
              Text(
                'PAN CARD',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 2 - 38,
                  height: 150,
                  child: Card(
                    color: Colors.white,
                    elevation: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Image.network(
                          'https://findicons.com/files/icons/1637/file_icons_vs_2/256/jpg.png',
                          scale: 2.5,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'images1.jpg',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 2 - 38,
                  height: 150,
                  child: Card(
                    color: Colors.white,
                    elevation: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Image.network(
                          'https://img.icons8.com/cotton/2x/upload.png',
                          scale: 2.5,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget occupationDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Container(
            height: 30,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[400],
                    offset: Offset(1, -2),
                    blurRadius: 5),
                BoxShadow(
                    color: Colors.grey[400],
                    offset: Offset(-1, 2),
                    blurRadius: 5),
              ],
              color: yellowColor(),
              borderRadius: BorderRadius.circular(
                30.0,
              ),
            ),
            child: Center(
              child: Text(
                'Occupation Details - Salaried',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: backgroundColor(),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Row(
            children: [
              Text(
                'Occupation',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: CupertinoTextField(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(5.0)),
            readOnly: !isEdit,
            controller: occupation,
            placeholderStyle: TextStyle(
              color: Colors.black,
            ),
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Row(
            children: [
              Text(
                'Company',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: CupertinoTextField(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(5.0)),
            readOnly: !isEdit,
            controller: company,
            placeholderStyle: TextStyle(
              color: Colors.black,
            ),
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Row(
            children: [
              Text(
                'Industry',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: DropdownButtonFormField<String>(
            icon: Icon(
              Icons.keyboard_arrow_down,
            ),
            isExpanded: true,
            elevation: 5,
            value: industry,
            style: TextStyle(
              color: Colors.black,
            ),
            items: <String>[
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
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  maxLines: 1,
                ),
              );
            }).toList(),
            hint: Text(
              "",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
            onChanged: !isEdit
                ? null
                : (String value) {
                    setState(() {
                      industry = value;
                    });
                  },
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Row(
            children: [
              Text(
                'Employment Type',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: DropdownButtonFormField<String>(
            icon: Icon(
              Icons.keyboard_arrow_down,
            ),
            isExpanded: true,
            elevation: 5,
            value: employmentType,
            style: TextStyle(
              color: Colors.black,
            ),
            items: <String>[
              'Salaried',
              'Self Employed',
              'Salaried + Self-Employed',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  maxLines: 1,
                ),
              );
            }).toList(),
            hint: Text(
              "",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
            onChanged: !isEdit
                ? null
                : (String value) {
                    setState(() {
                      employmentType = value;
                    });
                  },
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Row(
            children: [
              Text(
                'Organisation Type',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: DropdownButtonFormField<String>(
            icon: Icon(
              Icons.keyboard_arrow_down,
            ),
            isExpanded: true,
            elevation: 5,
            value: organizationType,
            style: TextStyle(
              color: Colors.black,
            ),
            items: <String>[
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
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            hint: Text(
              "",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
            onChanged: !isEdit
                ? null
                : (String value) {
                    print(value);
                    setState(() {
                      organizationType = value;
                    });
                  },
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Row(
            children: [
              Text(
                'Monthly Salary (INR)',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: CupertinoTextField(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(5.0)),
            readOnly: !isEdit,
            controller: monthlySalary,
            placeholderStyle: TextStyle(
              color: Colors.black,
            ),
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Row(
            children: [
              Text(
                'Work Experience',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: CupertinoTextField(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(5.0)),
            readOnly: !isEdit,
            controller: workExperience,
            placeholderStyle: TextStyle(
              color: Colors.black,
            ),
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget occupationDetailsSelfEmployed() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Container(
            height: 30,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[400],
                    offset: Offset(1, -2),
                    blurRadius: 5),
                BoxShadow(
                    color: Colors.grey[400],
                    offset: Offset(-1, 2),
                    blurRadius: 5),
              ],
              color: yellowColor(),
              borderRadius: BorderRadius.circular(
                30.0,
              ),
            ),
            child: Center(
              child: Text(
                'Occupation Details - Self Employed',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: backgroundColor()),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Row(
            children: [
              Text(
                'Business Name *',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: CupertinoTextField(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(5.0)),
            readOnly: !isEdit,
            controller: firmName,
            placeholderStyle: TextStyle(
              color: Colors.black,
            ),
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Row(
            children: [
              Text(
                'Business Incorporated Years *',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: CupertinoTextField(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(5.0)),
            readOnly: !isEdit,
            controller: yearsInBusiness,
            placeholderStyle: TextStyle(
              color: Colors.black,
            ),
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Row(
            children: [
              Text(
                'Business Organisation Type',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: DropdownButtonFormField<String>(
            icon: Icon(
              Icons.keyboard_arrow_down,
            ),
            isExpanded: true,
            elevation: 5,
            value: organizationType,
            style: TextStyle(
              color: Colors.black,
            ),
            items: <String>[
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
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  maxLines: 1,
                ),
              );
            }).toList(),
            hint: Text(
              "",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
            onChanged: !isEdit
                ? null
                : (String value) {
                    setState(() {
                      organizationType = value;
                    });
                  },
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Row(
            children: [
              Text(
                'Industry *',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: DropdownButtonFormField<String>(
            icon: Icon(
              Icons.keyboard_arrow_down,
            ),
            isExpanded: true,
            elevation: 5,
            value: industry,
            style: TextStyle(
              color: Colors.black,
            ),
            items: <String>[
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
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, maxLines: 1),
              );
            }).toList(),
            hint: Text(
              "",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
            onChanged: !isEdit
                ? null
                : (String value) {
                    setState(() {
                      industry = value;
                    });
                  },
          ),
        ),

        // SizedBox(
        //   height: 10,
        // ),
        // Padding(
        //   padding: const EdgeInsets.only(left: 20.0),
        //   child: Row(
        //     children: [
        //       Text(
        //         'No. of Employees of the Business *',
        //         style: TextStyle(
        //           color: Colors.white,
        //           fontSize: 16,
        //           fontWeight: FontWeight.w700,
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        // SizedBox(
        //   height: 10,
        // ),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
        //   child: Container(
        //     color: Colors.white,
        //     child: CupertinoTextField(
        // padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),

        // readOnly: !isEdit,
        //       controller: yearsInBusiness,
        //       placeholderStyle: TextStyle(
        //         color: Colors.black,
        //       ),
        //       decoration: BoxDecoration(
        //         color: Colors.white,
        //       ),
        //     ),
        //   ),
        // ),
        // SizedBox(
        //   height: 10,
        // ),
        // Padding(
        //   padding: const EdgeInsets.only(left: 20.0),
        //   child: Row(
        //     children: [
        //       Text(
        //         'Income Declaration Method',
        //         style: TextStyle(
        //           color: Colors.white,
        //           fontSize: 16,
        //           fontWeight: FontWeight.w700,
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        // SizedBox(
        //   height: 10,
        // ),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
        //   child: Container(
        //     height: 28,
        //     width: 135,
        //     color: Colors.white,
        //     child: Padding(
        //       padding: const EdgeInsets.symmetric(horizontal: 10.0),
        //       child: DropdownButtonFormField<String>(
        //         icon: Icon(
        //           Icons.keyboard_arrow_down,
        //         ),
        //         isExpanded: true,
        //         elevation: 5,
        //         value: 'Choose',
        //
        //         style: TextStyle(
        //           color: Colors.black,
        //         ),
        //         items: <String>[
        //           'Choose',
        //         ].map<DropdownMenuItem<String>>((String value) {
        //           return DropdownMenuItem<String>(
        //             value: value,
        //             child: Text(value),
        //           );
        //         }).toList(),
        //         hint: Text(
        //           "",
        //           style: TextStyle(
        //               color: Colors.black,
        //               fontSize: 16,
        //               fontWeight: FontWeight.w600),
        //         ),
        //         onChanged: !isEdit ? null : (String value) {
        //           setState(() {});
        //         },
        //       ),
        //     ),
        //   ),
        // ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                Text(
                  'Annual Business Income in INR',
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  '  (wrt declaration selected above)',
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: CupertinoTextField(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(5.0)),
            readOnly: !isEdit,
            controller: clientIncome,
            placeholderStyle: TextStyle(
              color: Colors.black,
            ),
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Row(
            children: [
              Text(
                'Business Premise Ownership Status',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: DropdownButtonFormField<String>(
            icon: Icon(
              Icons.keyboard_arrow_down,
            ),
            isExpanded: true,
            elevation: 5,
            value: premiseOwnershipStatus,
            style: TextStyle(
              color: Colors.black,
            ),
            items: <String>[
              "Business Property - Owned",
              "Business Property - Rented",
              "Business Operated from Owned Residence",
              "Business Operated from Rented Residence",
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            hint: Text(
              "",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
            onChanged: !isEdit
                ? null
                : (String value) {
                    setState(() {
                      premiseOwnershipStatus = value;
                    });
                  },
          ),
        ),

        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Row(
            children: [
              Text(
                'Any Past Loan',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: DropdownButtonFormField<String>(
            icon: Icon(
              Icons.keyboard_arrow_down,
            ),
            isExpanded: true,
            elevation: 5,
            value: pastLoan,
            style: TextStyle(
              color: Colors.black,
            ),
            items: <String>["Yes", "No"]
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            hint: Text(
              "",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
            onChanged: !isEdit
                ? null
                : (String value) {
                    setState(() {
                      pastLoan = value;
                    });
                  },
          ),
        ),

        // SizedBox(
        //   height: 20,
        // ),
        // Padding(
        //   padding: const EdgeInsets.only(left: 20.0),
        //   child: Row(
        //     children: [
        //       Text(
        //         'Answer Following Questions for your Customer :',
        //         style: TextStyle(
        //           color: Colors.white,
        //           fontStyle: FontStyle.italic,
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        // SizedBox(
        //   height: 20,
        // ),
        // ListTile(
        //   title: Text(
        //     'Does the customer currently has a Home Loan ?',
        //     style: TextStyle(
        //       color: Colors.white,
        //     ),
        //   ),
        //   trailing: CupertinoSwitch(
        //     value: true,
        //     activeColor: yellowColor(),
        //     onChanged: (a) {},
        //   ),
        // ),
        // ListTile(
        //   title: Text(
        //     'Does the customer currently has Loan-Against-Property ?',
        //     style: TextStyle(
        //       color: Colors.white,
        //     ),
        //   ),
        //   trailing: CupertinoSwitch(
        //     value: true,
        //     activeColor: yellowColor(),
        //     onChanged: (a) {},
        //   ),
        // ),
        // ListTile(
        //   title: Text(
        //     'Does the customer currently has any Car Loan ?',
        //     style: TextStyle(
        //       color: Colors.white,
        //     ),
        //   ),
        //   trailing: CupertinoSwitch(
        //     value: true,
        //     activeColor: yellowColor(),
        //     onChanged: (a) {},
        //   ),
        // ),
        // ListTile(
        //   title: Text(
        //     'Does the customer currently or in past 2 years had a Business Loan ?',
        //     style: TextStyle(
        //       color: Colors.white,
        //     ),
        //   ),
        //   trailing: CupertinoSwitch(
        //     value: true,
        //     activeColor: yellowColor(),
        //     onChanged: (a) {},
        //   ),
        // )
      ],
    );
  }

  Widget obligation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Container(
            height: 30,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[400],
                    offset: Offset(1, -2),
                    blurRadius: 5),
                BoxShadow(
                    color: Colors.grey[400],
                    offset: Offset(-1, 2),
                    blurRadius: 5),
              ],
              color: yellowColor(),
              borderRadius: BorderRadius.circular(
                30.0,
              ),
            ),
            child: Center(
              child: Text(
                'Obligations',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: backgroundColor(),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Row(
            children: [
              Text(
                'Total Monthly EMI Obligation in INR',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Row(
            children: [
              Text(
                '(including Credit Cards, Loans, Insurance & Others)',
                style: TextStyle(
                  color: Colors.black,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: CupertinoTextField(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(5.0)),
            readOnly: !isEdit,
            controller: ongoingMonthlyObligations,
            placeholderStyle: TextStyle(
              color: Colors.black,
            ),
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        // Text(
        //   'Generate Customer Loan Application Form',
        //   style: TextStyle(
        //     color: Colors.white,
        //     fontSize: 18,
        //     fontWeight: FontWeight.w700,
        //   ),
        // ),
        // SizedBox(
        //   height: 20,
        // ),
        // Padding(
        //   padding: const EdgeInsets.only(left: 20.0),
        //   child: Row(
        //     children: [
        //       Text(
        //         'Press Submit after completing the form with final changes\nin consultaion with the Customer.',
        //         style: TextStyle(
        //           color: Colors.white,
        //           fontWeight: FontWeight.w700,
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        // Padding(
        //   padding: const EdgeInsets.only(left: 20.0),
        //   child: Row(
        //     children: [
        //       Text(
        //         'Tip: Sumit when your customer is satisfied and finalised the\nLoan Amount and interest rate, post CIBIL report generated\nby the selected Lender. Wee will keep you posted, check for\nthe same in Product Information tab.',
        //         style: TextStyle(
        //           color: Colors.white,
        //           fontStyle: FontStyle.italic,
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        // SizedBox(
        //   height: 20,
        // ),
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: InkWell(
        //     onTap: () async {
        //       print(dob.text.split("-").reversed.join("-"));
        //       Map<String, dynamic> data = {
        //         "id": widget.data["id"],
        //         "full_name": name.text,
        //         "primaryAccount": primaryAccount.text,
        //         "informClientIncome": informClientIncome.text,
        //         "ownershipStatus": premiseOwnershipStatus,
        //         "workingFromHome": workingFromHome.text,
        //         "industry": industry,
        //         "organisationType": organizationType,
        //         "employmentType": employmentType,
        //         "occupation": occupation.text,
        //         "tenure": tenure.text,
        //         "firmName": firmName.text,
        //         "companyName": company.text,
        //         "purposeOfLoan": loanPurpose.text,
        //         "totalLoans": totalLoans.text,
        //         "yearsInBusiness": yearsInBusiness.text,
        //         "highestDegree": highestDegree.text,
        //         "expCurrentEmployer": expWithCurrentEmployer.text,
        //         "workExp": workExperience.text,
        //         "monthlySalary": monthlySalary.text,
        //         "ongoingMonthlyObligation": ongoingMonthlyObligations.text,
        //         "mode": modeOfSalary.text,
        //         "loanType": loanType.text,
        //         "loanAmount": loanAmount.text,
        //         "residentialStatus": residentialStatus,
        //         "addressType": addressType.text,
        //         "dob": dob.text.split("-").reversed.join("-"),
        //         "pinCode": pinCode.text,
        //         "mobileNumber": mobile.text,
        //         "emailID": email.text,
        //         "panCardNumber": "",
        //         "panCard": "",
        //         "aadharCardNumber": "",
        //         "aadharCard": "",
        //         "pastLoans": pastLoan == "Yes",
        //         "gender": "",
        //         "maritalStatus": "",
        //         "primary_account": primaryAccount.text,
        //         "employment_type": employmentType,
        //       };
        //       bool isadded = await sendData(data);
        //       print('submit pressed after api $isadded');

        //       if (isadded) {
        //         ProductsArguments args = new ProductsArguments(
        //             data['id'].toString(), null, email.text);
        //         Navigator.popAndPushNamed(context, Routes.home,
        //             arguments: args);
        //       }
        //     },
        //     child: Container(
        //       height: 35,
        //       width: 150,
        //       decoration: BoxDecoration(
        //         color: yellowColor(),
        //         borderRadius: BorderRadius.circular(
        //           10.0,
        //         ),
        //       ),
        //       child: Center(
        //         child: Text(
        //           'Submit',
        //           style: TextStyle(
        //             fontSize: 16,
        //             fontWeight: FontWeight.w700,
        //           ),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
        SizedBox(
          height: 50,
        ),
      ],
    );
  }
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
    print(response.data);
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  } on DioError catch (e) {
    print(e.response.data);
    return false;
  }
}
