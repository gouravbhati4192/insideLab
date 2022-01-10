import 'package:financial_freedom/old/widgets/common/routes.dart';
import 'package:flutter/material.dart';

class LoanSelectOptionBottomSheet extends StatefulWidget {
  const LoanSelectOptionBottomSheet({key}) : super(key: key);

  @override
  _LoanSelectOptionBottomSheetState createState() => _LoanSelectOptionBottomSheetState();
}

class _LoanSelectOptionBottomSheetState extends State<LoanSelectOptionBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return showBottomSheetEducation();
  }

  showBottomSheetEducation() {
    showModalBottomSheet<dynamic>(
        isScrollControlled: true,
        context: context,
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        builder: (BuildContext bc) {
          return Wrap(
            children: [
              Center(
                child: Column(
                  children: [
                    Container(
                        margin: EdgeInsets.only(top: 15.0),
                        child: Text("Selecting Type of Loan",style: TextStyle(fontSize: 21.0,color: Colors.black),)),
                    Container(
                        margin: EdgeInsets.only(top: 10.0),
                        child: Text("Currently we have three type of loan in our marketplace- \n Personal Proffesional  and Business Loan.",style: TextStyle(fontSize: 16.0,color: Colors.black),)),
                    Container(
                      margin: EdgeInsets.only(top: 25.0),
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => jobPreference()),
                          // );

                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(
                              50), // fromHeight use double.infinity as width and 40 is the height
                        ),
                        child: const Text('Find out the loan for my customer'),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, Routes.newcustomer);

                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(
                              50), // fromHeight use double.infinity as width and 40 is the height
                        ),
                        child: const Text('I know want my customer needs'),
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        });
  }
}
