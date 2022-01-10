import 'package:financial_freedom/old/widgets/common/mycolors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class LeadPersonDetailsScreen extends StatefulWidget {
  LeadPersonDetailsScreen({Key key}) : super(key: key);

  @override
  _LeadPersonDetailsScreenState createState() =>
      _LeadPersonDetailsScreenState();
}

class _LeadPersonDetailsScreenState extends State<LeadPersonDetailsScreen> {
  bool edit = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 10.0),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  size: 35,
                  color: Colors.black,
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: RawMaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  onPressed: () {
                    setState(() {
                      edit = !edit;
                    });
                  },
                  fillColor: MyColors.yellowColor(),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      'Edit',
                      style:
                          Theme.of(context).primaryTextTheme.bodyText1.copyWith(
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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Text(
                'Nitesh Wadhwa',
                style: Theme.of(context).primaryTextTheme.bodyText1.copyWith(
                    fontSize: 22,
                    color: MyColors.backgroundColor(),
                    fontWeight: FontWeight.w700),
              ),
            ),
            Center(
              child: Text(
                'Quality Engineer',
                style: Theme.of(context).primaryTextTheme.bodyText1.copyWith(
                      fontSize: 16,
                      color: MyColors.textBoxColor(),
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(),
                  Card(
                      color: Colors.blueAccent[100],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.call, color: Colors.white),
                      )),
                  Spacer(),
                  Card(
                      color: Colors.blueAccent[100],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(FontAwesome.whatsapp, color: Colors.white),
                      )),
                  Spacer(),
                  Card(
                      color: Colors.blueAccent[100],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.mail, color: Colors.white),
                      )),
                  Spacer(),
                ],
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 5,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 4),
              itemBuilder: (c, i) {
                return textField(a: Icons.person, fieldData: 'Nitesh Wadhwa');
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 10.0,
              ),
              child: Row(
                children: [
                  Text(
                    'Schedule Appointments',
                    style:
                        Theme.of(context).primaryTextTheme.bodyText1.copyWith(
                              fontSize: 18,
                            ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: RawMaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      onPressed: () {
                        showCupertinoModalPopup(
                            context: context,
                            builder: (_) => Material(
                                  child: Container(
                                    height: 500,
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
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
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
                                                      style: Theme.of(context)
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
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 4.0),
                                                      child: RawMaterialButton(
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
                                                                  fontSize: 14,
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
                                          padding: const EdgeInsets.fromLTRB(
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
                                              initialDateTime: DateTime.now(),
                                              onDateTimeChanged: (val) {
                                                // setState(
                                                //     () {
                                                //   chosenDateTime =
                                                //       val;
                                                // });
                                              }),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
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
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 4.0),
                                                child: RawMaterialButton(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                  onPressed: () {},
                                                  fillColor: MyColors
                                                      .backgroundColor(),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12),
                                                    child: Text(
                                                      'Call',
                                                      style: Theme.of(context)
                                                          .primaryTextTheme
                                                          .bodyText1
                                                          .copyWith(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 4.0),
                                                child: RawMaterialButton(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                  onPressed: () {},
                                                  fillColor: MyColors
                                                      .backgroundColor(),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12),
                                                    child: Text(
                                                      'Meeting',
                                                      style: Theme.of(context)
                                                          .primaryTextTheme
                                                          .bodyText1
                                                          .copyWith(
                                                            fontSize: 14,
                                                            color: Colors.white,
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
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 4.0),
                                                child: RawMaterialButton(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                  onPressed: () {
                                                    // appointmentType =
                                                    //     "Send Text";
                                                    // setState(
                                                    //     () {});
                                                  },
                                                  fillColor: MyColors
                                                      .backgroundColor(),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12),
                                                    child: Text(
                                                      'Send Text',
                                                      style: Theme.of(context)
                                                          .primaryTextTheme
                                                          .bodyText1
                                                          .copyWith(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 4.0),
                                                child: RawMaterialButton(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                  onPressed: () {},
                                                  fillColor: MyColors
                                                      .backgroundColor(),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12),
                                                    child: Text(
                                                      'Follow-Up',
                                                      style: Theme.of(context)
                                                          .primaryTextTheme
                                                          .bodyText1
                                                          .copyWith(
                                                            fontSize: 14,
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
                                ));
                      },
                      fillColor: Colors.green,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 10.0,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.calendar_today_outlined,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Add New',
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
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 2,
              itemBuilder: (c, i) {
                return Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        20.0,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
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
                            '20/03/21',
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
                            '5:30PM',
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
                            'Call',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          Spacer(),
                          Icon(Icons.cancel)
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Row(
                children: [
                  Text(
                    'Notes',
                    style:
                        Theme.of(context).primaryTextTheme.bodyText1.copyWith(
                              fontSize: 18,
                            ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: BorderSide(color: Colors.grey.shade300),
                ),
                color: Colors.grey.shade100,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.multiline,
                    minLines: 5,
                    maxLines: 5,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      disabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: RawMaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                onPressed: () {},
                fillColor: MyColors.backgroundColor(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Convert as Customer',
                    style:
                        Theme.of(context).primaryTextTheme.bodyText1.copyWith(
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
    );
  }

  textField({IconData a, String fieldData}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            a,
            color: Colors.grey.shade400,
          ),
          Expanded(
            child: CupertinoTextField(
              enabled: edit ? true : false,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(10.0),
              ),
              placeholder: fieldData,
              placeholderStyle: TextStyle(color: Colors.black),
            ),
          )
        ],
      ),
    );
  }
}
