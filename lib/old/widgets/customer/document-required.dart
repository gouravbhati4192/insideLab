import 'dart:convert';
import 'dart:developer';

import 'package:financial_freedom/controller/customer.controller.dart';
import 'package:financial_freedom/old/Model/DocumentsScreenArguments.dart';
import 'package:financial_freedom/old/widgets/common/ApiConstants.dart';
import 'package:financial_freedom/old/widgets/common/CallApi.dart';
import 'package:financial_freedom/old/widgets/common/SharedPref.dart';
import 'package:financial_freedom/old/widgets/common/ShowSnackBar.dart';
import 'package:financial_freedom/old/widgets/common/mycolors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:cupertino_tabbar/cupertino_tabbar.dart' as CustomBar;
import 'package:provider/provider.dart';

Color backgroundColor() => HexColor("#20314E");
Color yellowColor() => HexColor("#F4DE4C");
Color textBoxColor() => HexColor("#949695");

class DocumentRequiredScreen extends StatefulWidget {
  final DocumentsScreenArguments screenArgs;

  DocumentRequiredScreen({this.screenArgs});

  @override
  _DocumentRequiredScreenState createState() => _DocumentRequiredScreenState();
}

class _DocumentRequiredScreenState extends State<DocumentRequiredScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  var documentMap = [];
  CallApi callApi = new CallApi();
  String caseID = '';
  int cupertinoTabBarValue = 0;
  int cupertinoTabBarValueGetter() => cupertinoTabBarValue;

  Widget documentsButton(String buttonText, IconData iconData,
      {int docNumber}) {
    // log(buttonText);
    // if (buttonText.toLowerCase() == "aadhar card" ||
    //     buttonText.toLowerCase() == "pan card") {
    //   return Container();
    // }
    print(documentMap);
    var selected = documentMap != null &&
        documentMap.indexWhere((e) => e['document_type'] == buttonText) != -1;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: PhysicalModel(
        color: selected ? Colors.blue : Colors.blue[200],
        shadowColor: Colors.black,
        elevation: selected ? 0.0 : 8.0,
        borderRadius: BorderRadius.circular(10.0),
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          onTap: () {
            Navigator.pushNamed(
              context,
              '/documentDetails',
              arguments: DocumentsScreenArguments(
                caseID,
                widget.screenArgs.customerDetails,
                buttonText,
                documentMap,
              ),
            ).then((data) {
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
          tileColor: selected ? Colors.blue : Colors.blue[200],
          title: Text(
            buttonText,
            style: TextStyle(
              color: backgroundColor(),
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: selected
              ? Container(
                  width: 70,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(
                      10.0,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Added',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                )
              : Icon(
                  Icons.upload_sharp,
                  color: backgroundColor(),
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
    // log(widget.screenArgs.documentsList.toString(), name: 'list');

    tabController = TabController(vsync: this, length: 2);
  }

  TabController tabController;
  CustomerController customerController;
  List<Widget> doc = [];
  bool firstTime = true;
  void getData() async {
    SharedPref _pref = new SharedPref();
    customerController.documentTypes.data.clear();
    await customerController.getDocumentTypeCaseList(
      caseId: widget.screenArgs.caseID,
      token: await _pref.getToken(),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    customerController = Provider.of<CustomerController>(context);
    if (firstTime) {
      firstTime = false;
      getData();
    }
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: backgroundColor()),
        leading: null,
        centerTitle: true,
        title: Text(
          'Document Management',
          style: TextStyle(
            fontSize: 16,
            color: backgroundColor(),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: CustomBar.CupertinoTabBar(
                Colors.grey[200],
                Colors.white,
                [
                  const Text(
                    "Documents Required",
                    style: const TextStyle(
                      color: MyColors.darkBlue,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Text(
                    "Additional Requirements",
                    style: const TextStyle(
                      color: MyColors.darkBlue,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
                cupertinoTabBarValueGetter,
                (int index) {
                  setState(() {
                    cupertinoTabBarValue = index;
                    tabController.animateTo(index);
                  });
                },
                useSeparators: true,
                allowExpand: true,
                useShadow: false,
              ),
              // child: TabBar(
              //   labelColor: backgroundColor(),
              //   indicatorPadding: EdgeInsets.symmetric(horizontal: 20.0),
              //   tabs: [
              //     Tab(
              //       text: "Documents Required",
              //     ),
              //     Tab(
              //       text: "Additional Requirements",
              //     ),
              //   ],
              // ),
            ),
          ),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Upload the client document here. Please read the Dos and Donts of managing the doucment here.',
                style: TextStyle(
                  color: backgroundColor(),
                ),
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                customerController.documentTypes.data == null
                    ? SizedBox.shrink()
                    : ListView.builder(
                        itemCount: customerController.documentTypes.data.length,
                        itemBuilder: (c, i) {
                          return documentsButton(
                            customerController
                                .documentTypes.data[i].documentType,
                            Icons.file_upload,
                            docNumber: i + 1,
                          );
                        },
                      ),
                Container()
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => submitApplication(context),
        label: Text('Submit'),
      ),
    );
  }

  // ListView buildDocumentRequired(BuildContext context) {
  //   // doc.clear();
  //   // for (int i = 0; i < customerController.documentTypes.data.length; i++) {
  //   //   doc.add(
  //   //     documentsButton(
  //   //       customerController.documentTypes.data[i].documentType,
  //   //       Icons.file_upload,
  //   //       docNumber: i + 1,
  //   //     ),
  //   //   );
  //   // }
  //   // setState(() {});
  //   return ListView(
  //     shrinkWrap: true,
  //     children: doc,
  //     // children: getDocList(),
  //   );
  // }

  // getDocList() async {
  //   List<Widget> doc = [];
  //   // if (widget.screenArgs.customerDetails["load_type"] == "Personal") {
  //   //   doc = [
  //   //     documentsButton('Permanent Address proof', Icons.file_upload,
  //   //         docNumber: 1),
  //   //     documentsButton('Present Address proof', Icons.file_upload,
  //   //         docNumber: 2),
  //   //     documentsButton('Salary Slips', Icons.file_upload, docNumber: 3),
  //   //     documentsButton('Salary Bank Statement', Icons.file_upload,
  //   //         docNumber: 4),
  //   //     documentsButton('Form 16', Icons.file_upload, docNumber: 5),
  //   //     documentsButton('Official ID card', Icons.file_upload, docNumber: 6),
  //   //   ];
  //   // }
  //   // if (widget.screenArgs.customerDetails["load_type"] == "Business") {
  //   //   doc = [
  //   //     documentsButton('Permanent Address proof', Icons.file_upload,
  //   //         docNumber: 1),
  //   //     documentsButton('Present Address proof', Icons.file_upload,
  //   //         docNumber: 2),
  //   //     documentsButton('Business Property Address', Icons.file_upload,
  //   //         docNumber: 3),
  //   //     documentsButton('Business Continuity Proof', Icons.file_upload,
  //   //         docNumber: 4),
  //   //     documentsButton('Income Proof', Icons.file_upload, docNumber: 5),
  //   //     documentsButton('Business Bank Statement', Icons.file_upload,
  //   //         docNumber: 6),
  //   //     documentsButton('GST Returns (optional)', Icons.file_upload,
  //   //         docNumber: 7),
  //   //   ];
  //   // }
  //   // if (widget.screenArgs.customerDetails["load_type"] == "Professional" &&
  //   //     widget.screenArgs.customerDetails["employment_type"] == "Salaried") {
  //   //   doc = [
  //   //     documentsButton('Permanent Address proof', Icons.file_upload,
  //   //         docNumber: 1),
  //   //     documentsButton('Present Address proof', Icons.file_upload,
  //   //         docNumber: 2),
  //   //     documentsButton('Highest Degree Qualification Proof', Icons.file_upload,
  //   //         docNumber: 3),
  //   //     documentsButton('Salary Slips', Icons.file_upload, docNumber: 4),
  //   //     documentsButton('Salary Bank Statement', Icons.file_upload,
  //   //         docNumber: 5),
  //   //     documentsButton('Form 16', Icons.file_upload, docNumber: 6),
  //   //     documentsButton('Official ID card', Icons.file_upload, docNumber: 7),
  //   //   ];
  //   // }
  //   // if (widget.screenArgs.customerDetails["load_type"] == "Professional" &&
  //   //     widget.screenArgs.customerDetails["employment_type"] ==
  //   //         "Self Employed") {
  //   //   doc = [
  //   //     documentsButton('Permanent Address proof', Icons.file_upload,
  //   //         docNumber: 1),
  //   //     documentsButton('Present Address proof', Icons.file_upload,
  //   //         docNumber: 2),
  //   //     documentsButton('Business Property Address', Icons.file_upload,
  //   //         docNumber: 3),
  //   //     documentsButton('Income Proof', Icons.file_upload, docNumber: 4),
  //   //     documentsButton('Business Bank Statement', Icons.file_upload,
  //   //         docNumber: 5),
  //   //     documentsButton('Highest Degree Qualification Proof', Icons.file_upload,
  //   //         docNumber: 6),
  //   //   ];
  //   // }
  //   // if (widget.screenArgs.customerDetails["load_type"] == "Professional" &&
  //   //     widget.screenArgs.customerDetails["employment_type"] ==
  //   //         "Salaried + Self-Employed") {
  //   //   doc = [
  //   //     documentsButton('Permanent Address proof ', Icons.file_upload,
  //   //         docNumber: 1),
  //   //     documentsButton('Present Address proof', Icons.file_upload,
  //   //         docNumber: 2),
  //   //     documentsButton('Business Property Address', Icons.file_upload,
  //   //         docNumber: 3),
  //   //     documentsButton('Income Proof', Icons.file_upload, docNumber: 4),
  //   //     documentsButton('Business Bank Statement', Icons.file_upload,
  //   //         docNumber: 5),
  //   //     documentsButton('Highest Degree Qualification Proof', Icons.file_upload,
  //   //         docNumber: 6),
  //   //     documentsButton('Salary Slips', Icons.file_upload, docNumber: 7),
  //   //     documentsButton('Form 16', Icons.file_upload, docNumber: 8),
  //   //     documentsButton('Official ID card', Icons.file_upload, docNumber: 9),
  //   //     documentsButton('Salary Bank Statement', Icons.file_upload,
  //   //         docNumber: 10),
  //   //   ];
  //   // }
  //   doc.add(
  //     SizedBox(
  //       height: 70.0,
  //     ),
  //   );
  //   return doc;
  // }
}
