
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ShowSnackBar {
  final  String textMsg;

  ShowSnackBar(this.textMsg);



  Widget showSuccess(){
    return SnackBar(
        backgroundColor: Colors.green,
        content: Text(
          textMsg,
          style: TextStyle(color:Colors.white),
        ),
        duration: Duration(seconds: 2),

    );
  }

  Widget showError(){
    return SnackBar(
      backgroundColor: Colors.red,
      content: Text(
        textMsg,
        style: TextStyle(color:Colors.white),
      ),
      duration: Duration(seconds: 2),

    );
  }

}


