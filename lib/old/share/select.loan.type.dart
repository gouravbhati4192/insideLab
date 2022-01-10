import 'package:financial_freedom/new%20ui%20pages/customer.details.screen.dart';
import 'package:financial_freedom/old/Model/customerData.dart';
import 'package:financial_freedom/old/share/select.product.dart';
import 'package:financial_freedom/old/widgets/common/raisedButton.dart';
import 'package:financial_freedom/old/widgets/common/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectLoanType extends StatefulWidget {
  @override
  _SelectLoanTypeState createState() => _SelectLoanTypeState();
}

class _SelectLoanTypeState extends State<SelectLoanType> {
  Customer customerData = new Customer();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: yellowColor()),
        title: Text(
          'Select a Loan type',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline6.merge(
                TextStyle(
                  fontSize: 18,
                  color: yellowColor(),
                ),
              ),
        ),
      ),
      body: SafeArea(
        child: Builder(
          builder: (btncontext) => Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  child: ReusableButton(
                    btntext: 'Personal Loan',
                    onclick: () {
                      setState(() {
                        customerData.loanType = 'Personal';
                      });
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => SelectProduct('Personal Loan'),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  child: ReusableButton(
                    btntext: 'Professional Loan',
                    onclick: () {
                      setState(() {
                        customerData.loanType = 'Professional';
                      });
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) =>
                              SelectProduct('Professional Loan'),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  child: ReusableButton(
                    btntext: 'Business Loan',
                    onclick: () {
                      setState(() {
                        customerData.loanType = 'Business';
                      });
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => SelectProduct('Business Loan'),
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
    );
  }
}
