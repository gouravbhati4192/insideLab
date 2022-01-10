import 'package:financial_freedom/controller/user.controller.dart';
import 'package:financial_freedom/new%20ui%20pages/customer%20registration/onboarding.process.screen.dart';
import 'package:financial_freedom/new%20ui%20pages/customer.details.screen.dart';
import 'package:financial_freedom/screens/business-card/my.card.screen.dart';
import 'package:financial_freedom/new%20ui%20pages/your.leads.screen.dart';
import 'package:financial_freedom/old/widgets/common/mycolors.dart';
import 'package:financial_freedom/style/color.style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  UserController userController;
  @override
  Widget build(BuildContext context) {
    userController = Provider.of<UserController>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        drawer: _drawer(context),
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: MyColors.backgroundColor(),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            SizedBox(
              width: 60,
              child: Icon(
                Icons.notifications,
                color: Colors.black,
              ),
            )
          ],
        ),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: ListView(
                shrinkWrap: true,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25.0, 8.0, 0.0, 0.0),
                    child: Text(
                      'Welcome ${userController.user.name},',
                      style: Theme.of(context).textTheme.headline5.merge(
                            TextStyle(
                              fontSize: 22,
                              color: MyColors.backgroundColor(),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                    ),
                  ),
                  insiderLabCard(),
                  gridViewTabs(context),
                ],
              ),
            ),
            DraggableScrollableSheet(
              minChildSize: 0.08,
              initialChildSize: 0.08,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return Theme(
                  data: ThemeData(textTheme: TextTheme()),
                  child: Container(
                    decoration: BoxDecoration(
                      color: MyColors.yellowColor(),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      child: CustomScrollView(
                        physics: const BouncingScrollPhysics(),
                        controller: scrollController,
                        slivers: [
                          SliverAppBar(
                            backgroundColor: MyColors.yellowColor(),
                            title: Column(
                              children: [
                                Icon(
                                  Icons.keyboard_arrow_up,
                                  color: MyColors.backgroundColor(),
                                ),
                                Text(
                                  'Your Customers',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .merge(
                                        TextStyle(
                                          fontSize: 16,
                                          color: MyColors.backgroundColor(),
                                        ),
                                      ),
                                ),
                              ],
                            ),
                            centerTitle: true,
                            automaticallyImplyLeading: false,
                            primary: false,
                            floating: true,
                            pinned: true,
                          ),
                          SliverToBoxAdapter(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15),
                                ),
                                color: Colors.white,
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                      vertical: 12.0,
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.filter_alt,
                                          color: MyColors.textBoxColor()
                                              .withOpacity(0.9),
                                        ),
                                        Spacer(),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: MyColors.textBoxColor()
                                                .withOpacity(0.2),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0,
                                            ),
                                            child: DropdownButton(
                                              value: 'All Customers',
                                              underline: SizedBox.shrink(),
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                              hint: Text(
                                                "",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              icon: Icon(
                                                  Icons.keyboard_arrow_down),
                                              items: [
                                                'All Customers',
                                                'Customer - This Month'
                                              ].map((String items) {
                                                return DropdownMenuItem(
                                                    value: items,
                                                    child: Text(items));
                                              }).toList(),
                                              onChanged: (a) {
                                                setState(() {});
                                              },
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: MyColors.textBoxColor()
                                                .withOpacity(0.2),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0,
                                            ),
                                            child: DropdownButton(
                                              value: 'Active',
                                              underline: SizedBox.shrink(),
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                              hint: Text(
                                                "",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              icon: Icon(
                                                  Icons.keyboard_arrow_down),
                                              items: [
                                                'Active',
                                                'Login',
                                                'Approved',
                                                'Disbursed',
                                                'Rejected'
                                              ].map((String items) {
                                                return DropdownMenuItem(
                                                    value: items,
                                                    child: Text(items));
                                              }).toList(),
                                              onChanged: (a) {
                                                setState(() {});
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                          30.0,
                                          0,
                                          0,
                                          10.0,
                                        ),
                                        child: Text(
                                          'Customer applications : 10 out of 30',
                                          style: Theme.of(context)
                                              .primaryTextTheme
                                              .bodyText1
                                              .copyWith(
                                                fontSize: 16,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                          30.0,
                                          0,
                                          0,
                                          10.0,
                                        ),
                                        child: Text(
                                          'Total Loan Amount : ₹ 10,30,000',
                                          style: Theme.of(context)
                                              .primaryTextTheme
                                              .bodyText1
                                              .copyWith(
                                                fontSize: 16,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                          30.0,
                                          0,
                                          0,
                                          5.0,
                                        ),
                                        child: Text(
                                          'Potential Earnings : ₹ 1,50,000',
                                          style: Theme.of(context)
                                              .primaryTextTheme
                                              .bodyText1
                                              .copyWith(
                                                fontSize: 16,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                          30.0,
                                          0,
                                          0,
                                          10.0,
                                        ),
                                        child: Text(
                                          '(Approved & Disbursed applications)',
                                          style: Theme.of(context)
                                              .primaryTextTheme
                                              .bodyText1
                                              .copyWith(
                                                fontSize: 16,
                                                color: MyColors.textBoxColor(),
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (c, i) {
                                      return bottomSheetCard(
                                        name: 'Nitesh Wadhwa',
                                        action: 'Not Required',
                                        loanType: 'Personal Loan',
                                        percent: '11 - 15',
                                        product: 'Bajaj Finance',
                                        status: 'Upload Document',
                                        currentStageIndex: 2,
                                        amount: '1,00,000',
                                      );
                                    },
                                    itemCount: 7,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: Image.asset("assets/blue-full.png"),
            currentAccountPictureSize: Size(140.0, 40.0),
            accountName: Text(
              this.userController.user.name,
              style: Theme.of(context).textTheme.bodyText2.merge(
                    TextStyle(
                      color: ColorStyle.darkGray,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
            ),
            accountEmail: Text(
              'User ID : ${this.userController.user.id}',
              style: Theme.of(context).textTheme.bodyText2.merge(
                    TextStyle(
                      color: ColorStyle.darkGray,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
          ListTile(
            onTap: () {
              // Navigator.push(
              //   context,
              //   CupertinoPageRoute(
              //     builder: (context) => ReferralPaymentSlab(),
              //   ),
              // );
            },
            leading: Icon(
              Icons.payments_outlined,
              color: backgroundColor(),
            ),
            title: Text('Referral Payout Slab'),
          ),
          ListTile(
            onTap: () {
              // Navigator.push(
              //   context,
              //   CupertinoPageRoute(
              //     builder: (context) => LegalScreen(),
              //   ),
              // );
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
                            // SharedPref sharedPref = new SharedPref();
                            // sharedPref.clearPreferences();
                            // Navigator.pushNamedAndRemoveUntil(
                            //     context, Routes.login, (Route route) => false);
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
    );
  }

  insiderLabCard() {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => MyCardScreen(),
            ),
          );
        },
        child: Hero(
          tag: 'insiderCard',
          child: Card(
            color: Theme.of(context).primaryColor,
            shadowColor: Colors.black,
            elevation: 10.0,
            semanticContainer: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            clipBehavior: Clip.hardEdge,
            child: Container(
              height: 180,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 0.0,
                            left: 20.0,
                            top: 10.0,
                          ),
                          child: Row(
                            children: [
                              Text(
                                "powered by,",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 0.0,
                            right: 10.0,
                            top: 10.0,
                          ),
                          child: Icon(
                            Icons.zoom_out_map_rounded,
                            color: MyColors.backgroundColor(),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Image.asset(
                          'assets/blue-full.png',
                          height: 60.0,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        bottom: 0.0,
                        left: 10.0,
                        right: 10.0,
                        top: 0.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "www.insiderlab.in",
                            style: TextStyle(
                                fontSize: 13.0,
                                fontStyle: FontStyle.italic,
                                color: MyColors.backgroundColor(),
                                fontWeight: FontWeight.bold),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.home_filled,
                                color: MyColors.backgroundColor(),
                              ),
                              SizedBox(
                                width: 30,
                                // height: 30,
                                child: Divider(
                                  thickness: 1,
                                  color: MyColors.backgroundColor(),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "admin@insiderlab.in",
                            style: TextStyle(
                                fontSize: 13.0,
                                fontStyle: FontStyle.italic,
                                color: MyColors.backgroundColor(),
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
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

  gridViewTabs(BuildContext c) {
    List gridData = [
      {"icon": Icons.settings, "title": "Profile Setting"},
      {"icon": Icons.settings, "title": "Insight"},
      {"icon": Icons.settings, "title": "Share Products"},
      {"icon": Icons.settings, "title": "Your Leads"}
    ];
    return Container(
      height: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: gridData.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 0.0,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: InkWell(
                      onTap: () {
                        if (index == 3) {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => YourLeadsScreen(),
                            ),
                          );
                        }
                      },
                      child: Card(
                        elevation: 5,
                        color: Theme.of(context).scaffoldBackgroundColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: new Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              new Icon(
                                gridData[index]['icon'],
                                size: 40.0,
                                color: Theme.of(context).primaryColor,
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              new Text(gridData[index]['title']),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              Container(
                alignment: Alignment.center,
                height: 420,
                child: InkWell(
                  onTap: () {
                    showDialog(
                      context: c,
                      builder: (con) {
                        return AlertDialog(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              side: BorderSide(color: Colors.grey, width: 1.5)),
                          contentPadding: const EdgeInsets.all(0),
                          content: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 30,
                                  child: Center(
                                    child: Row(
                                      children: [
                                        Spacer(),
                                        InkWell(
                                          onTap: () {
                                            Navigator.pop(con);
                                          },
                                          child: Icon(
                                            Icons.cancel,
                                            color: MyColors.backgroundColor(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  child: RawMaterialButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    onPressed: () {
                                      addLead(c);
                                    },
                                    fillColor: MyColors.yellowColor(),
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Add a Lead',
                                            style: Theme.of(context)
                                                .primaryTextTheme
                                                .bodyText1
                                                .copyWith(
                                                  fontSize: 14,
                                                  color: MyColors
                                                      .backgroundColor(),
                                                ),
                                          ),
                                          Spacer(),
                                          Icon(
                                            Icons.arrow_right,
                                            size: 40,
                                            color: MyColors.backgroundColor(),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      3.0, 4.0, 0.0, 0),
                                  child: Text(
                                    'Click here to Add individuals who inquire for Loan.',
                                    textAlign: TextAlign.start,
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .bodyText1
                                        .copyWith(
                                          fontSize: 10,
                                          color: MyColors.textBoxColor(),
                                        ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      3.0, 4.0, 0.0, 0),
                                  child: Text(
                                    'This feature enable you tu create Sales Funnel of prospective customer.',
                                    textAlign: TextAlign.start,
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .bodyText1
                                        .copyWith(
                                          fontSize: 10,
                                          color: MyColors.textBoxColor(),
                                        ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      3.0, 4.0, 0.0, 0),
                                  child: Text(
                                    'Later, Convert your Lead to Customer when they are ready to apply for the loan.',
                                    textAlign: TextAlign.start,
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .bodyText1
                                        .copyWith(
                                          fontSize: 10,
                                          color: MyColors.textBoxColor(),
                                        ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  child: RawMaterialButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (context) =>
                                              OnboardingProcessScreen(),
                                        ),
                                      );
                                    },
                                    fillColor: MyColors.yellowColor(),
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Create a Customer',
                                            style: Theme.of(context)
                                                .primaryTextTheme
                                                .bodyText1
                                                .copyWith(
                                                  fontSize: 14,
                                                  color: MyColors
                                                      .backgroundColor(),
                                                ),
                                          ),
                                          Spacer(),
                                          Icon(
                                            Icons.arrow_right,
                                            size: 40,
                                            color: MyColors.backgroundColor(),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      3.0, 4.0, 0.0, 0),
                                  child: Text(
                                    'Click here to apply loan for an individual.',
                                    textAlign: TextAlign.start,
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .bodyText1
                                        .copyWith(
                                          fontSize: 10,
                                          color: MyColors.textBoxColor(),
                                        ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      3.0, 4.0, 0.0, 0),
                                  child: Text(
                                    'To create customer KYC & PAN of customer is mandatory.',
                                    textAlign: TextAlign.start,
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .bodyText1
                                        .copyWith(
                                          fontSize: 10,
                                          color: MyColors.textBoxColor(),
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        backgroundColor: MyColors.yellowColor(),
                        radius: 40,
                        child: Icon(
                          Icons.person_add_alt_1,
                          size: 40,
                          color: MyColors.backgroundColor(),
                        ),
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  addLead(BuildContext c) {
    TextEditingController name = TextEditingController();
    TextEditingController phone = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController location = TextEditingController();
    TextEditingController loanType = TextEditingController();
    TextEditingController note = TextEditingController();
    buildTextField(
        TextEditingController c, String hintText, TextInputType keyboardType) {
      return SizedBox(
        height: 60,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Container(
            decoration: BoxDecoration(
              color: MyColors.yellowColor(),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: TextFormField(
              keyboardType: keyboardType,
              controller: c,
              decoration: InputDecoration(
                hintText: hintText,
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
      );
    }

    DateTime chosenDateTime;
    String appointmentType;
    return showModalBottomSheet(
      enableDrag: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
      ),
      isScrollControlled: true,
      context: c,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height - 200,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 60,
                child: Center(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.cancel,
                              size: 30,
                              color: MyColors.backgroundColor(),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Add a Lead',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .primaryTextTheme
                              .bodyText1
                              .copyWith(
                                fontSize: 20,
                                color: MyColors.backgroundColor(),
                              ),
                        ),
                      ),
                      Expanded(
                        flex: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Icon(
                            Icons.cancel,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Form(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 50.0,
                            vertical: 10.0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildTextField(name, 'Name', TextInputType.text),
                              buildTextField(
                                  phone, 'Phone Number', TextInputType.text),
                              buildTextField(
                                  email, 'Email Address', TextInputType.text),
                              buildTextField(
                                  location, 'Location', TextInputType.text),
                              buildTextField(
                                  loanType, 'Loan Type', TextInputType.text),
                              SizedBox(
                                // height: 60,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: TextFormField(
                                      keyboardType: TextInputType.multiline,
                                      maxLines: 4,
                                      controller: note,
                                      decoration: InputDecoration(
                                        hintText: 'Notes...',
                                        // hintStyle: TextStyle(color: Colors.white),
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
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    child: RawMaterialButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      onPressed: () {
                                        showCupertinoModalPopup(
                                            context: context,
                                            builder: (_) => Material(
                                                  child: Container(
                                                    height: 500,
                                                    color: Color.fromARGB(
                                                        255, 255, 255, 255),
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: SizedBox(
                                                            height: 60,
                                                            child: Center(
                                                              child: Row(
                                                                children: [
                                                                  Expanded(
                                                                    flex: 0,
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .all(
                                                                          10.0),
                                                                      child:
                                                                          InkWell(
                                                                        onTap:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .cancel,
                                                                          size:
                                                                              30,
                                                                          color:
                                                                              MyColors.backgroundColor(),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    child: Text(
                                                                      '',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: Theme.of(
                                                                              context)
                                                                          .primaryTextTheme
                                                                          .bodyText1
                                                                          .copyWith(
                                                                            fontSize:
                                                                                20,
                                                                            color:
                                                                                MyColors.backgroundColor(),
                                                                          ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 0,
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          horizontal:
                                                                              4.0),
                                                                      child:
                                                                          RawMaterialButton(
                                                                        shape:
                                                                            RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(10.0),
                                                                        ),
                                                                        onPressed:
                                                                            () {},
                                                                        fillColor:
                                                                            MyColors.yellowColor(),
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(12),
                                                                          child:
                                                                              Text(
                                                                            'Done',
                                                                            style: Theme.of(context).primaryTextTheme.bodyText1.copyWith(
                                                                                  fontSize: 14,
                                                                                  color: MyColors.backgroundColor(),
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  32.0,
                                                                  8.0,
                                                                  0,
                                                                  8.0),
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                'Select Time & Date',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: Theme.of(
                                                                        context)
                                                                    .primaryTextTheme
                                                                    .bodyText1
                                                                    .copyWith(
                                                                      fontSize:
                                                                          14,
                                                                      color: MyColors
                                                                          .backgroundColor(),
                                                                    ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          height: 150,
                                                          child:
                                                              CupertinoDatePicker(
                                                                  initialDateTime:
                                                                      DateTime
                                                                          .now(),
                                                                  onDateTimeChanged:
                                                                      (val) {
                                                                    setState(
                                                                        () {
                                                                      chosenDateTime =
                                                                          val;
                                                                    });
                                                                  }),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  32.0,
                                                                  8.0,
                                                                  0,
                                                                  8.0),
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                'Select Appointment Type',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: Theme.of(
                                                                        context)
                                                                    .primaryTextTheme
                                                                    .bodyText1
                                                                    .copyWith(
                                                                      fontSize:
                                                                          14,
                                                                      color: MyColors
                                                                          .backgroundColor(),
                                                                    ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                            left: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width /
                                                                    2 -
                                                                50,
                                                            top: 40.0,
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        4.0),
                                                                child:
                                                                    RawMaterialButton(
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10.0),
                                                                  ),
                                                                  onPressed:
                                                                      () {},
                                                                  fillColor:
                                                                      MyColors
                                                                          .backgroundColor(),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            12),
                                                                    child: Text(
                                                                      'Call',
                                                                      style: Theme.of(
                                                                              context)
                                                                          .primaryTextTheme
                                                                          .bodyText1
                                                                          .copyWith(
                                                                            fontSize:
                                                                                14,
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        4.0),
                                                                child:
                                                                    RawMaterialButton(
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10.0),
                                                                  ),
                                                                  onPressed:
                                                                      () {},
                                                                  fillColor:
                                                                      MyColors
                                                                          .backgroundColor(),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            12),
                                                                    child: Text(
                                                                      'Meeting',
                                                                      style: Theme.of(
                                                                              context)
                                                                          .primaryTextTheme
                                                                          .bodyText1
                                                                          .copyWith(
                                                                            fontSize:
                                                                                14,
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets.only(
                                                              left: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width /
                                                                      2 -
                                                                  50),
                                                          child: Row(
                                                            children: [
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        4.0),
                                                                child:
                                                                    RawMaterialButton(
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10.0),
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    appointmentType =
                                                                        "Send Text";
                                                                    setState(
                                                                        () {});
                                                                  },
                                                                  fillColor:
                                                                      MyColors
                                                                          .backgroundColor(),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            12),
                                                                    child: Text(
                                                                      'Send Text',
                                                                      style: Theme.of(
                                                                              context)
                                                                          .primaryTextTheme
                                                                          .bodyText1
                                                                          .copyWith(
                                                                            fontSize:
                                                                                14,
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        4.0),
                                                                child:
                                                                    RawMaterialButton(
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10.0),
                                                                  ),
                                                                  onPressed:
                                                                      () {},
                                                                  fillColor:
                                                                      MyColors
                                                                          .backgroundColor(),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            12),
                                                                    child: Text(
                                                                      'Follow-Up',
                                                                      style: Theme.of(
                                                                              context)
                                                                          .primaryTextTheme
                                                                          .bodyText1
                                                                          .copyWith(
                                                                            fontSize:
                                                                                14,
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ));
                                      },
                                      fillColor: Colors.green,
                                      child: Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.calendar_today_outlined,
                                              color: Colors.white,
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              'Schedule',
                                              style: Theme.of(context)
                                                  .primaryTextTheme
                                                  .bodyText1
                                                  .copyWith(
                                                    fontSize: 14,
                                                    color: Colors.white,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: FlatButton(
                                  onPressed: () {
                                    Navigator.pop(c);
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "Save Lead",
                                    style: TextStyle(
                                        color: MyColors.yellowColor()),
                                  ),
                                  color: MyColors.backgroundColor(),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      20.0,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 500,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  bottomSheetCard({
    String name,
    String loanType,
    String product,
    String percent,
    String status,
    String action,
    int currentStageIndex,
    String amount,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => CustomerDetailsScreen(),
            ),
          );
        },
        child: Card(
          color: Colors.white,
          elevation: 7,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 8, 0, 0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        style: Theme.of(context)
                            .primaryTextTheme
                            .bodyText1
                            .copyWith(
                                fontSize: 20,
                                color: MyColors.backgroundColor(),
                                fontWeight: FontWeight.w700),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: List.generate(
                          7,
                          (index) {
                            return Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: CircleAvatar(
                                radius: 5,
                                backgroundColor: index < currentStageIndex
                                    ? MyColors.yellowColor()
                                    : MyColors.textBoxColor(),
                              ),
                            );
                          },
                        ).toList(),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 8, 0, 0),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Icon(
                            Icons.person,
                            color: MyColors.backgroundColor(),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            loanType,
                            style: Theme.of(context)
                                .primaryTextTheme
                                .bodyText1
                                .copyWith(
                                  fontSize: 16,
                                  color: MyColors.backgroundColor(),
                                ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Icon(
                            Icons.person,
                            color: MyColors.backgroundColor(),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            product,
                            style: Theme.of(context)
                                .primaryTextTheme
                                .bodyText1
                                .copyWith(
                                  fontSize: 16,
                                  color: MyColors.backgroundColor(),
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 8, 0, 0),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Icon(
                            Icons.person,
                            color: MyColors.backgroundColor(),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            amount,
                            style: Theme.of(context)
                                .primaryTextTheme
                                .bodyText1
                                .copyWith(
                                  fontSize: 16,
                                  color: MyColors.backgroundColor(),
                                ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Icon(
                            Icons.person,
                            color: MyColors.backgroundColor(),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            percent,
                            style: Theme.of(context)
                                .primaryTextTheme
                                .bodyText1
                                .copyWith(
                                  fontSize: 16,
                                  color: MyColors.backgroundColor(),
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 8, 0, 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: RawMaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          onPressed: () {},
                          fillColor: MyColors.backgroundColor(),
                          child: Text(
                            status,
                            style: Theme.of(context)
                                .primaryTextTheme
                                .bodyText1
                                .copyWith(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Text(
                            'Action :',
                            style: Theme.of(context)
                                .primaryTextTheme
                                .bodyText1
                                .copyWith(
                                  fontSize: 16,
                                  color: MyColors.backgroundColor(),
                                ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            action,
                            style: Theme.of(context)
                                .primaryTextTheme
                                .bodyText1
                                .copyWith(
                                  fontSize: 16,
                                  color: MyColors.textBoxColor(),
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
