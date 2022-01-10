import 'package:financial_freedom/old/Home/app-channel-partner.dart';
import 'package:financial_freedom/old/widgets/customer/customer-profile.dart';
import 'package:financial_freedom/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ReferralPaymentSlab extends StatefulWidget {
  ReferralPaymentSlab({Key key}) : super(key: key);

  @override
  _ReferralPaymentSlabState createState() => _ReferralPaymentSlabState();
}

class _ReferralPaymentSlabState extends State<ReferralPaymentSlab> {
  List slabData = [
    [
      {"slab": "Less than Rs 1 Crore", "pay": "2.00 %"},
      {"slab": "Rs 1 - 2 Crores", "pay": "2.25 %"},
      {"slab": "Rs 2 - 3 Crores", "pay": "2.50 %"},
      {"slab": "Rs 3 - 5 Crores", "pay": "2.75 %"},
      {"slab": "More than Rs 5 Crores", "pay": "3.00 %"},
    ],
    [
      {"slab": "Less than Rs 50 Lacs", "pay": "1.50 %"},
      {"slab": "Rs 50 Lacs - 1 Crore", "pay": "1.75 %"},
      {"slab": "Rs 1 - 1.5 Crores", "pay": "2.00 %"},
      {"slab": "Rs 1.5 - 2 Crores", "pay": "2.25 %"},
      {"slab": "More than Rs 2 Crores", "pay": "2.50 %"},
    ],
    [
      {"slab": "Less than Rs 25 Lacs", "pay": "0.75 %"},
      {"slab": "Rs 25 - 75 Lacs", "pay": "1.00 %"},
      {"slab": "Rs 75 Lacs - 1.25 Crores", "pay": "1.25 %"},
      {"slab": "Rs 1.25 - 2 Crores", "pay": "1.50 %"},
      {"slab": "More than Rs 2 Crores", "pay": "1.75 %"},
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Referral Payment Slab",
          style: TextStyle(
            color: backgroundColor(),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(
                "Insiderlab Fintech Pvt. Ltd. offers its users Referral Income in accordance with the following slab.\n\nOur users earn income by referring customer who are in need of loan(s) from the app.Based on the volume of total loan amount disbursed for our users’ monthly referrals, we transfer the income within the next 15 days of the monthly period.",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                decoration: BoxDecoration(
                  color: backgroundColor(),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Monthly Loan Disbursement (₹)",
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 12.0,
                            color: yellowColor(),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      margin: EdgeInsets.all(2.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Referral Earning %",
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12.0,
                            color: backgroundColor(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              ListView.separated(
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (context,i) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: Colors.grey[300],
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 20.0,
                    ),
                    Expanded(
                      child: Text(
                        slabData[slab - 1][i]["slab"],
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.black, fontSize: 16.0),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey[400],
                        ),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              slabData[slab - 1][i]["pay"],
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: backgroundColor(),
                                fontWeight: FontWeight.w700,
                                fontSize: 16.0,
                              ),
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            Text(
                              "of Loan Disbursement",
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: backgroundColor(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
                separatorBuilder: (context, i) => SizedBox(
                  height: 10.0,
                ),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Read more about our ",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => AppChannelPartner()));
                        },
                      text: "User service agreement,",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          launch(
                              "https://www.insiderlab.in/app-terms-component");
                        },
                      text: " Terms & Condition",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: " and ",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          launch(
                              "https://www.insiderlab.in/app-privacy-component");
                        },
                      text: "Privacy policy",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: " for users in theLegal Section of the App.",
                      style: TextStyle(
                        color: Colors.black,
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
