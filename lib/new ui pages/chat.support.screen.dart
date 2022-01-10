import 'package:financial_freedom/old/widgets/common/mycolors.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ChatSupportScreen extends StatefulWidget {
  const ChatSupportScreen({Key key}) : super(key: key);

  @override
  _ChatSupportScreenState createState() => _ChatSupportScreenState();
}

class _ChatSupportScreenState extends State<ChatSupportScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      Hero(
                          tag: 'support',
                          child: SizedBox(
                              width: 60,
                              child: Icon(
                                Icons.call,
                                size: 45,
                              ))),
                      Text(
                        'Support',
                        style: TextStyle(
                          color: MyColors.backgroundColor(),
                        ),
                      )
                    ],
                  ),
                ),
                Spacer(),
                Text(
                  'Chat Support',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: MyColors.backgroundColor(),
                  ),
                ),
                Spacer(),
                SizedBox(
                  width: 60,
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.cancel,
                        size: 40,
                        color: MyColors.backgroundColor(),
                      )),
                )
              ],
            )
          ],
        ),
        persistentFooterButtons: [
          SizedBox(
            height: 60,
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  new BoxShadow(
                    color: HexColor('#787878').withOpacity(0.40),
                    blurRadius: 4.0,
                    spreadRadius: 2.0,
                    offset: Offset(3.5, 3.5),
                  ),
                  new BoxShadow(
                    color: HexColor('#787878').withOpacity(0.40),
                    blurRadius: 4.0,
                    spreadRadius: 2.0,
                    offset: Offset(-1, -1),
                  ),
                ],
                color: MyColors.yellowColor(),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Type here to Chat...',
                  hintStyle: TextStyle(color: MyColors.backgroundColor()),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 0,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 0,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 0,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
