import 'package:financial_freedom/old/widgets/common/colors.dart';
import 'package:flutter/material.dart';

class ReusableButton extends StatefulWidget {
  final String btntext;
  final VoidCallback onclick;
  ReusableButton({this.btntext, this.onclick});

  @override
  _ReusableButtonState createState() => _ReusableButtonState();
}

class _ReusableButtonState extends State<ReusableButton> {
  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      height: 50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: RaisedButton(
        child: Center(
          child: Text(
            widget.btntext,
            style: Theme.of(context)
                .textTheme
                .headline6
                .merge(TextStyle(fontSize: 14)),
            textAlign: TextAlign.center,
          ),
        ),
        color: GetColor.lightgray,
        onPressed: () {
          return widget.onclick();
        },
      ),
    );
  }
}
