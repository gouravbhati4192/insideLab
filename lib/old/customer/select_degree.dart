import 'package:financial_freedom/old/Model/customerData.dart';
import 'package:financial_freedom/old/widgets/common/mycolors.dart';
import 'package:financial_freedom/old/widgets/common/raisedButton.dart';
import 'package:financial_freedom/old/widgets/common/routes.dart';
import 'package:financial_freedom/old/widgets/common/textfield.dart';
import 'package:flutter/material.dart';

class DoctorDegrees extends StatefulWidget {
  final Customer customerData;
  DoctorDegrees({this.customerData});

  @override
  _DoctorDegreesState createState() => _DoctorDegreesState();
}

class _DoctorDegreesState extends State<DoctorDegrees> {
  bool showfield = false;
  TextEditingController otherField = TextEditingController();
  nextpage(var context, String degreename) {
    widget.customerData.degreename = degreename;
    Navigator.pushNamed(context, Routes.basicDetailsCust,
        arguments: widget.customerData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Text(
                  'What is the Highest Degree of the Doctor',
                  style: Theme.of(context).textTheme.headline6.merge(
                        TextStyle(fontSize: 25),
                      ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 50,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ReusableButton(
                          btntext: 'mbbs'.toUpperCase(),
                          onclick: () {
                            nextpage(context, 'mbbs');
                          },
                        ),
                        ReusableButton(
                          btntext: 'md'.toUpperCase(),
                          onclick: () {
                            nextpage(context, 'md');
                          },
                        ),
                        ReusableButton(
                          btntext: 'ms'.toUpperCase(),
                          onclick: () {
                            nextpage(context, 'ms');
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ReusableButton(
                          btntext: 'dm'.toUpperCase(),
                          onclick: () {
                            nextpage(context, 'dm');
                          },
                        ),
                        ReusableButton(
                          btntext: 'dnb'.toUpperCase(),
                          onclick: () {
                            nextpage(context, 'dnb');
                          },
                        ),
                        SizedBox(
                          width: 90,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ReusableButton(
                          btntext: 'bds'.toUpperCase(),
                          onclick: () {
                            nextpage(context, 'bds');
                          },
                        ),
                        ReusableButton(
                          btntext: 'mds'.toUpperCase(),
                          onclick: () {
                            nextpage(context, 'mds');
                          },
                        ),
                        ReusableButton(
                          btntext: 'mch'.toUpperCase(),
                          onclick: () {
                            nextpage(context, 'mch');
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ReusableButton(
                          btntext: 'bhms'.toUpperCase(),
                          onclick: () {
                            nextpage(context, 'bhms');
                          },
                        ),
                        ReusableButton(
                          btntext: 'bams'.toUpperCase(),
                          onclick: () {
                            nextpage(context, 'bams');
                          },
                        ),
                        ReusableButton(
                          btntext: 'bums'.toUpperCase(),
                          onclick: () {
                            nextpage(context, 'bums');
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ReusableButton(
                          btntext: 'Others',
                          onclick: () {
                            // nextpage(context, 'others');
                            setState(() => showfield = !showfield);
                          },
                        ),
                      ],
                    ),
                    showfield
                        ? Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: GetTextField(
                                    controller: otherField,
                                    hinttext: 'Enter the Degree name',
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  height: 40,
                                  child: RaisedButton(
                                    color: MyColors.yellowColor(),
                                    onPressed: () {
                                      // CustomComponents.showBackStopDialog(context);
                                      print(otherField.text);
                                      nextpage(context, otherField.text.trim());
                                    },
                                    child: Text(
                                      'Next',
                                      style: Theme.of(context)
                                          .textTheme
                                          .button
                                          .copyWith(
                                            color: MyColors.backgroundColor(),
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : SizedBox.shrink(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
