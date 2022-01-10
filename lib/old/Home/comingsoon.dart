import 'package:flutter/material.dart';

class ComingSoon extends StatefulWidget {
  final String title;
  ComingSoon({this.title});
  @override
  _ComingSoonState createState() => _ComingSoonState();
}

class _ComingSoonState extends State<ComingSoon> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
          children: [
            Card(
              child: Container(
                padding: new EdgeInsets.all(32.0),
                child: Column(
                  children: [
                    Icon(
                      Icons.error_outline_outlined,
                      color: Colors.red[900],
                      size: 30,
                    ),
                    Text(
                      'Oops! You are on an under construction page.',
                      style: new TextStyle(fontSize: 18),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
