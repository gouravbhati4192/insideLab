import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNavigationWidgets extends StatefulWidget {
  final void Function(BuildContext) onPressedNext;
  final void Function(BuildContext) onPressedCancel;
  final String nextButtonName;
  final String cancelButtonName;

  BottomNavigationWidgets(
      {Key key,
      this.onPressedNext,
      this.onPressedCancel,
      this.nextButtonName,
      this.cancelButtonName})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => BottomNavigationWidgetsState();
}

class BottomNavigationWidgetsState extends State<BottomNavigationWidgets> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: RaisedButton(
              shape: StadiumBorder(),
              textColor: Colors.white,
              color: Theme.of(context).primaryColor,
              child: Text(widget.cancelButtonName),
              onPressed: () {
                return widget.onPressedCancel(context);
              },
            ),
          ),
          SizedBox(width: 30),
          Expanded(
            child: Builder(
              builder: (btncontext) => RaisedButton(
                shape:
                    StadiumBorder() /*RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)))*/
                ,
                textColor: Colors.white,
                color: Theme.of(context).primaryColor,
                child: Text(widget.nextButtonName),
                onPressed: () {
                  return widget.onPressedNext(btncontext);
                },
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}
