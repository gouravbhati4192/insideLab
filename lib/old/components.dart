import 'package:financial_freedom/old/Home/home.dart';
import 'package:financial_freedom/old/widgets/common/mycolors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomComponents {
  static showBackStopDialog(context) => showDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
            content: Text(
              "You are ending the journey to register the customer. you will loose all the data.",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      CupertinoPageRoute(builder: (context) => Home()),
                      (route) => false);
                },
                child: Text(
                  "Exit",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    color: MyColors.backgroundColor(),
                  ),
                ),
              ),
            ],
          ));

  static showBackStopDialogUser(context) => showDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
            content: Text(
              "You are ending the journey to register. you will loose all the data.",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Text(
                  "Exit",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    color: MyColors.backgroundColor(),
                  ),
                ),
              ),
            ],
          ));

  static String statusMapping(status) {
    if (status == "New - Select Loan Product") {
      return "Select Loan Product";
    } else if (status == "New - Upload Documents") {
      return "Upload Documents";
    } else if (status == "New - Submit Application") {
      return "Submit Application";
    } else if (status == "Check Eligibility") {
      return "Verifying Eligibility";
    } else {
      return status;
    }
  }
}
