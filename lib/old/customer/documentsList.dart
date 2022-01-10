import 'dart:convert';
import 'dart:developer';

import 'package:financial_freedom/old/Model/DocumentsScreenArguments.dart';
import 'package:financial_freedom/old/widgets/common/ApiConstants.dart';
import 'package:financial_freedom/old/widgets/common/CallApi.dart';
import 'package:financial_freedom/old/widgets/common/ShowSnackBar.dart';
import 'package:financial_freedom/old/widgets/common/StringConstants.dart';
import 'package:flutter/material.dart';

class DocumentsList extends StatefulWidget {
  final DocumentsScreenArguments screenArgs;
  DocumentsList({this.screenArgs});
  @override
  _DocumentsListState createState() => _DocumentsListState();
}

class _DocumentsListState extends State<DocumentsList> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  var documentMap = new List<dynamic>();
  CallApi callApi = new CallApi();
  String caseID = '';

  Widget documentsButton(String buttonText, IconData iconData) {
    return Container(
      width: MediaQuery.of(context).size.width - 10,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        onPressed: () {
          Navigator.pushNamed(context, '/documentDetails',
                  arguments: DocumentsScreenArguments(
                      caseID,
                      widget.screenArgs.customerDetails,
                      buttonText,
                      documentMap))
              .then((data) {
            callApi
                .callGetApi(ApiConstants.CASE_DETAILS + caseID, true)
                .then((value) {
              if (value != null) {
                setState(() {
                  var customerDetailsJson = json.decode(value);
                  documentMap =
                      customerDetailsJson['data']['document_list'] == null
                          ? ''
                          : customerDetailsJson['data']['document_list'];
                });
              }
            });
          });
        },
        textColor: Colors.white,
        color: Theme.of(context).primaryColor,
        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                color: Theme.of(context).primaryColor,
                padding: EdgeInsets.fromLTRB(10, 4, 4, 4),
                child: Text(
                  buttonText,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Icon(
                  iconData,
                  color: Colors.white,
                  size: 30,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  submitApplication(BuildContext context) {
    if (documentMap != null && documentMap.length > 0) {
      callApi
          .callPutApi(ApiConstants.CASE_DETAILS + 'submit/' + caseID, new Map())
          .then((value) {
        print('value $value');
        if (value != null) {
          // scaffoldKey.currentState.showSnackBar(
          //     ShowSnackBar("Case submitted successfully").showSuccess());
          var decodeJson = json.decode(value);
          int error = decodeJson['error'];
          if (error == 0) {
            print('Documents submitted successfully');
            scaffoldKey.currentState.showSnackBar(
                ShowSnackBar("Documents submitted successfully.")
                    .showSuccess());
            Future.delayed(Duration(seconds: 2), () {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/home', (Route route) => false);
            });
          } else {
            scaffoldKey.currentState.showSnackBar(
                ShowSnackBar('An unexpected error occured.').showError());
          }
        } else {
          print('Error submitting application');
          scaffoldKey.currentState.showSnackBar(ShowSnackBar(
                  "Error submitting application. Please try again later.")
              .showError());
        }
      });
    } else {
      print('Upload atleast one document');
      scaffoldKey.currentState.showSnackBar(
          ShowSnackBar("Upload atleast one document").showError());
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.screenArgs != null) {
      caseID = widget.screenArgs.caseID;
      documentMap = widget.screenArgs.documentsList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
          StringConstants.appTitle,
        ),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 80.0,
                child: Card(
                  child: Text(
                    'Notifications:',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              DefaultTabController(
                length: 2,
                initialIndex: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      child: TabBar(
                        labelColor: Theme.of(context).primaryColor,
                        labelStyle: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        unselectedLabelColor: Colors.black,
                        tabs: [
                          Tab(
                            text: 'Required Documents',
                          ),
                          Tab(
                            text: 'Additional Documents',
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 480,
                      child: TabBarView(
                        children: [
                          ListView(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: Text(
                                    'Upload the clients documents here. Please read the Do\'s and Dont\'s before uploading',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold)),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              widget.screenArgs.customerDetails["load_type"] ==
                                      "Professional"
                                  ? Column(
                                      children: [
                                        documentsButton('Present Address Proof',
                                            Icons.file_upload),
                                        documentsButton(
                                            'Permanent Address Proof',
                                            Icons.file_upload),
                                        documentsButton(
                                            'Salary Slips', Icons.file_upload),
                                        documentsButton('Bank Statements',
                                            Icons.file_upload),
                                        documentsButton(
                                            'Financial (Income) Statement',
                                            Icons.file_upload),
                                        documentsButton(
                                            'Work From Home document',
                                            Icons.file_upload),
                                        documentsButton(
                                            'Qualification (Highest Degree) Certificate',
                                            Icons.file_upload),
                                      ],
                                    )
                                  : SizedBox.shrink(),
                              SizedBox(
                                height: 20,
                              ),
                              ElevatedButton(
                                child: Text('Submit'),
                                onPressed: () => submitApplication(context),

                                // (documentMap != null &&
                                //         documentMap.length > 0)
                                //     ? submitApplication(context)
                                //     : null,
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Text('Coming Soon',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
