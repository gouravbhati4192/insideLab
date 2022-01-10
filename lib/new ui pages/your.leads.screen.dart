import 'package:financial_freedom/new%20ui%20pages/leads.person.details.screen.dart';
import 'package:financial_freedom/old/widgets/common/mycolors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class YourLeadsScreen extends StatefulWidget {
  YourLeadsScreen({Key key}) : super(key: key);

  @override
  _YourLeadsScreenState createState() => _YourLeadsScreenState();
}

class _YourLeadsScreenState extends State<YourLeadsScreen> {
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColors.yellowColor(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: MyColors.backgroundColor(),
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            addLead(context);
          },
        ),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
            child: Row(
              children: [
                Icon(
                  Icons.search,
                  size: 35,
                  color: Colors.black,
                ),
                Spacer(),
                Text(
                  'Your Leads',
                  style: Theme.of(context).textTheme.headline5.merge(
                        TextStyle(
                          fontSize: 18,
                          color: MyColors.backgroundColor(),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.cancel,
                    size: 35,
                    color: Colors.black,
                  ),
                )
              ],
            ),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0),
              topRight: Radius.circular(25.0),
            ),
          ),
          child: Container(
            height: 1000,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 10.0,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    selected = 0;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: selected == 0
                                          ? MyColors.yellowColor()
                                          : Colors.grey.shade200,
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  child: Center(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'All',
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .subtitle1,
                                    ),
                                  )),
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    selected = 1;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: selected == 1
                                          ? MyColors.yellowColor()
                                          : Colors.grey.shade200,
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  child: Center(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Confirmed',
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .subtitle1,
                                    ),
                                  )),
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    selected = 2;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: selected == 2
                                          ? MyColors.yellowColor()
                                          : Colors.grey.shade200,
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  child: Center(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'No Status',
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .subtitle1,
                                    ),
                                  )),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 2,
                    itemBuilder: (c, i) {
                      return (i % 2) == 0
                          ? cards(
                              name: 'Nitesh Wadhwa',
                              customerProfession: 'Quality Manager',
                              loanType: 'Personal Loan',
                              status: 'Reschedule',
                              amount: '1,00,000',
                              date: 'Created 5:50pm: 15 Sept 2021',
                              schedule: {
                                'date': '20/02/21',
                                'time': '5:30PM',
                                'type': 'Call'
                              },
                            )
                          : cards(
                              name: 'Nitesh Wadhwa',
                              customerProfession: 'Quality Manager',
                              loanType: 'Personal Loan',
                              status: 'Schedule',
                              amount: '1,00,000',
                              date: 'Created 5:50pm: 15 Sept 2021',
                              schedule: {},
                            );
                    },
                  )
                ],
              ),
            ),
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

  cards({
    String name,
    String customerProfession,
    String loanType,
    String status,
    String amount,
    String date,
    Map schedule,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: InkWell(
        onTap: () {
          if (status == 'Schedule') {
            descBottomSheet();
          } else {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => LeadPersonDetailsScreen(),
              ),
            );
          }
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: Theme.of(context)
                              .primaryTextTheme
                              .bodyText1
                              .copyWith(
                                  fontSize: 20,
                                  color: MyColors.backgroundColor(),
                                  fontWeight: FontWeight.w700),
                        ),
                        Text(
                          customerProfession,
                          style: Theme.of(context)
                              .primaryTextTheme
                              .bodyText1
                              .copyWith(
                                fontSize: 14,
                                color: MyColors.textBoxColor(),
                              ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Flexible(
                        child: Text(
                      date,
                      textAlign: TextAlign.center,
                      style:
                          Theme.of(context).primaryTextTheme.bodyText1.copyWith(
                                fontSize: 12,
                                color: MyColors.textBoxColor(),
                              ),
                    ))
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
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Divider(
                  color: MyColors.textBoxColor(),
                ),
              ),
              schedule.isEmpty
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.circle,
                          color: Colors.grey.shade400,
                          size: 20,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'No status',
                          style: TextStyle(
                            color: Colors.grey.shade500,
                          ),
                        )
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.calendar_today,
                          color: Colors.blue,
                          size: 20,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          schedule['date'],
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        Icon(
                          Icons.timer_rounded,
                          color: Colors.blue,
                          size: 20,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          schedule['time'],
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        Icon(
                          Icons.circle,
                          color: Colors.green,
                          size: 20,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          schedule['type'],
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        )
                      ],
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
                          onPressed: () {
                            showCupertinoModalPopup(
                                context: context,
                                builder: (_) => Material(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                            255,
                                            255,
                                            255,
                                            255,
                                          ),
                                        ),
                                        child: ClipRRect(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        32.0, 8.0, 0, 8.0),
                                                child: Text(
                                                  'Are you sure you want to cancel the appointment ?',
                                                  textAlign: TextAlign.center,
                                                  style: Theme.of(context)
                                                      .primaryTextTheme
                                                      .bodyText1
                                                      .copyWith(
                                                        fontSize: 18,
                                                        color: MyColors
                                                            .backgroundColor(),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 8, 0, 10),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal:
                                                                    4.0),
                                                        child:
                                                            RawMaterialButton(
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                          onPressed: () {},
                                                          fillColor: MyColors
                                                              .backgroundColor(),
                                                          child: Text(
                                                            'Yes',
                                                            style: Theme.of(
                                                                    context)
                                                                .primaryTextTheme
                                                                .bodyText1
                                                                .copyWith(
                                                                  fontSize: 16,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal:
                                                                    4.0),
                                                        child:
                                                            RawMaterialButton(
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          fillColor: Colors
                                                              .grey.shade200,
                                                          child: Text(
                                                            'No, I will follow-up',
                                                            style: Theme.of(
                                                                    context)
                                                                .primaryTextTheme
                                                                .bodyText1
                                                                .copyWith(
                                                                  fontSize: 16,
                                                                  color: Colors
                                                                      .black,
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
                                      ),
                                    ));
                          },
                          fillColor: Colors.grey.shade200,
                          child: Text(
                            'Cancel',
                            style: Theme.of(context)
                                .primaryTextTheme
                                .bodyText1
                                .copyWith(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: RawMaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          onPressed: () {
                            showCupertinoModalPopup(
                                context: context,
                                builder: (_) => Material(
                                      child: Container(
                                        height: 500,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: SizedBox(
                                                height: 60,
                                                child: Center(
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 0,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10.0),
                                                          child: InkWell(
                                                            onTap: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: Icon(
                                                              Icons.cancel,
                                                              size: 30,
                                                              color: MyColors
                                                                  .backgroundColor(),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          '',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: Theme.of(
                                                                  context)
                                                              .primaryTextTheme
                                                              .bodyText1
                                                              .copyWith(
                                                                fontSize: 20,
                                                                color: MyColors
                                                                    .backgroundColor(),
                                                              ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 0,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      4.0),
                                                          child:
                                                              RawMaterialButton(
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                            ),
                                                            onPressed: () {},
                                                            fillColor: MyColors
                                                                .yellowColor(),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(12),
                                                              child: Text(
                                                                'Done',
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
                                                  const EdgeInsets.fromLTRB(
                                                      32.0, 8.0, 0, 8.0),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'Select Time & Date',
                                                    textAlign: TextAlign.center,
                                                    style: Theme.of(context)
                                                        .primaryTextTheme
                                                        .bodyText1
                                                        .copyWith(
                                                          fontSize: 14,
                                                          color: MyColors
                                                              .backgroundColor(),
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: 150,
                                              child: CupertinoDatePicker(
                                                  initialDateTime:
                                                      DateTime.now(),
                                                  onDateTimeChanged: (val) {
                                                    // setState(
                                                    //     () {
                                                    //   chosenDateTime =
                                                    //       val;
                                                    // });
                                                  }),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      32.0, 8.0, 0, 8.0),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'Select Appointment Type',
                                                    textAlign: TextAlign.center,
                                                    style: Theme.of(context)
                                                        .primaryTextTheme
                                                        .bodyText1
                                                        .copyWith(
                                                          fontSize: 14,
                                                          color: MyColors
                                                              .backgroundColor(),
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                left: MediaQuery.of(context)
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
                                                        horizontal: 4.0),
                                                    child: RawMaterialButton(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      onPressed: () {},
                                                      fillColor: MyColors
                                                          .backgroundColor(),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(12),
                                                        child: Text(
                                                          'Call',
                                                          style: Theme.of(
                                                                  context)
                                                              .primaryTextTheme
                                                              .bodyText1
                                                              .copyWith(
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 4.0),
                                                    child: RawMaterialButton(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      onPressed: () {},
                                                      fillColor: MyColors
                                                          .backgroundColor(),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(12),
                                                        child: Text(
                                                          'Meeting',
                                                          style: Theme.of(
                                                                  context)
                                                              .primaryTextTheme
                                                              .bodyText1
                                                              .copyWith(
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .white,
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
                                                  left: MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          2 -
                                                      50),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 4.0),
                                                    child: RawMaterialButton(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      onPressed: () {},
                                                      fillColor: MyColors
                                                          .backgroundColor(),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(12),
                                                        child: Text(
                                                          'Send Text',
                                                          style: Theme.of(
                                                                  context)
                                                              .primaryTextTheme
                                                              .bodyText1
                                                              .copyWith(
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 4.0),
                                                    child: RawMaterialButton(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      onPressed: () {},
                                                      fillColor: MyColors
                                                          .backgroundColor(),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(12),
                                                        child: Text(
                                                          'Follow-Up',
                                                          style: Theme.of(
                                                                  context)
                                                              .primaryTextTheme
                                                              .bodyText1
                                                              .copyWith(
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .white,
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
                          fillColor: status == 'Schedule'
                              ? Colors.green
                              : MyColors.backgroundColor(),
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  descBottomSheet() {
    showCupertinoModalPopup(
        context: context,
        builder: (_) => Material(
              child: Container(
                height: 600,
                color: Color.fromARGB(255, 255, 255, 255),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
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
                                      Icons.arrow_downward,
                                      size: 30,
                                      color: MyColors.backgroundColor(),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '',
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  child: RawMaterialButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    onPressed: () {},
                                    fillColor: MyColors.yellowColor(),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Text(
                                        'Edit',
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
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      child: Card(
                        elevation: 5,
                        color: Colors.grey[50],
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Name :',
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .bodyText1
                                          .copyWith(
                                            fontSize: 16,
                                            color: MyColors.backgroundColor(),
                                          ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      'Nitesh Wadhwa',
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .bodyText1
                                          .copyWith(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Loan Required :',
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .bodyText1
                                          .copyWith(
                                            fontSize: 16,
                                            color: MyColors.backgroundColor(),
                                          ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      '10,00,000',
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .bodyText1
                                          .copyWith(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Loan Type :',
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .bodyText1
                                          .copyWith(
                                            fontSize: 16,
                                            color: MyColors.backgroundColor(),
                                          ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      'Personal Loan',
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .bodyText1
                                          .copyWith(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: MyColors.backgroundColor(),
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Created : 5:00pm; 15th Sept 2021',
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .bodyText1
                                          .copyWith(
                                            fontSize: 14,
                                            color: Colors.grey.shade500,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 80,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15),
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Notes',
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
                            ),
                          ],
                        ),
                      ),
                    ),
                    RawMaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      onPressed: () {},
                      fillColor: MyColors.yellowColor(),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          'Follow-up',
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
                    Text(
                      '4:00 pm; 20th Sept',
                      textAlign: TextAlign.center,
                      style:
                          Theme.of(context).primaryTextTheme.bodyText1.copyWith(
                                fontSize: 24,
                                color: MyColors.backgroundColor(),
                              ),
                    ),
                    Card(
                      elevation: 5,
                      color: Colors.grey[50],
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(32.0, 8.0, 0, 8.0),
                            child: Row(
                              children: [
                                Text(
                                  'Select Time & Date',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .bodyText1
                                      .copyWith(
                                        fontSize: 14,
                                        color: MyColors.backgroundColor(),
                                      ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 150,
                            child: CupertinoDatePicker(
                                initialDateTime: DateTime.now(),
                                onDateTimeChanged: (val) {
                                  // setState(
                                  //     () {
                                  //   chosenDateTime =
                                  //       val;
                                  // });
                                }),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ));
  }
}
