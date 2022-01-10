import 'package:financial_freedom/old/components.dart';
import 'package:financial_freedom/old/widgets/common/mycolors.dart';
import 'package:financial_freedom/old/widgets/common/textfield.dart';
import 'package:flutter/material.dart';

class MonthlyObligations extends StatefulWidget {
  @override
  _MonthlyObligationsState createState() => _MonthlyObligationsState();
}

class _MonthlyObligationsState extends State<MonthlyObligations> {
  TextEditingController _monthlyEmiAmount = new TextEditingController();
  TextEditingController _puporseLoan = new TextEditingController();
  TextEditingController _totalLoan =
      new TextEditingController(); //total loan in last 4 months
  TextEditingController _newLoan = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // CustomComponents.showBackStopDialog(context);
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.all(40),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text(
                    'Monthly Obligations',
                    style: Theme.of(context).textTheme.headline6.merge(
                          TextStyle(fontSize: 25),
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: GetTextField(
                    hinttext: 'Total Monthly EMIs Amount',
                    isobscure: false,
                    controller: _monthlyEmiAmount,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: GetTextField(
                    hinttext: 'Purpose of Loan ?',
                    isobscure: false,
                    controller: _puporseLoan,
                  ),
                ),
                GetTextField(
                  hinttext: 'Total Loan Inquires in last 4 months ?',
                  isobscure: false,
                  controller: _totalLoan,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: GetTextField(
                    hinttext: 'Any new Loan started in last 1 year ?',
                    isobscure: false,
                    controller: _newLoan,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: SizedBox(
                    width: 200,
                    child: RaisedButton(
                      onPressed: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Text(
                          'Submit Application',
                          style: Theme.of(context)
                              .textTheme
                              .button
                              .merge(TextStyle(fontSize: 15)),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              RaisedButton(
                color: Colors.grey,
                onPressed: () {
                  // CustomComponents.showBackStopDialog(context);
                    Navigator.pop(context);
                },
                child: Text(
                  'Back',
                  style: Theme.of(context).textTheme.button.copyWith(
                        color: MyColors.yellowColor(),
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
