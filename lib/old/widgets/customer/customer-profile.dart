import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:financial_freedom/controller/customer.controller.dart';
import 'package:financial_freedom/controller/user.controller.dart';
import 'package:financial_freedom/old/components.dart';
import 'package:financial_freedom/old/widgets/common/SharedPref.dart';
import 'package:provider/provider.dart';
import 'package:ribbon/ribbon.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:financial_freedom/old/Model/DocumentsScreenArguments.dart';
import 'package:financial_freedom/old/Model/ProductsArguments.dart';
import 'package:financial_freedom/old/widgets/common/ApiConstants.dart';
import 'package:financial_freedom/old/widgets/common/CallApi.dart';
import 'package:financial_freedom/old/widgets/common/mycolors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'edit-profile.dart';

Color backgroundColor() => HexColor("#20314E");
Color yellowColor() => HexColor("#F4DE4C");
Color textBoxColor() => HexColor("#949695");

class CustomerProfile extends StatefulWidget {
  final String customerID;

  const CustomerProfile({Key key, this.customerID}) : super(key: key);

  @override
  _CustomerProfileState createState() => _CustomerProfileState();
}

class _CustomerProfileState extends State<CustomerProfile> {
  Future customerData;
  CallApi _callApi = new CallApi();
  double docPercent = 0.1;
  TextEditingController comment = TextEditingController();
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

  UserController userController;
  CustomerController customerController;
  ScrollController _controller = ScrollController();
  bool firstTime = true;
  var customerDetailsJson;
  getDocPer() {
    if (customerController.documentTypes.data.length == 0) {
      docPercent = 0.0;
      return;
    }
    customerData.then((value) {
      log(json.decode(value)['data']['document_list'].toString(),
          name: 'doc list');
      // log(customerController.documentTypes.data.length.toString());
      docPercent = (json.decode(value)['data']['document_list'].length) /
          (customerController.documentTypes.data.length);
      log(docPercent.toString(), name: 'doc percent');
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    userController = Provider.of<UserController>(context);
    customerController = Provider.of<CustomerController>(context);
    if (firstTime) {
      firstTime = false;
      getData();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: backgroundColor()),
        leading: null,
        centerTitle: true,
        title: Text(
          'Case Information',
          style: TextStyle(
            fontSize: 18,
            color: MyColors.backgroundColor(),
          ),
        ),
      ),
      body: FutureBuilder(
          future: customerData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
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
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: GestureDetector(
                          onTap: () {
                            showTrackerDialog(context, customerDetailsJson);
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Loan Tracker',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                      ),
                                      status.contains(
                                              CustomComponents.statusMapping(
                                                  customerDetailsJson[
                                                      "case_status"]))
                                          ? RawMaterialButton(
                                              constraints: BoxConstraints(
                                                maxHeight: 35,
                                              ),
                                              elevation: 8,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                side: BorderSide(
                                                    color: Colors.green,
                                                    width: 1.5),
                                              ),
                                              onPressed: null,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 16.0,
                                                  vertical: 8.0,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    CustomComponents.statusMapping(
                                                            customerDetailsJson[
                                                                "case_status"]) ??
                                                        "Select Loan Product",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.green,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : SizedBox.shrink(),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 60,
                                  child: ListView.separated(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, i) => buildStep(
                                          status[i] ==
                                              CustomComponents.statusMapping(
                                                  customerDetailsJson[
                                                      "case_status"]),
                                          i <
                                              status.indexWhere((e) =>
                                                  e ==
                                                  CustomComponents
                                                      .statusMapping(
                                                          customerDetailsJson[
                                                              "case_status"]))),
                                      separatorBuilder: (context, i) =>
                                          SizedBox(
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
                                              text:
                                                  "${customerDetailsJson["status"]}",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                color: customerDetailsJson[
                                                                "status"]
                                                            .toString()
                                                            .trim() ==
                                                        "New Document Request"
                                                    ? Colors.blue[800]
                                                    : ((customerDetailsJson[
                                                                        "status"]
                                                                    .toString()
                                                                    .trim() ==
                                                                "Not Eligible" ||
                                                            customerDetailsJson[
                                                                    "status"] ==
                                                                "Case-Rejected")
                                                        ? Colors.red[800]
                                                        : Colors.grey),
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
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      CarouselSlider(
                        items: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) =>
                                      EditProfile(data: customerDetailsJson),
                                ),
                              );
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
                            onTap: () async {
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
                          child: Container(
                            decoration: BoxDecoration(
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
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        'In-App Chat',
                                        style:
                                            TextStyle(color: backgroundColor()),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: customerController.commentCaseList ==
                                          null
                                      ? Center(
                                          child: CircularProgressIndicator())
                                      : ListView.builder(
                                          controller: _controller,
                                          shrinkWrap: true,
                                          itemCount: customerController
                                              .commentCaseList.data.length,
                                          // itemCount: 2,
                                          itemBuilder: (c, i) {
                                            return Container(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: [
                                                  customerController
                                                              .commentCaseList
                                                              .data[i]
                                                              .caseComments ==
                                                          null
                                                      ? SizedBox.shrink()
                                                      : Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Card(
                                                            elevation: 4,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(6.0),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  Flexible(
                                                                    child: Text(
                                                                      customerController
                                                                              .commentCaseList
                                                                              .data[i]
                                                                              .caseComments ??
                                                                          '',
                                                                      // 'Hy rudra here i am from udaipur rajasthan. i am having some problem in getting the otp. may be its due to some problem from your side.please check and confirm as soon as possible.',
                                                                      style:
                                                                          TextStyle(
                                                                        color:
                                                                            backgroundColor(),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 6,
                                                                  ),
                                                                  CircleAvatar(
                                                                    radius: 16,
                                                                    backgroundColor:
                                                                        yellowColor(),
                                                                    child: Text(
                                                                      'Me',
                                                                      style: TextStyle(
                                                                          color:
                                                                              backgroundColor()),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                  customerController
                                                              .commentCaseList
                                                              .data[i]
                                                              .userComments ==
                                                          null
                                                      ? SizedBox.shrink()
                                                      : Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Card(
                                                            elevation: 4,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(6.0),
                                                              child: Row(
                                                                children: [
                                                                  CircleAvatar(
                                                                    radius: 16,
                                                                    backgroundColor:
                                                                        backgroundColor(),
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              5.0),
                                                                      child: Image
                                                                          .asset(
                                                                              'assets/yellow-small.png'),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 8,
                                                                  ),
                                                                  Flexible(
                                                                    child: Text(
                                                                      customerController
                                                                              .commentCaseList
                                                                              .data[i]
                                                                              .userComments ??
                                                                          '',
                                                                      // 'Thank for contacting. We will resolve this issue at the highest priority.',
                                                                      style:
                                                                          TextStyle(
                                                                        color:
                                                                            backgroundColor(),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
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
                                        color: HexColor('#787878')
                                            .withOpacity(0.40),
                                        blurRadius: 4.0,
                                        spreadRadius: 2.0,
                                        offset: Offset(3.5, 3.5),
                                      ),
                                      new BoxShadow(
                                        color: HexColor('#787878')
                                            .withOpacity(0.40),
                                        blurRadius: 4.0,
                                        spreadRadius: 2.0,
                                        offset: Offset(-1, -1),
                                      ),
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: TextFormField(
                                    controller: comment,
                                    decoration: InputDecoration(
                                      hintText: 'Type here...',
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                          width: 0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                          width: 0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                          width: 0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                if (comment.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'Please write your message first'),
                                    ),
                                  );
                                  return;
                                }
                                SharedPref _pref = new SharedPref();
                                if (await customerController.sentComment(
                                  caseId: widget.customerID,
                                  caseComments: comment.text.trim(),
                                  token: await _pref.getToken(),
                                )) {
                                  // FocusScopeNode currentFocus =
                                  //     FocusScope.of(context);
                                  // if (!currentFocus.hasPrimaryFocus) {
                                  //   currentFocus.unfocus();
                                  // }
                                  comment.clear();
                                  getData();
                                }
                              },
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: CircleAvatar(
                                    backgroundColor: backgroundColor(),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.send,
                                        color: yellowColor(),
                                        // size: 30,
                                      ),
                                    ),
                                  )
                                  // Column(
                                  //   children: [
                                  //     SizedBox(
                                  //       width: 40,
                                  //       child: Image.network(
                                  //         'https://www.iconpacks.net/icons/1/free-user-support-icon-301-thumb.png',
                                  //       ),
                                  //     ),
                                  //     Text(
                                  //       'Support',
                                  //       style: TextStyle(
                                  //         color: backgroundColor(),
                                  //       ),
                                  //     )
                                  //   ],
                                  // ),
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 190,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
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
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Hero(
                                tag: 'profile',
                                child: SizedBox(
                                  height: 100,
                                  width: 100,
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
                              SizedBox(
                                width: 20.0,
                              ),
                              Expanded(
                                child: Column(
                                  children: [
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
                                        border: Border.all(color: Colors.black),
                                        color: backgroundColor(),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            (customerDetailsJson[
                                                            'first_name'] ==
                                                        null
                                                    ? ''
                                                    : customerDetailsJson[
                                                        'first_name']) +
                                                " " +
                                                (customerDetailsJson[
                                                            'last_name'] ==
                                                        null
                                                    ? ''
                                                    : customerDetailsJson[
                                                        'last_name']),
                                            maxLines: 1,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: yellowColor(),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 10.0,
                                      ),
                                      child: Text(
                                        'Case ID : #${customerDetailsJson['id'] == null ? '' : customerDetailsJson['id'].toString()}',
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Card(
                                              elevation: 5,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 8.0),
                                                child: InkWell(
                                                  onTap: () {
                                                    launch('tel://' +
                                                        (customerDetailsJson[
                                                                    'mobile'] ==
                                                                null
                                                            ? ''
                                                            : customerDetailsJson[
                                                                'mobile']));
                                                  },
                                                  child: SizedBox(
                                                      height: 24,
                                                      child: Icon(
                                                        Icons
                                                            .phone_in_talk_outlined,
                                                        color: Colors.black,
                                                      )),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Card(
                                              elevation: 5,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 8.0),
                                                child: InkWell(
                                                  onTap: () {
                                                    launch('sms://' +
                                                        (customerDetailsJson[
                                                                    'mobile'] ==
                                                                null
                                                            ? ''
                                                            : customerDetailsJson[
                                                                'mobile']));
                                                  },
                                                  child: SizedBox(
                                                    height: 24,
                                                    child: Icon(
                                                      Icons.sms_outlined,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Card(
                                              elevation: 5,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 8.0),
                                                child: InkWell(
                                                  onTap: () {
                                                    if (Platform.isIOS) {
                                                      // add the [https]
                                                      launch(
                                                          "https://wa.me/+${(customerDetailsJson['mobile'] == null ? '' : customerDetailsJson['mobile'])}"); // new line
                                                    } else {
                                                      // add the [https]
                                                      launch(
                                                          "https://api.whatsapp.com/send?phone=+${(customerDetailsJson['mobile'] == null ? '' : customerDetailsJson['mobile'])}=}"); // new line
                                                    }
                                                  },
                                                  child: SizedBox(
                                                    height: 22,
                                                    child: Icon(
                                                      FontAwesome.whatsapp,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
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

  void showTrackerDialog(BuildContext context, customerDetailsJson) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(52, 80, 0, 160),
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(color: Colors.black),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 40.0, vertical: 70.0),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, i) => Row(
                    children: [
                      buildStep(
                          status[i] ==
                              CustomComponents.statusMapping(
                                  customerDetailsJson["case_status"]),
                          i <
                              status.indexWhere((e) =>
                                  e ==
                                  CustomComponents.statusMapping(
                                      customerDetailsJson["case_status"]))),
                      SizedBox(
                        width: 20.0,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                status[i],
                                style: TextStyle(
                                  color: backgroundColor(),
                                  fontSize: ((status[i] ==
                                                  "Verifying Eligibility" &&
                                              customerController
                                                      .eligibilityStatus !=
                                                  null) ||
                                          (status[i] == "Approved" &&
                                              customerController
                                                      .finalLoanApprovalCaseStatus !=
                                                  null))
                                      ? 16.0
                                      : 16.0,
                                  fontWeight: status[i] ==
                                          CustomComponents.statusMapping(
                                              customerDetailsJson[
                                                  "case_status"])
                                      ? FontWeight.w700
                                      : FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              status[i] == "Verifying Eligibility" &&
                                      customerController.eligibilityStatus !=
                                          null
                                  ? Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 4.0),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: customerController
                                                      .eligibilityStatus
                                                      .status ==
                                                  "Yes"
                                              ? Colors.green[800]
                                              : Colors.red[800],
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      ),
                                      child: Text(
                                        customerController
                                            .eligibilityStatus.status,
                                        style: TextStyle(
                                          color: customerController
                                                      .eligibilityStatus
                                                      .status ==
                                                  "Yes"
                                              ? Colors.green[800]
                                              : Colors.red[800],
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )
                                  : SizedBox.shrink(),
                            ],
                          ),
                          status[i] == "Verifying Eligibility" &&
                                  customerController.eligibilityStatus != null
                              ? Text(
                                  customerController
                                      .eligibilityStatus.explanation,
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 14.0,
                                  ),
                                )
                              : SizedBox.shrink(),
                          status[i] == "Approved" &&
                                  customerController
                                          .finalLoanApprovalCaseStatus !=
                                      null
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Loan Amount: " +
                                          customerController
                                              .finalLoanApprovalCaseStatus
                                              .loanAmount
                                              .toString(),
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 14.0,
                                      ),
                                    ),
                                    Text(
                                      "Interest Rate: " +
                                          customerController
                                              .finalLoanApprovalCaseStatus
                                              .interestRate
                                              .toString(),
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 14.0,
                                      ),
                                    ),
                                    Text(
                                      "Tenure: " +
                                          customerController
                                              .finalLoanApprovalCaseStatus
                                              .tenure
                                              .toString(),
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 14.0,
                                      ),
                                    ),
                                    Text(
                                      "Processing Fees: " +
                                          customerController
                                              .finalLoanApprovalCaseStatus
                                              .processingFees
                                              .toString(),
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 14.0,
                                      ),
                                    ),
                                  ],
                                )
                              : SizedBox.shrink(),
                        ],
                      ),
                    ],
                  ),
                  separatorBuilder: (context, i) {
                    return Container(
                      height: 30.0,
                      margin: EdgeInsets.only(left: 12.0),
                      decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(color: Colors.black),
                        ),
                      ),
                    );
                  },
                  itemCount: 7,
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
                      percent: docPercent,
                      footer: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          "${(customerDetailsJson['document_list'] == null ? [] : customerDetailsJson['document_list']).length} of ${customerController.documentTypes == null ? 0 : customerController.documentTypes.data.length} Uploads",
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
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              (customerDetailsJson['first_name'] == null
                                      ? ''
                                      : customerDetailsJson['first_name']) +
                                  " " +
                                  (customerDetailsJson['last_name'] == null
                                      ? ''
                                      : customerDetailsJson['last_name']),
                              // maxLines: 1,
                              // overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
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

  void getData() async {
    SharedPref _pref = new SharedPref();
    await customerController.getEligibilityStatus(
      caseId: widget.customerID,
      token: await _pref.getToken(),
    );
    await customerController.getFinalLoanApprovalCaseStatus(
      caseId: widget.customerID,
      token: await _pref.getToken(),
    );
    await customerController.getDocumentTypeCaseList(
      caseId: widget.customerID,
      token: await _pref.getToken(),
    );
    await customerController.getCommentList(
      caseId: widget.customerID,
      token: await _pref.getToken(),
    );
    _controller.animateTo(_controller.position.maxScrollExtent + 100,
        duration: Duration(milliseconds: 500), curve: Curves.easeIn);
    getDocPer();
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
