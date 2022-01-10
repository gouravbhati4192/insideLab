import 'package:financial_freedom/new%20ui%20pages/chat.support.screen.dart';
import 'package:financial_freedom/old/Model/DocumentsScreenArguments.dart';
import 'package:financial_freedom/old/Model/ProductsArguments.dart';
import 'package:financial_freedom/old/widgets/common/ApiConstants.dart';
import 'package:financial_freedom/old/widgets/common/CallApi.dart';
import 'package:financial_freedom/old/widgets/common/mycolors.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:ribbon/ribbon.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

Color backgroundColor() => HexColor("#20314E");
Color yellowColor() => HexColor("#F4DE4C");
Color textBoxColor() => HexColor("#949695");

class CustomerDetailsScreen extends StatefulWidget {
  CustomerDetailsScreen({Key key}) : super(key: key);

  @override
  _CustomerDetailsScreenState createState() => _CustomerDetailsScreenState();
}

class _CustomerDetailsScreenState extends State<CustomerDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: MyColors.yellowColor(),
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: MyColors.backgroundColor(),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.calendar_today_outlined,
                color: MyColors.backgroundColor(),
              ))
        ],
        title: Text(
          'Customer Details',
          style: TextStyle(color: MyColors.backgroundColor(), fontSize: 16),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 190,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    new BoxShadow(
                      color: HexColor('#787878').withOpacity(0.8),
                      blurRadius: 7.0,
                      spreadRadius: -1.0,
                    ),
                    new BoxShadow(
                      color: HexColor('#787878').withOpacity(0.5),
                      blurRadius: 2.0,
                      spreadRadius: 2.0,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(5.0),
                  color: HexColor('#f5f5f5'),
                  border: Border.all(
                    color: Colors.grey.withOpacity(0.5),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20.0),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Hero(
                            tag: 'profile',
                            child: SizedBox(
                              height: 80,
                              width: 80,
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  border: Border.all(),
                                ),
                                child: Center(
                                    child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.camera_alt),
                                    Text(
                                      'customer photograph',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.grey.shade500,
                                          fontSize: 9),
                                    )
                                  ],
                                )),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10.0,
                                  ),
                                  child: Text(
                                    'Case ID : # 09908',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      new BoxShadow(
                                        color: HexColor('#787878')
                                            .withOpacity(0.5),
                                        blurRadius: 1.0,
                                        spreadRadius: 2.0,
                                      ),
                                    ],
                                    color: HexColor('#4455BB'),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Nitesh Wadhwa',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Icon(
                                        Icons.mode_edit,
                                        color: Colors.white,
                                      ),
                                      Spacer(),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // Expanded(
                            //   child: InkWell(
                            //     onTap: () {
                            //       // launch('tel://' +
                            //       //     (customerDetailsJson[
                            //       //                 'mobile'] ==
                            //       //             null
                            //       //         ? ''
                            //       //         : customerDetailsJson[
                            //       //             'mobile']));
                            //     },
                            //     child: SizedBox(
                            //         height: 24,
                            //         child: Icon(Icons.phone_in_talk_outlined)),
                            //   ),
                            // ),
                            Card(
                                color: MyColors.yellowColor(),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.call_outlined,
                                      color: MyColors.backgroundColor()),
                                )),
                            Card(
                                color: MyColors.yellowColor(),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(FontAwesome.whatsapp,
                                      color: MyColors.backgroundColor()),
                                )),
                            Card(
                                color: MyColors.yellowColor(),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.mail_outline,
                                      color: MyColors.backgroundColor()),
                                )),
                            // Expanded(
                            //   child: InkWell(
                            //     onTap: () {
                            //       // launch('sms://' +
                            //       //     (customerDetailsJson[
                            //       //                 'mobile'] ==
                            //       //             null
                            //       //         ? ''
                            //       //         : customerDetailsJson[
                            //       //             'mobile']));
                            //     },
                            //     child: SizedBox(
                            //       height: 24,
                            //       child: Icon(Icons.sms_outlined),
                            //     ),
                            //   ),
                            // ),
                            // Expanded(
                            //   child: InkWell(
                            //     onTap: () {
                            //       if (Platform.isIOS) {
                            //         // add the [https]
                            //         // launch(
                            //         //     "https://wa.me/+${(customerDetailsJson['mobile'] == null ? '' : customerDetailsJson['mobile'])}"); // new line
                            //       } else {
                            //         // add the [https]
                            //         // launch(
                            //         //     "https://api.whatsapp.com/send?phone=+${(customerDetailsJson['mobile'] == null ? '' : customerDetailsJson['mobile'])}=}"); // new line
                            //       }
                            //     },
                            //     child: SizedBox(
                            //       height: 22,
                            //       child: Icon(FontAwesome.whatsapp),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 10, 0, 0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Loan Details :',
                      style:
                          Theme.of(context).primaryTextTheme.bodyText1.copyWith(
                                fontSize: 16,
                                color: MyColors.backgroundColor(),
                              ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '10,00,000',
                      style:
                          Theme.of(context).primaryTextTheme.bodyText1.copyWith(
                                fontSize: 16,
                                color: MyColors.backgroundColor(),
                              ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0, 0, 0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Loan Type :',
                      style:
                          Theme.of(context).primaryTextTheme.bodyText1.copyWith(
                                fontSize: 16,
                                color: MyColors.backgroundColor(),
                              ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Personal',
                      style:
                          Theme.of(context).primaryTextTheme.bodyText1.copyWith(
                                fontSize: 16,
                                color: MyColors.backgroundColor(),
                              ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0, 0, 0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Lender Selected :',
                      style:
                          Theme.of(context).primaryTextTheme.bodyText1.copyWith(
                                fontSize: 16,
                                color: MyColors.backgroundColor(),
                              ),
                    ),
                  ),
                  // Expanded(
                  //   child: Text(
                  //     'Personal',
                  //     style:
                  //         Theme.of(context).primaryTextTheme.bodyText1.copyWith(
                  //               fontSize: 18,
                  //               fontWeight: FontWeight.w700,
                  //               color: MyColors.backgroundColor(),
                  //             ),
                  //   ),
                  // ),
                ],
              ),
            ),
            loanTracker(),
            documentRequired(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 60,
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            new BoxShadow(
                              color: HexColor('#787878').withOpacity(0.40),
                              blurRadius: 4.0,
                              spreadRadius: 2.0,
                              offset: Offset(3.5, 3.5),
                            ),
                            new BoxShadow(
                              color: HexColor('#787878').withOpacity(0.40),
                              blurRadius: 4.0,
                              spreadRadius: 2.0,
                              offset: Offset(-1, -1),
                            ),
                          ],
                          color: MyColors.yellowColor(),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatSupportScreen(),
                              ),
                            );
                          },
                          child: TextFormField(
                            enabled: false,
                            decoration: InputDecoration(
                              hintText: 'Type here to Chat...',
                              hintStyle:
                                  TextStyle(color: MyColors.backgroundColor()),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 0,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 0,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 0,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: [
                        Hero(
                            tag: 'support',
                            child:
                                SizedBox(width: 40, child: Icon(Icons.call))),
                        Text(
                          'Support',
                          style: TextStyle(
                            color: backgroundColor(),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  documentRequired() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () {
          showTrackerDialog(context, {});
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            boxShadow: [
              new BoxShadow(
                color: Colors.grey,
                blurRadius: 6.0,
                offset: new Offset(0.0, 0.0),
              ),
            ],
            color: Colors.white,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25.0,
                  vertical: 8.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Required Documents',
                      style: TextStyle(
                        color: MyColors.backgroundColor(),
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: RawMaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        onPressed: () {},
                        fillColor: MyColors.yellowColor(),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(
                            '4/6 uploaded',
                            style: Theme.of(context)
                                .primaryTextTheme
                                .bodyText1
                                .copyWith(
                                  fontSize: 14,
                                  color: MyColors.backgroundColor(),
                                ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 60,
                child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, i) => buildStep(true, true),
                    separatorBuilder: (context, i) => SizedBox(
                          width: 20.0,
                          child: Divider(
                            color: backgroundColor(),
                            thickness: 1.5,
                          ),
                        ),
                    itemCount: 7),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 24.0,
                    ),
                    child: Text(
                      "1 Additional Document is required",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blue,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 24.0,
                      top: 6.0,
                    ),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "1 Document has Quaity/ upload Error",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.red,
                            ),
                          ),
                        ],
                        style: TextStyle(
                          fontSize: 16,
                          color: MyColors.darkBlue,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      child: Text(
                    'Last Updated\n9:30am, 10th Sept 2020',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey.shade500,
                    ),
                  ))
                ],
              ),
              SizedBox(
                height: 14,
              ),
            ],
          ),
        ),
      ),
    );
  }

  loanTracker() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () {
          showTrackerDialog(context, {});
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            boxShadow: [
              new BoxShadow(
                color: Colors.grey,
                blurRadius: 6.0,
                offset: new Offset(0.0, 0.0),
              ),
            ],
            color: Colors.white,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25.0,
                  vertical: 8.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Loan Tracker',
                      style: TextStyle(
                        color: MyColors.backgroundColor(),
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: RawMaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        onPressed: () {},
                        fillColor: MyColors.yellowColor(),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(
                            'Lender Login',
                            style: Theme.of(context)
                                .primaryTextTheme
                                .bodyText1
                                .copyWith(
                                  fontSize: 14,
                                  color: MyColors.backgroundColor(),
                                ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 60,
                child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, i) => buildStep(true, true),
                    separatorBuilder: (context, i) => SizedBox(
                          width: 20.0,
                          child: Divider(
                            color: backgroundColor(),
                            thickness: 1.5,
                          ),
                        ),
                    itemCount: 7),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 24.0,
                      top: 6.0,
                    ),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Action: ",
                          ),
                          TextSpan(
                            text: "New Documents Required",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                        style: TextStyle(
                          fontSize: 16,
                          color: MyColors.darkBlue,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      child: Text(
                    'Last Updated\n9:30am, 10th Sept 2020',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey.shade500,
                    ),
                  ))
                ],
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: DotStepper(
              //         // direction: Axis.vertical,
              //         dotCount: 7,
              //         dotRadius: 7,
              //         lineConnectorsEnabled: true,
              //         tappingEnabled: false,

              //         /// THIS MUST BE SET. SEE HOW IT IS CHANGED IN NEXT/PREVIOUS BUTTONS AND JUMP BUTTONS.
              //         activeStep: 2,
              //         shape: Shape.circle,
              //         spacing: 20,
              //         indicator: Indicator.shift,

              //         /// TAPPING WILL NOT FUNCTION PROPERLY WITHOUT THIS PIECE OF CODE.
              //         onDotTapped: (tappedDotIndex) {
              //           setState(() {
              //             // activeStep = tappedDotIndex;
              //           });
              //         },
              //         // DOT-STEPPER DECORATIONS
              //         fixedDotDecoration: FixedDotDecoration(
              //           strokeColor: yellowColor(),
              //           strokeWidth: 5,
              //           color: Colors.white,
              //         ),
              //         indicatorDecoration: IndicatorDecoration(
              //           strokeWidth: 8,
              //           strokeColor: backgroundColor(),
              //           color: Colors.white,
              //         ),
              //         lineConnectorDecoration:
              //             LineConnectorDecoration(),
              //       ),
              //     ),
              //   ],
              // ),
              SizedBox(
                height: 14,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showTrackerDialog(BuildContext context, customerDetailsJson) {
    showDialog(
        context: context,
        builder: (context) => Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.7,
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Center(
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, i) => Row(
                            children: [
                              buildStep(true, true),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                'Select Loan Product',
                                style: TextStyle(
                                  color: backgroundColor(),
                                  fontSize: 16.0,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '5:30\n31st Aug 21',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: backgroundColor(),
                                    fontSize: 8.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          separatorBuilder: (context, i) => Container(
                            height: 30.0,
                            margin: EdgeInsets.only(left: 12.0),
                            decoration: BoxDecoration(
                              border: Border(
                                left: BorderSide(color: Colors.black),
                              ),
                            ),
                          ),
                          itemCount: 7,
                        ),
                      ),
                    ),
                    Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.black),
                              ),
                              child: Icon(Icons.clear_rounded),
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            ));
  }

  Widget buildStep(bool isCurrent, bool isActive) {
    return (isCurrent
        ? CircleAvatar(
            backgroundColor: backgroundColor(),
            radius: 12.0,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 3.0,
            ),
          )
        : (isActive
            ? CircleAvatar(
                backgroundColor: Colors.grey.shade100,
                radius: 12.0,
                child: Icon(
                  Icons.check,
                  color: yellowColor(),
                ),
              )
            : CircleAvatar(
                backgroundColor: yellowColor(),
                radius: 12.0,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 3.0,
                ),
              )));
  }
}

class CustomerProfile extends StatefulWidget {
  final String customerID;

  const CustomerProfile({Key key, this.customerID}) : super(key: key);

  @override
  _CustomerProfileState createState() => _CustomerProfileState();
}

class _CustomerProfileState extends State<CustomerProfile> {
  Future customerData;
  CallApi _callApi = new CallApi();
  List status = [
    "Select Loan Product",
    "Upload Documents",
    "Submit Applications",
    "Verifying Eligibility",
    "Lender Login",
    "Approved",
    "Disbursed",
  ];

  @override
  void initState() {
    super.initState();
    customerData = _callApi.callGetApi(
        ApiConstants.CASE_DETAILS + widget.customerID, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: null,
        centerTitle: true,
        title: Text(
          'Case Information',
          style: TextStyle(
            color: MyColors.backgroundColor(),
          ),
        ),
      ),
      body: FutureBuilder(
          future: customerData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var customerDetailsJson;
              var jsonData = json.decode(snapshot.data);
              if (jsonData['data'] == null || jsonData['data'].length == 0) {
                return Container();
              } else {
                customerDetailsJson = jsonData['data'];
                print(customerDetailsJson["case_status"]);
                Timer(Duration(seconds: 5), () {
                  if (mounted) {
                    setState(() {});
                  }
                });
              }
              return Stack(
                children: [
                  ListView(
                    padding: const EdgeInsets.all(0.0),
                    children: [
                      SizedBox(
                        height: 165,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      CarouselSlider(
                        items: [
                          InkWell(
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   CupertinoPageRoute(
                              //     builder: (context) =>
                              //         EditProfile(data: customerDetailsJson),
                              //   ),
                              // );
                            },
                            child:
                                buildProfileCard(context, customerDetailsJson),
                          ),
                          InkWell(
                              onTap: () {
                                ProductsArguments args = new ProductsArguments(
                                    customerDetailsJson['id'].toString(),
                                    null,
                                    customerDetailsJson['email'].toString(),
                                    loanType: customerDetailsJson['load_type']);
                                Navigator.pushNamed(
                                    context, '/newCustomer/productDetails',
                                    arguments: args);
                              },
                              child: buildProductCard(
                                  context, customerDetailsJson)),
                          InkWell(
                            onTap: () {
                              _callApi
                                  .callGetApi(
                                      ApiConstants.CASE_DETAILS +
                                          customerDetailsJson['id'].toString(),
                                      true)
                                  .then((value) {
                                if (value != null) {
                                  var data = json.decode(value);
                                  Navigator.pushNamed(context, '/documentList',
                                      arguments: new DocumentsScreenArguments(
                                          customerDetailsJson['id'] == null
                                              ? ''
                                              : customerDetailsJson['id']
                                                  .toString(),
                                          customerDetailsJson,
                                          '',
                                          data['data']['document_list'] == null
                                              ? ''
                                              : data['data']['document_list']));
                                }
                              });

                              // Navigator.push(
                              //   context,
                              //   CupertinoPageRoute(
                              //     builder: (context) =>
                              //         DocumentRequiredScreen(),
                              //   ),
                              // );
                            },
                            child:
                                buildDocumentCard(context, customerDetailsJson),
                          ),
                          // ShareCard(),
                        ],
                        options: CarouselOptions(
                          height: 200,
                          viewportFraction: 0.78,
                          initialPage: 0,
                          enableInfiniteScroll: false,
                          autoPlay: false,
                          enlargeCenterPage: true,
                          // onPageChanged: callbackFunction,
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SizedBox(
                          height: 300,
                          child: Ribbon(
                            location: RibbonLocation.topEnd,
                            nearLength: 50,
                            farLength: 80,
                            title: 'Landing Soon',
                            titleStyle: TextStyle(
                                color: backgroundColor(),
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                            color: MyColors.yellowColor(),
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  new BoxShadow(
                                    color:
                                        HexColor('#787878').withOpacity(0.40),
                                    blurRadius: 4.0,
                                    spreadRadius: 3.0,
                                    offset: Offset(3.5, 3.5),
                                  ),
                                  new BoxShadow(
                                    color:
                                        HexColor('#787878').withOpacity(0.40),
                                    blurRadius: 4.0,
                                    spreadRadius: 3.0,
                                    offset: Offset(-1, -1),
                                  ),
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'In-App Chat',
                                  style: TextStyle(color: backgroundColor()),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  Container buildDocumentCard(BuildContext context, customerDetailsJson) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
        color: yellowColor(),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          new BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 4.0,
            spreadRadius: 4.0,
            offset: Offset(4, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    'Documents\nRequired',
                    style: TextStyle(
                      color: backgroundColor(),
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: CircularPercentIndicator(
                      radius: 50.0,
                      lineWidth: 7.0,
                      animation: true,
                      percent: 0.42,
                      footer: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          "${(customerDetailsJson['document_list'] == null ? [] : customerDetailsJson['document_list']).length} of 7 Uploads",
                          style: new TextStyle(
                            fontWeight: FontWeight.w600,
                            color: backgroundColor(),
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: backgroundColor(),
                    ),
                  ),
                ),
              ],
            ),
            Flexible(
              child: Text(
                "Complete all document to submit the application for login with selected lender",
                style: new TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12.0,
                  color: backgroundColor(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildProductCard(BuildContext context, customerDetailsJson) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
        color: MyColors.backgroundColor(),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          new BoxShadow(
            color: HexColor('#787878').withOpacity(0.40),
            blurRadius: 4.0,
            spreadRadius: 3.0,
            offset: Offset(3.5, 3.5),
          ),
          new BoxShadow(
            color: HexColor('#787878').withOpacity(0.40),
            blurRadius: 4.0,
            spreadRadius: 3.0,
            offset: Offset(-1, -1),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Loan',
                    style: TextStyle(
                      color: MyColors.yellowColor(),
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'selected',
                    style: TextStyle(
                      color: textBoxColor(),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    customerDetailsJson['product_name'] == null
                        ? 'Lender Not Selected'
                        : customerDetailsJson['product_name'].toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: MyColors.yellowColor(),
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    "${customerDetailsJson['load_type'] == null ? '' : customerDetailsJson['load_type']} Loan",
                    style: TextStyle(
                      color: textBoxColor(),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProfileCard(BuildContext context, customerDetailsJson) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
        color: yellowColor(),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          new BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 4.0,
            spreadRadius: 4.0,
            offset: Offset(4, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            height: 30.0,
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 32.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Profile',
                        style: TextStyle(
                          color: MyColors.backgroundColor(),
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        (customerDetailsJson['first_name'] == null
                                ? ''
                                : customerDetailsJson['first_name']) +
                            " " +
                            (customerDetailsJson['last_name'] == null
                                ? ''
                                : customerDetailsJson['last_name']),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Expanded(
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.end,
              //     children: [
              //       SizedBox(
              //         height: 30,
              //       ),
              //       CircularPercentIndicator(
              //         radius: 50.0,
              //         lineWidth: 5.0,
              //         animation: true,
              //         percent: 1,
              //         footer: Padding(
              //           padding: const EdgeInsets.only(top: 8.0, right: 20.0),
              //           child: Text(
              //             "100% Completed",
              //             style: new TextStyle(
              //               fontWeight: FontWeight.bold,
              //               fontSize: 12.0,
              //               color: backgroundColor(),

              //             ),
              //           ),
              //         ),
              //         circularStrokeCap: CircularStrokeCap.round,
              //         progressColor: backgroundColor(),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 0.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Edit, change and add customer details",
                  textAlign: TextAlign.start,
                  style: new TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12.0,
                      color: backgroundColor()),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ShareCard extends StatelessWidget {
  const ShareCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 0,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                top: 16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Shared',
                    style: TextStyle(
                      color: backgroundColor(),
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'Media and Resources',
                    style: TextStyle(
                      color: textBoxColor(),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 0.0, bottom: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Insider Board',
                    style: TextStyle(
                      color: backgroundColor(),
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'Engagement',
                    style: TextStyle(
                      color: textBoxColor(),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
