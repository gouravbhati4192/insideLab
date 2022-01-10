import 'package:financial_freedom/old/widgets/common/mycolors.dart';
import 'package:flutter/material.dart';

class DualRadioButtonCard extends StatefulWidget {
  final int selectedValue;
  final String option1;
  final String option2;
  final Function onChanged;

  DualRadioButtonCard(
      {Key key, this.option1, this.option2, this.onChanged, this.selectedValue})
      : super(key: key);

  @override
  DualRadioOptionCardState createState() => DualRadioOptionCardState();
}

class DualRadioOptionCardState extends State<DualRadioButtonCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.indigo.shade50,
      elevation: 3.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Row(
        children: <Widget>[
          Column(
            children: [
              Radio(
                value: 0,
                activeColor: Theme.of(context).primaryColor,
                groupValue: widget.selectedValue,
                onChanged: widget.onChanged,
              ),
              Text(widget.option1),
            ],
          ),
          Column(
            children: [
              Radio(
                value: 1,
                activeColor: Theme.of(context).primaryColor,
                groupValue: widget.selectedValue,
                onChanged: widget.onChanged,
              ),
              Text(widget.option2),
            ],
          ),
        ],
      ),
    );
  }
}
