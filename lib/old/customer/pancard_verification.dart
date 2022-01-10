import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:financial_freedom/main.dart';
import 'package:financial_freedom/old/Model/customerData.dart';
import 'package:financial_freedom/old/components.dart';
import 'package:financial_freedom/old/widgets/common/StringConstants.dart';
import 'package:financial_freedom/old/widgets/common/UploadDocument.dart';
import 'package:financial_freedom/old/widgets/common/camera_gallery_file.dart';
import 'package:financial_freedom/old/widgets/common/colors.dart';
import 'package:financial_freedom/old/widgets/common/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:path/path.dart';

UploadDocument uploadDocument = new UploadDocument();

class PanVerifactionDoc extends StatefulWidget {
  final Customer customerData;
  PanVerifactionDoc({this.customerData});

  @override
  _PanVerifactionDocState createState() => _PanVerifactionDocState();
}

class _PanVerifactionDocState extends State<PanVerifactionDoc> {
  File _panImage;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // CustomComponents.showBackStopDialog(context);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.yellow,
            ),
            onPressed: () {
              CustomComponents.showBackStopDialog(context);
            },
          ),
          // title: Text(
          //   'Personal Information',
          //   style: Theme.of(context).textTheme.headline6.merge(
          //         TextStyle(fontSize: 25),
          //       ),
          //   textAlign: TextAlign.center,
          // ),
          // centerTitle: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Text(
                    'PAN Card Verification',
                    style: Theme.of(context).textTheme.headline6.merge(
                          TextStyle(fontSize: 25),
                        ),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 60),
                    child: RichText(
                      text: TextSpan(
                          text: 'Upload ',
                          style: Theme.of(context).textTheme.bodyText2.merge(
                              TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: GetColor.sandybrown)),
                          children: <TextSpan>[
                            TextSpan(
                              text:
                                  'e-verified copy or mulitiple soft copy in any format here. You can review your uploads below. ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .merge(
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          ]),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                        text: 'Document Quality ',
                        style: Theme.of(context).textTheme.bodyText2.merge(
                            TextStyle(
                                fontWeight: FontWeight.bold,
                                color: GetColor.sandybrown)),
                        children: <TextSpan>[
                          TextSpan(
                            text:
                                ':Make sure to upload colour scanned\ncopy. Do not upload a photocopy.',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .merge(TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ]),
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  ///TODO: make this picture area with dash border and make dynamic
                  InkWell(
                    onTap: () async {
                      File _img = File((await FilePicker.platform.pickFiles(type: FileType.any)).files[0].path);
                      setState(() {
                        _panImage = _img;
                      });
                      var res = await uploadDocument.uploadDocumentWithData(
                          _panImage,
                          widget.customerData.caseID.toString(),
                          "Pan Card");
                      print('res img $res');
                      Map data = json.decode(res);
                      widget.customerData.pan = data["data"]["public_path"];
                    },
                    child: DottedBorder(
                      color: Colors.white,
                      strokeWidth: 2,
                      borderType: BorderType.RRect,
                      radius: Radius.circular(10.0),
                      dashPattern: [10, 10],
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: GetColor.lightgray,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            child: _panImage == null
                                ? Center(
                                    child: Text(
                                      'Upload here',
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          .merge(TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: GetColor.sandybrown)),
                                    ),
                                  )
                                : Image.asset('assets/file.png'),
                          ),
                          _panImage != null
                              ? Align(
                                  alignment: Alignment.topRight,
                                  child: IconButton(
                                      visualDensity: VisualDensity.compact,
                                      onPressed: () {
                                        setState(() {
                                          _panImage = null;
                                        });
                                      },
                                      icon: Icon(
                                        FlutterIcons.close_circle_mco,
                                        color: Colors.white,
                                      )),
                                )
                              : SizedBox.shrink(),
                        ],
                      ),
                    ),
                  ),
                  _panImage == null
                      ? SizedBox()
                      : Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            basename(_panImage.path),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .merge(TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 100,
                child: RaisedButton(
                  onPressed: () {
                    // CustomComponents.showBackStopDialog(context);
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Back',
                    style: Theme.of(context).textTheme.button,
                  ),
                ),
              ),
              SizedBox(
                width: 100,
                child: RaisedButton(
                  onPressed: () {
                    if (_panImage != null) {
                      Navigator.pushNamed(context, Routes.employmentDetails,
                          arguments: widget.customerData);
                    } else {
                      FinancialFreedom.sMKey.currentState.showSnackBar(
                        SnackBar(
                          content: Text(
                            "Please Upload PAN",
                          ),
                        ),
                      );
                    }
                  },
                  child: Text(
                    'Next',
                    style: Theme.of(context).textTheme.button,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
