import 'package:financial_freedom/old/Model/customerData.dart';
import 'package:financial_freedom/old/widgets/common/raisedButton.dart';
import 'package:financial_freedom/old/widgets/common/routes.dart';
import 'package:flutter/material.dart';

class SelectProfession extends StatefulWidget {
  final Customer customerData;
  SelectProfession({this.customerData});
  @override
  _SelectProfessionState createState() => _SelectProfessionState();
}

class _SelectProfessionState extends State<SelectProfession> {
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
                    'Select the Profession',
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .merge(TextStyle(fontSize: 25)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  child: ReusableButton(
                    btntext: 'Doctor',
                    onclick: () {
                      setState(() {
                        widget.customerData.professionName = 'doctor';
                      });
                      Navigator.pushNamed(context, Routes.doctorDegree,
                          arguments: widget.customerData);
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  child: ReusableButton(
                    btntext: 'CA/CS/Cost Accountant',
                    onclick: () {
                      setState(() {
                        widget.customerData.professionName = 'accountant';
                      });
                      Navigator.pushNamed(context, Routes.basicDetailsCust,
                          arguments: widget.customerData);
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  child: ReusableButton(
                    btntext: 'Any Other Profession',
                    onclick: () {
                      setState(() {
                        widget.customerData.professionName = 'other';
                      });
                      Navigator.pushNamed(context, Routes.basicDetailsCust,
                          arguments: widget.customerData);
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
