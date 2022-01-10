import 'package:financial_freedom/old/widgets/common/mycolors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TextLink extends StatelessWidget {
  final String textMsg;
  final Function onPressed;
  final String url;

  TextLink({Key key, this.textMsg, this.onPressed, this.url}) : super(key: key);

  launchURL() {
    launch(url);
  }

  @override
  Widget build(BuildContext context) {
    TextStyle linkStyle = TextStyle(
      fontSize: 18,
      color: Theme.of(context).primaryColor,
      decoration: TextDecoration.underline,
    );
    return Text.rich(
      TextSpan(
          text: textMsg,
          style: Theme.of(context).textTheme.bodyText2.merge(
                TextStyle(
                  decoration: TextDecoration.underline,
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                ),
              ),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              launchURL();
            }),
    );
  }
}
