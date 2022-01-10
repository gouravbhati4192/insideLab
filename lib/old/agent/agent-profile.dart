import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:financial_freedom/old/Home/home.dart';
import 'package:financial_freedom/old/Model/Agent.dart';
import 'package:financial_freedom/old/Model/ProductsArguments.dart';
import 'package:financial_freedom/old/customer/income_details.dart';
import 'package:financial_freedom/old/widgets/common/ApiConstants.dart';
import 'package:financial_freedom/old/widgets/common/SharedPref.dart';
import 'package:financial_freedom/old/widgets/common/mycolors.dart';
import 'package:financial_freedom/old/widgets/common/routes.dart';
import 'package:financial_freedom/old/widgets/customer/customer-profile.dart';
import 'package:financial_freedom/old/widgets/registration/registration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AgentProfile extends StatefulWidget {
  @override
  _AgentProfileState createState() => _AgentProfileState();
}

class _AgentProfileState extends State<AgentProfile> {
  bool isEdit = true;
  String id;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController bankName = TextEditingController();
  TextEditingController accountHolderName = TextEditingController();
  TextEditingController accountNumber = TextEditingController();
  TextEditingController ifscCode = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController currentProfession = TextEditingController();
  String employmentType;
  TextEditingController workExperience = TextEditingController();
  TextEditingController employerName = TextEditingController();
  bool financialIndustry = false;
  bool holdGovOffice = false;
  TextEditingController dob = TextEditingController();
  String gender;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor(),
      body: loading
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          : Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                Icons.arrow_back_ios,
                                color: backgroundColor(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Container(
                    //     height: 30,
                    //     width: 60,
                    //     decoration: BoxDecoration(
                    //       color: yellowColor(),
                    //       borderRadius: BorderRadius.circular(
                    //         10.0,
                    //       ),
                    //     ),
                    //     child: Center(
                    //       child: Text(
                    //         'Save',
                    //         style: TextStyle(
                    //           fontSize: 16,
                    //           fontWeight: FontWeight.w500,
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                Expanded(
                  child: Container(
                    height: 1000,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 45,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(
                                        10.0,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Profile',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: !isEdit
                                        ? () {
                                            setState(() {
                                              isEdit = true;
                                            });
                                          }
                                        : () async {
                                            Map<String, dynamic> data = {
                                              "id": 2,
                                              "name": name.text,
                                              "email": email.text,
                                              "mobile": mobile.text,
                                              "location": location.text,
                                              "bank_name": bankName.text,
                                              "account_holder_name":
                                                  accountHolderName.text,
                                              "account_number":
                                                  accountNumber.text,
                                              "ifsc_code": ifscCode.text,
                                              "address": address.text,
                                              "current_profession":
                                                  currentProfession.text,
                                              "employment_type": employmentType,
                                              "work_experience":
                                                  workExperience.text,
                                              "employer_name":
                                                  employerName.text,
                                              "financial_industry":
                                                  financialIndustry
                                                      ? "Yes"
                                                      : "No",
                                              "hold_gov_office":
                                                  holdGovOffice ? "Yes" : "No",
                                              "dob": dob.text
                                                  .split("-")
                                                  .reversed
                                                  .join("-"),
                                              "gender": gender,
                                            };
                                            bool isadded = await sendData(data);
                                            print(
                                                'submit pressed after api $isadded');

                                            if (isadded) {
                                              ProductsArguments args =
                                                  new ProductsArguments(
                                                      null, null, null);
                                              Navigator.popAndPushNamed(
                                                  context, Routes.home,
                                                  arguments: args);
                                            }
                                          },
                                    child: Container(
                                      height: 45,
                                      decoration: BoxDecoration(
                                        color: yellowColor(),
                                        borderRadius: BorderRadius.circular(
                                          10.0,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          !isEdit ? 'Edit' : 'Save',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 100,
                            width: 130,
                            child: Image.network(
                              'https://www.pngarts.com/files/11/Avatar-Free-PNG-Image.png',
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20.0,
                              vertical: 15.0,
                            ),
                            child: Text(
                              'User ID : ${HomeState.agentId.value.toString().padLeft(3, "0")}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          personalInformation(),
                          buildEmploymentDetails(),
                          Column(
                            children: [
                              SizedBox(
                                height: 40,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Container(
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: yellowColor(),
                                    borderRadius: BorderRadius.circular(
                                      30.0,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Bank Account Details',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
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
                                      'Bank Name',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Container(
                                  color: Colors.white,
                                  child: CupertinoTextField(
                                    readOnly: !isEdit,
                                    controller: bankName,
                                    placeholderStyle: TextStyle(
                                      color: Colors.black,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
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
                                      'Account Holder Name',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Container(
                                  color: Colors.white,
                                  child: CupertinoTextField(
                                    readOnly: !isEdit,
                                    controller: accountHolderName,
                                    placeholderStyle: TextStyle(
                                      color: Colors.black,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
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
                                      'Account Number',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Container(
                                  color: Colors.white,
                                  child: CupertinoTextField(
                                    readOnly: !isEdit,
                                    controller: accountNumber,
                                    placeholderStyle: TextStyle(
                                      color: Colors.black,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
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
                                      'IFSC Code',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Container(
                                  color: Colors.white,
                                  child: CupertinoTextField(
                                    readOnly: !isEdit,
                                    controller: ifscCode,
                                    placeholderStyle: TextStyle(
                                      color: Colors.black,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
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
                                      'Address',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Container(
                                  color: Colors.white,
                                  child: CupertinoTextField(
                                    readOnly: !isEdit,
                                    controller: address,
                                    placeholderStyle: TextStyle(
                                      color: Colors.black,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget buildEmploymentDetails() {
    return Column(
      children: [
        SizedBox(
          height: 40,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Container(
            height: 30,
            decoration: BoxDecoration(
              color: yellowColor(),
              borderRadius: BorderRadius.circular(
                30.0,
              ),
            ),
            child: Center(
              child: Text(
                'Employment Details',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
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
                'Current Profession',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
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
          child: Container(
            color: Colors.white,
            child: CupertinoTextField(
              readOnly: !isEdit,
              controller: currentProfession,
              placeholderStyle: TextStyle(
                color: Colors.black,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
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
                'Employment Type',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
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
          child: Container(
            height: 28,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: DropdownButton<String>(
                icon: Icon(
                  Icons.keyboard_arrow_down,
                ),
                isExpanded: true,
                elevation: 5,
                value: employmentType,
                underline: SizedBox.shrink(),
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
                'Work Experience',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
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
          child: Container(
            color: Colors.white,
            child: CupertinoTextField(
              readOnly: !isEdit,
              controller: workExperience,
              placeholderStyle: TextStyle(
                color: Colors.black,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
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
                'Employer Name',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
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
          child: Container(
            color: Colors.white,
            child: CupertinoTextField(
              readOnly: !isEdit,
              controller: employerName,
              placeholderStyle: TextStyle(
                color: Colors.black,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  "I have worked in Financial industry / services before.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              CupertinoSwitch(
                activeColor: MyColors.yellowColor(),
                value: financialIndustry,
                onChanged: (value) {
                  setState(
                    () {
                      financialIndustry = value;
                    },
                  );
                },
              )
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  "My direct family member or I don't hold any Gov. Office ?",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
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
        ),
      ],
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
                  fontWeight: FontWeight.w500,
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
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
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
          child: Container(
            color: Colors.white,
            child: CupertinoTextField(
              readOnly: !isEdit,
              controller: name,
              placeholderStyle: TextStyle(
                color: Colors.black,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
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
                'Date of Birth',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
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
            decoration: BoxDecoration(
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Row(
            children: [
              Text(
                'Location',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
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
          child: Container(
            color: Colors.white,
            child: CupertinoTextField(
              readOnly: !isEdit,
              controller: location,
              placeholderStyle: TextStyle(
                color: Colors.black,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
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
                'Email',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
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
          child: Container(
            color: Colors.white,
            child: CupertinoTextField(
              readOnly: true,
              controller: email,
              placeholderStyle: TextStyle(
                color: Colors.black,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
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
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
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
                    child: Container(
                      color: Colors.white,
                      child: CupertinoTextField(
                        readOnly: !isEdit,
                        controller: mobile,
                        placeholderStyle: TextStyle(
                          color: Colors.black,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
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
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Row(
            children: [
              Text(
                'Gender',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
            height: 28,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: DropdownButton<String>(
                icon: Icon(
                  Icons.keyboard_arrow_down,
                ),
                isExpanded: true,
                elevation: 5,
                value: gender,
                underline: SizedBox.shrink(),
                style: TextStyle(
                  color: Colors.black,
                ),
                items: <String>[
                  "Male",
                  "Female",
                  "Others",
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
                          gender = value;
                        });
                      },
              ),
            ),
          ),
        ),
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
        //                 fontWeight: FontWeight.w500,
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
        //           child: DropdownButton<String>(
        //             icon: Icon(
        //               Icons.keyboard_arrow_down,
        //             ),
        //             isExpanded: true,
        //             elevation: 5,
        //             value: 'Choose',
        //             underline: SizedBox.shrink(),
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

  Future<bool> getData() async {
    SharedPref _pref = new SharedPref();
    try {
      Response response = await Dio().get(
        ApiConstants.BASE_URL + ApiConstants.agentDetails,
        options: Options(headers: {
          "verify-myself": "banana",
          "Authorization": "Bearer ${await _pref.getToken()}"
        }),
      );
      if (response.statusCode == 200) {
        // log(response.data["data"].toString());
        id = response.data["data"]["id"].toString();
        name.text = response.data["data"]["name"];
        email.text = response.data["data"]["email"];
        mobile.text = response.data["data"]["mobile"];
        location.text = response.data["data"]["location"];
        bankName.text = response.data["data"]["bank_name"];
        accountHolderName.text = response.data["data"]["account_holder_name"];
        accountNumber.text = response.data["data"]["account_number"];
        ifscCode.text = response.data["data"]["ifsc_code"];
        address.text = response.data["data"]["address"];
        currentProfession.text = response.data["data"]["current_profession"];
        employmentType = response.data["data"]["employment_type"];
        workExperience.text = response.data["data"]["work_experience"];
        employerName.text = response.data["data"]["employer_name"];
        financialIndustry =
            response.data["data"]["financial_industry"] == "Yes" ? true : false;
        holdGovOffice =
            response.data["data"]["hold_gov_office"] == "Yes" ? true : false;
        dob.text = response.data["data"]["dob"]
            .toString()
            .split("-")
            .reversed
            .join("-");
        gender = response.data["data"]["gender"];
        setState(() {
          loading = false;
        });
        return true;
      }
      Navigator.pop(context);
      return false;
    } on DioError catch (e) {
      print(e.response.data);
      Navigator.pop(context);
      return false;
    }
  }

  Future<bool> sendData(Map<String, dynamic> data) async {
    SharedPref _pref = new SharedPref();
    try {
      Response response = await Dio().post(
        ApiConstants.BASE_URL + ApiConstants.updateAgent,
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
}
