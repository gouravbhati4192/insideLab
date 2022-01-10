import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:financial_freedom/globa_media/global_media_page.dart';
import 'package:financial_freedom/old/Home/business-card.dart';
import 'package:financial_freedom/old/Home/legal.dart';
import 'package:financial_freedom/old/Home/referral-payout-slab.dart';
import 'package:financial_freedom/old/agent/agent-profile.dart';
import 'package:financial_freedom/old/components.dart';
import 'package:financial_freedom/old/share/select.loan.type.dart';
import 'package:financial_freedom/old/widgets/common/ApiConstants.dart';
import 'package:financial_freedom/old/widgets/common/CallApi.dart';
import 'package:financial_freedom/old/widgets/common/SharedPref.dart';
import 'package:financial_freedom/old/widgets/common/colors.dart';
import 'package:financial_freedom/old/widgets/common/mycolors.dart';
import 'package:financial_freedom/old/widgets/common/routes.dart';
import 'package:financial_freedom/old/widgets/customer/customer-profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  final String title;
  Home({Key key, this.title}) : super(key: key);
  @override
  HomeState createState() => HomeState();
}

CallApi _callApi = new CallApi();

class HomeState extends State<Home> {
  var homeJson, customerList;
  static ValueNotifier agentId = ValueNotifier<int>(0);
  static ValueNotifier agentName = ValueNotifier<String>("");
  Future<String> homeData;

  double initialChildSize = 0.2;

  @override
  void initState() {
    super.initState();
    //homeData = _callApi.callGetApi(ApiConstants.HOME, true);
  }

  // FutureOr onReturnToHome() {
  //   setState(() {
  //     homeData = _callApi.callGetApi(ApiConstants.HOME, true);
  //   });
  // }
  //

  bool isExpanded = false;
  double initialExtent = minExtent;
  BuildContext draggableSheetContext;
  static const double minExtent = 0.15;
  static const double maxExtent = 1.0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (initialExtent != minExtent)
          _toggleDraggableScrollableSheet();
        else
          SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Builder(
          builder: (btncontext) => SafeArea(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: FutureBuilder(
                  future:
                      _callApi.callGetApi(ApiConstants.HOME, true), // homeData,
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    Widget child;

                    if (snapshot.hasData) {
                      homeJson = json.decode(snapshot.data);
                      if (homeJson['data'] != null) {
                        customerList = homeJson['data']['customerList'];
                        agentId.value = homeJson['data']['agentID'];
                        agentName.value = homeJson['data']['agentName'];
                        // log(snapshot.data);
                        // log(homeJson['data']['customerList'].toString());
                      }
                      child = Stack(
                        children: [
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            child: Column(
                              //physics: ClampingScrollPhysics(),
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          Icons.sort,
                                          color: GetColor.lightgray,
                                        ),
                                        onPressed: () {
                                          Scaffold.of(btncontext).openDrawer();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                                  child: GestureDetector(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) => Dialog(
                                                insetPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20,
                                                        vertical: 20),
                                                child: Stack(
                                                  children: [
                                                    AgentCardScreen(
                                                      id: agentId.value
                                                          .toString(),
                                                    ),
                                                    Align(
                                                        alignment:
                                                            Alignment.topRight,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(20.0),
                                                          child:
                                                              GestureDetector(
                                                            onTap: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                              child: Icon(Icons
                                                                  .clear_rounded),
                                                            ),
                                                          ),
                                                        )),
                                                  ],
                                                ),
                                              ));
                                    },
                                    child: Card(
                                      color: Theme.of(context).primaryColor,
                                      shadowColor: Colors.black,
                                      elevation: 10.0,
                                      semanticContainer: true,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      clipBehavior: Clip.hardEdge,
                                      child: Container(
                                        height: 180,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: ListTile(
                                                      title:
                                                          ValueListenableBuilder(
                                                        valueListenable:
                                                            agentName,
                                                        builder: (BuildContext
                                                                context,
                                                            dynamic value,
                                                            child) {
                                                          return Text(
                                                            value.toUpperCase(),
                                                            style:
                                                                Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyText2
                                                                    .merge(
                                                                      TextStyle(
                                                                          fontSize:
                                                                              20.0,
                                                                          color: GetColor
                                                                              .darkslategray,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                          );
                                                        },
                                                      ),
                                                      subtitle:
                                                          ValueListenableBuilder(
                                                        valueListenable:
                                                            agentId,
                                                        builder: (BuildContext
                                                                context,
                                                            dynamic value,
                                                            child) {
                                                          return Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 10.0),
                                                            child: Text(
                                                              'User ID : ${value.toString().padLeft(3, "0")}',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyText2
                                                                  .merge(
                                                                    TextStyle(
                                                                      color: Colors
                                                                              .grey[
                                                                          600],
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          16,
                                                                    ),
                                                                  ),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 20.0,
                                                            left: 20.0),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          "Powered By",
                                                          style: TextStyle(
                                                              fontSize: 16.0,
                                                              color: Colors
                                                                  .grey[600],
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        SizedBox(
                                                          width: 10.0,
                                                        ),
                                                        Image.asset(
                                                          'assets/blue-small.png',
                                                          height: 30.0,
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(20.0),
                                              child: FloatingActionButton(
                                                heroTag: "share-agent",
                                                onPressed: null,
                                                hoverColor: Theme.of(context)
                                                    .primaryColor,
                                                child: Icon(Icons.share),
                                                foregroundColor:
                                                    MyColors.darkBlue,
                                                backgroundColor:
                                                    Colors.indigo.shade50,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
                                  child: GridView.builder(
                                    itemCount: choices.length,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 5.0,
                                            mainAxisSpacing: 0.0),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return GestureDetector(
                                        onTap: () {
                                          print('index : $index');
                                          if (index == 0) {
                                            // Navigator.pushNamed(
                                            //     context, Routes.newcustomer);
                                            // _callApi.callProductAnalysis('957');
                                            Navigator.push(
                                              context,
                                              CupertinoPageRoute(
                                                builder: (context) =>
                                                    AgentProfile(),
                                              ),
                                            );
                                            // Navigator.pushNamed(
                                            //         context, '/agentDetail');
                                          }
                                          if (index == 1) {
                                            // Navigator.pushNamed(
                                            //     context, Routes.newcustomer);
                                            /*Navigator.pushNamed(
                                                btncontext, Routes.newcustomer);*/

                                            showBottomSheetLoanSelectOption();


                                          }
                                          if (index == 2) {
                                            // Navigator.pushNamed(
                                            //     context, Routes.newcustomer);
                                            Navigator.push(
                                              context,
                                              CupertinoPageRoute(
                                                builder: (context) =>
                                                    SelectLoanType(),
                                              ),
                                            );
                                          }
                                          if (index == 3) {
                                            _toggleDraggableScrollableSheet();
                                          }
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: GetCardButton(
                                            choice: choices[index],
                                            title: title[index],
                                          ),
                                        ),
                                      );
                                    },
                                    shrinkWrap: true,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          DraggableScrollableActuator(
                            child: DraggableScrollableSheet(
                              key: Key(initialExtent.toString()),
                              minChildSize: minExtent,
                              maxChildSize: maxExtent,
                              initialChildSize: initialExtent,
                              builder: (BuildContext context,
                                  ScrollController scrollController) {
                                draggableSheetContext = context;
                                return ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30)),
                                  child: Container(
                                    // color: Theme.of(context).scaffoldBackgroundColor,
                                    decoration: BoxDecoration(
                                      // color: Theme.of(context)
                                      //     .scaffoldBackgroundColor,
                                      border: Border(
                                        top: BorderSide(
                                            width: 0.3, color: Colors.white),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.white,
                                          offset: Offset(0.0, 1.0), //(x,y)
                                          blurRadius: 5.0,
                                        ),
                                      ],
                                    ),
                                    child: CustomScrollView(
                                      physics: const BouncingScrollPhysics(),
                                      controller: scrollController,
                                      slivers: [
                                        SliverAppBar(
                                          title: Column(
                                            children: [
                                              // Icon(
                                              //   Icons.arrow_upward_rounded,
                                              //   color: yellowColor(),
                                              // ),
                                              Text(
                                                'Your Customers',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline6
                                                    .merge(
                                                      TextStyle(fontSize: 14),
                                                    ),
                                              ),
                                            ],
                                          ),
                                          centerTitle: true,
                                          // backgroundColor: Colors.white,
                                          backgroundColor: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          automaticallyImplyLeading: false,
                                          primary: false,
                                          floating: true,
                                          pinned: true,
                                        ),
                                        SliverList(
                                          delegate: SliverChildBuilderDelegate(
                                            (context, idx) => Container(
                                              margin: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black,
                                                  ),
                                                  BoxShadow(
                                                    color: Theme.of(context)
                                                        .scaffoldBackgroundColor,
                                                    // spreadRadius: -1.0,
                                                    blurRadius: 2.0,
                                                  ),
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: ListTile(
                                                  onTap: () {
                                                    //TODO : got to customer details
                                                    Navigator.pushNamed(context,
                                                        '/customerDetail',
                                                        arguments: customerList[
                                                                        idx]
                                                                    ['id'] ==
                                                                null
                                                            ? ''
                                                            : customerList[idx]
                                                                    ['id']
                                                                .toString());
                                                  },
                                                  title: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      bottom: 8.0,
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          customerList[idx][
                                                                      'name'] ==
                                                                  null
                                                              ? ''
                                                              : customerList[
                                                                  idx]['name'],
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyText2
                                                                  .merge(
                                                                    TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w900,
                                                                      fontSize:
                                                                          16,
                                                                    ),
                                                                  ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                    bottom: 0,
                                                    left: 10,
                                                    right: 10,
                                                  ),
                                                  subtitle: Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "Loan Amount: " +
                                                                (customerList[idx]
                                                                            [
                                                                            'loan_amount'] ==
                                                                        null
                                                                    ? ''
                                                                    : numberFormatter(
                                                                        customerList[idx]
                                                                            [
                                                                            'loan_amount'])),
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText2
                                                                .copyWith(
                                                                  color: Colors
                                                                      .black,
                                                                  letterSpacing:
                                                                      0.4,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                          ),
                                                          Spacer(),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 7.0),
                                                            child: Text(
                                                              customerList[idx][
                                                                          'id'] ==
                                                                      null
                                                                  ? ''
                                                                  : 'Case Id : ' +
                                                                      customerList[idx]
                                                                              [
                                                                              'id']
                                                                          .toString(),
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyText2
                                                                  .merge(
                                                                    TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                              (customerList[idx][
                                                                          'product_name'] ==
                                                                      null
                                                                  ? ''
                                                                  : (customerList[
                                                                          idx][
                                                                      'product_name'])),
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyText2
                                                                  .copyWith(
                                                                    color: Colors
                                                                        .black,
                                                                    letterSpacing:
                                                                        0.4,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 10.0,
                                                          ),
                                                          Card(
                                                            color:
                                                                yellowColor(),
                                                            elevation: 3,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                customerList[idx]
                                                                            [
                                                                            'status'] ==
                                                                        "Not Selected"
                                                                    ? customerList[idx]['case_status'] ==
                                                                            null
                                                                        ? ''
                                                                        : CustomComponents.statusMapping(customerList[idx]['case_status'].toString())
                                                                            .toUpperCase()
                                                                    : customerList[idx]
                                                                            [
                                                                            'status']
                                                                        .toString()
                                                                        .toUpperCase(),
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .headline6
                                                                    .merge(
                                                                      TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            12,
                                                                      ),
                                                                    ),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  // trailing: Text(
                                                  //   customerList[idx]
                                                  //               ['status'] ==
                                                  //           "Not Selected"
                                                  //       ? customerList[idx][
                                                  //                   'case_status'] ==
                                                  //               null
                                                  //           ? ''
                                                  //           : CustomComponents.statusMapping(
                                                  //                   customerList[idx]
                                                  //                           [
                                                  //                           'case_status']
                                                  //                       .toString())
                                                  //               .toUpperCase()
                                                  //       : customerList[idx]
                                                  //               ['status']
                                                  //           .toString()
                                                  //           .toUpperCase(),
                                                  //   style: Theme.of(context)
                                                  //       .textTheme
                                                  //       .headline6
                                                  //       .merge(TextStyle(
                                                  //           color: Colors.white,
                                                  //           fontSize: 12)),
                                                  // ),
                                                ),
                                              ),
                                            ),
                                            childCount: customerList.length,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      child = Container(
                        padding: new EdgeInsets.all(32.0),
                        child: Center(
                          child: Column(
                            children: [
                              Card(
                                child: Container(
                                  padding: new EdgeInsets.all(32.0),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.error_outline_outlined,
                                        color: Colors.red[900],
                                      ),
                                      Text('Something went wrong')
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    } else {
                      child = Center(child: CircularProgressIndicator());
                    }
                    return child;
                  }),
            ),
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                currentAccountPicture: Image.asset("assets/blue-full.png"),
                currentAccountPictureSize: Size(140.0, 40.0),
                accountName: ValueListenableBuilder(
                  valueListenable: agentName,
                  builder: (context, value, _) => Text(
                    value.toUpperCase(),
                    style: Theme.of(context).textTheme.bodyText2.merge(
                          TextStyle(
                              color: GetColor.darkslategray,
                              fontWeight: FontWeight.bold),
                        ),
                  ),
                ),
                accountEmail: ValueListenableBuilder(
                  valueListenable: agentId,
                  builder: (context, value, _) => Text(
                    'User ID : ${value.toString().padLeft(3, "0")}',
                    style: Theme.of(context).textTheme.bodyText2.merge(
                          TextStyle(
                            color: GetColor.darkslategray,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => ReferralPaymentSlab(),
                    ),
                  );
                },
                leading: Icon(
                  Icons.payments_outlined,
                  color: backgroundColor(),
                ),
                title: Text('Referral Payout Slab'),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => MediaPageDesign(),
                    ),
                  );
                },
                leading: Icon(
                  Icons.article,
                  color: backgroundColor(),
                ),
                title: Text('Global Media'),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => LegalScreen(),
                    ),
                  );
                },
                leading: Icon(
                  Icons.security_rounded,
                  color: backgroundColor(),
                ),
                title: Text('Legal'),
              ),
              ListTile(
                onTap: () {
                  return showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Logout?'),
                          content: Text('Are you sure you want to logout?'),
                          actions: [
                            FlatButton(
                              child: Text('No'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            FlatButton(
                              child: Text('Yes'),
                              onPressed: () {
                                SharedPref sharedPref = new SharedPref();
                                sharedPref.clearPreferences();
                                Navigator.pushNamedAndRemoveUntil(context,
                                    Routes.login, (Route route) => false);
                              },
                            ),
                          ],
                          elevation: 24.0,
                        );
                      });
                },
                leading: Icon(
                  Icons.logout,
                  color: backgroundColor(),
                ),
                title: Text('Logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _toggleDraggableScrollableSheet() {
    if (draggableSheetContext != null) {
      setState(() {
        initialExtent = isExpanded ? minExtent : maxExtent;
        isExpanded = !isExpanded;
      });
      DraggableScrollableActuator.reset(draggableSheetContext);
    }
  }

  String numberFormatter(String newValue) {
    if (newValue.isEmpty) {
      return newValue;
    } else {
      final f = NumberFormat.currency(locale: 'HI', symbol: "");
      newValue = newValue.split(".")[0];
      final number = int.parse(newValue
          .replaceAll(",", "")
          .replaceAll(".00", "")
          .replaceAll(".", ""));
      var newString = f.format(number);
      newString = newString.replaceAll(".00", "");
      return newString;
    }
  }

  showBottomSheetLoanSelectOption() {
    showModalBottomSheet<dynamic>(
        isScrollControlled: true,
        context: context,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0),topRight:
        Radius.circular(10.0))),
        builder: (BuildContext bc) {
          return Wrap(
            children: [
              Center(
                child: Column(
                  children: [

                    Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          margin: const EdgeInsets.all(15.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.cancel,
                              color: GetColor.darkgray_background,
                              size: 35,
                            ),
                          ),
                        )),

                    Container(
                        child: Text("Selecting Type of Loan",style: TextStyle(fontSize: 16.0,color: GetColor.darkslategray,
                            fontWeight: FontWeight.w400),)),
                    Container(
                        margin: EdgeInsets.only(top: 25.0),
                        child: Text("Currently we have three type of loan in our marketplace- \n Personal Proffesional "
                            " and Business Loan.",style: TextStyle(fontSize: 12.0,color: GetColor.lightgray,
                           ),)),
                    Container(
                      margin: EdgeInsets.only(top: 35.0,left: 45.0,right: 45.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, Routes.findLoanQuesAns);
                            },
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(Theme.of(context).primaryColor),
                              backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).primaryColor),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                      side: BorderSide(color: Theme.of(context).primaryColor)
                                  )
                              ),
                            ),
                            child: Container(
                                margin: EdgeInsets.all(12.0),
                                child: const Text('Find out the loan for my customer',style: TextStyle(color: GetColor.darkslategray),))
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10.0,left: 45.0,right: 45.0,bottom: 70.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, Routes.newcustomer);
                            },
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(Theme.of(context).primaryColor),
                            backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).primaryColor),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                      side: BorderSide(color: Theme.of(context).primaryColor)
                                  )
                              ),
                          ),
                          child: Container(
                              margin: EdgeInsets.all(12.0),
                              child: const Text('I know want my customer needs',style: TextStyle(color:GetColor.darkslategray),))
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        });
  }


}

class Choice {
  const Choice({this.icon});
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(icon: Icons.settings),
  const Choice(icon: Icons.person_add),
  const Choice(icon: Icons.share),
  const Choice(icon: Icons.people),
];

const List<String> title = [
  "Profile Settings",
  "Add Customer",
  "Product Share",
  "Customer List"
];

class GetCardButton extends StatelessWidget {
  const GetCardButton({Key key, this.choice, this.title}) : super(key: key);
  final Choice choice;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 100,
      //height: 150,
      //margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: new Card(
        color: Theme.of(context).scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: new Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              new Icon(
                choice.icon,
                size: 40.0,
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(
                height: 10.0,
              ),
              new Text(title),
            ],
          ),
        ),
      ),
      decoration: new BoxDecoration(
        boxShadow: [
          // new BoxShadow(
          //   color: Colors.grey[500],
          //   blurRadius: 0.0,
          //   offset: new Offset(2.0, 2.0),
          // ),
          new BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 3.0,
            spreadRadius: 0.0,
            offset: Offset(4, 4),
          ),
        ],
        borderRadius: BorderRadius.circular(20.0),
      ),
    );
  }



}
