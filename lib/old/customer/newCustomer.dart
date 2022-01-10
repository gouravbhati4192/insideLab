import 'package:financial_freedom/old/Model/customerData.dart';
import 'package:financial_freedom/old/widgets/common/raisedButton.dart';
import 'package:financial_freedom/old/widgets/common/routes.dart';
import 'package:flutter/material.dart';

class NewCustomer extends StatefulWidget {
  @override
  _NewCustomerState createState() => _NewCustomerState();
}

class _NewCustomerState extends State<NewCustomer> {
  Customer
  customerData = new Customer();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    'Select a Loan type for your customer.',
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .merge(TextStyle(fontSize: 25)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  child: ReusableButton(
                    btntext: 'Personal Loan',
                    onclick: () {
                      setState(() {
                        customerData.loanType = 'Personal';
                      });
                      Navigator.pushNamed(context, Routes.profesionalLoan,
                          arguments: customerData);
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
                      Navigator.pushNamed(context, Routes.profesionalLoan,
                          arguments: customerData);
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
                      Navigator.pushNamed(context, Routes.profesionalLoan,
                          arguments: customerData);
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
