import 'package:financial_freedom/old/widgets/common/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GetTextField extends StatefulWidget {
  final String hinttext;
  final bool isobscure;
  final TextEditingController controller;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onFieldSubmitted;
  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatters;

  final Function(String) onChanged;

  GetTextField(
      {this.hinttext,
      this.isobscure,
      this.controller,
      this.onFieldSubmitted,
      this.onSaved,
      this.keyboardType,
      this.validator,
      this.inputFormatters,
      this.onChanged});
  @override
  _GetTextFieldState createState() => _GetTextFieldState();
}

class _GetTextFieldState extends State<GetTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChanged,
      style: Theme.of(context).textTheme.bodyText2,
      controller: widget.controller,
      obscureText: widget.isobscure != null ? widget.isobscure : false,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.fromLTRB(10, 25, 25, 0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        hintText: widget.hinttext,
        hintStyle: Theme.of(context)
            .textTheme
            .bodyText2
            .merge(TextStyle(color: GetColor.hintColor)),
        fillColor: GetColor.lightgray,
        filled: true,
      ),
      onSaved: widget.onSaved,
      validator: widget.validator,
      onFieldSubmitted: widget.onFieldSubmitted,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatters,
    );
  }
}
