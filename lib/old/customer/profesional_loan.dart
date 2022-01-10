import 'package:financial_freedom/old/Model/customerData.dart';
import 'package:financial_freedom/old/widgets/common/colors.dart';
import 'package:financial_freedom/old/widgets/common/mycolors.dart';
import 'package:financial_freedom/old/widgets/common/raisedButton.dart';
import 'package:financial_freedom/old/widgets/common/routes.dart';
import 'package:flutter/material.dart';

class ProfesionalLoan extends StatefulWidget {
  final Customer customerData;
  ProfesionalLoan({this.customerData});

  @override
  _ProfesionalLoanState createState() => _ProfesionalLoanState();
}

class _ProfesionalLoanState extends State<ProfesionalLoan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Builder(
          builder: (btncontext) => Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(20),
            child: ListView(
              children: [
                Text(
                  'You will need these Documents to Add a Customer',
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .merge(TextStyle(fontSize: 25)),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: Text(
                    'Ask your customer to be ready to provide below documents.\nYou will first need KYC to successfully complete customer registration journey.',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        .merge(TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: "AADHAAR Card (front & back)\n",
                      style: TextStyle(
                        color: MyColors.yellowColor(),
                        fontWeight: FontWeight.w700,
                      )),
                  TextSpan(
                    text: "ideally e-verified copy or scan of original",
                  ),
                ])),
                SizedBox(
                  height: 20.0,
                ),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: "PAN Card\n",
                      style: TextStyle(
                        color: MyColors.yellowColor(),
                        fontWeight: FontWeight.w700,
                      )),
                  TextSpan(
                    text: "scan original document, not a photocopy",
                  ),
                ])),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: Text(
                    'In addition to KYC, below documents are mandatory to process Loan application.',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        .merge(TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: "Address Proof :\n",
                      style: TextStyle(
                        color: MyColors.yellowColor(),
                        fontWeight: FontWeight.w700,
                      )),
                  TextSpan(
                    text: "Rent Agreement or Utility bill",
                  ),
                ])),
                SizedBox(
                  height: 20.0,
                ),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: "Income Proof :\n",
                      style: TextStyle(
                        color: MyColors.yellowColor(),
                        fontWeight: FontWeight.w700,
                      )),
                  TextSpan(
                    text: "Salary Slips for salaried/ ITR for self-employed",
                  ),
                ])),
                SizedBox(
                  height: 20.0,
                ),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: "Professional Proof :\n",
                      style: TextStyle(
                        color: MyColors.yellowColor(),
                        fontWeight: FontWeight.w700,
                      )),
                  TextSpan(
                    text:
                        "Highest Degree certificate of Doctor, or COP or ICAI registration certificate for CA",
                  ),
                ])),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Align(
                    child: SizedBox(
                      width: 150,
                      child: RaisedButton(
                        child: Text(
                          'Let\'s Start !',
                          style: Theme.of(context).textTheme.button,
                        ),
                        color: GetColor.sandybrown,
                        onPressed: () {
                          if (widget.customerData.loanType == "Professional") {
                            Navigator.pushNamed(
                                context, Routes.selectProfession,
                                arguments: widget.customerData);
                          } else {
                            Navigator.pushNamed(
                                context, Routes.basicDetailsCust,
                                arguments: widget.customerData);
                          }
                        },
                      ),
                    ),
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
