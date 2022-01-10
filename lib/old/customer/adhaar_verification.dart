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
import 'package:financial_freedom/old/widgets/common/mycolors.dart';
import 'package:financial_freedom/old/widgets/common/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:path/path.dart';

UploadDocument uploadDocument = new UploadDocument();

class AdhaarVerifactionDoc extends StatefulWidget {
  final Customer customerData;
  AdhaarVerifactionDoc({this.customerData});
  @override
  _AdhaarVerifactionDocState createState() => _AdhaarVerifactionDocState();
}

class _AdhaarVerifactionDocState extends State<AdhaarVerifactionDoc> {
  File _adhharDocImg1, _adhharDocImg2;
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
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    'AADHAAR Verification',
                    style: Theme.of(context).textTheme.headline6.merge(
                          TextStyle(fontSize: 25),
                        ),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
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
                                  'e-verified copy or mulitiple soft copies\n(Front & Back) in any format here. You can review your \nuploads below. ',
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
                                ':Make sure to upload colour scanned\ncopy (Front & Back). Do not upload a photocopy.',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .merge(TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ]),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    // color: GetColor.lightgray,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () async {
                              File _img = File((await FilePicker.platform.pickFiles(type: FileType.any)).files[0].path);
                              setState(() {
                                _adhharDocImg1 = _img;
                              });
                              var res =
                                  await uploadDocument.uploadDocumentWithData(
                                      _adhharDocImg1,
                                      widget.customerData.caseID.toString(),
                                      "Aadhar Card");
                              print('res img $res');
                              Map data = json.decode(res);
                              widget.customerData.aadhaarFront =
                                  data["data"]["public_path"];
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
                                    child: Center(
                                      child: _adhharDocImg1 != null
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Image.asset(
                                                  'assets/file.png'),
                                            )
                                          : Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 15, left: 15),
                                              child: Text(
                                                'Upload here\nFRONT',
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2
                                                    .merge(TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: GetColor
                                                            .sandybrown)),
                                              ),
                                            ),
                                    ),
                                  ),
                                  _adhharDocImg1 != null
                                      ? Align(
                                          alignment: Alignment.topRight,
                                          child: IconButton(
                                              visualDensity:
                                                  VisualDensity.compact,
                                              onPressed: () {
                                                setState(() {
                                                  _adhharDocImg1 = null;
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
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () async {
                              File _img = File((await FilePicker.platform.pickFiles(type: FileType.any)).files[0].path);
                              setState(() {
                                _adhharDocImg2 = _img;
                              });
                              var res =
                                  await uploadDocument.uploadDocumentWithData(
                                      _adhharDocImg2,
                                      widget.customerData.caseID.toString(),
                                      "Aadhar Card");
                              print('res img $res');
                              Map data = json.decode(res);
                              widget.customerData.aadhaarBack =
                                  data["data"]["public_path"];
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
                                    child: Center(
                                      child: _adhharDocImg2 != null
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Image.asset(
                                                  'assets/file.png'),
                                            )
                                          : Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 15, left: 15),
                                              child: Text(
                                                'Upload here\nBACK',
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2
                                                    .merge(TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: GetColor
                                                            .sandybrown)),
                                              ),
                                            ),
                                    ),
                                  ),
                                  _adhharDocImg2 != null
                                      ? Align(
                                          alignment: Alignment.topRight,
                                          child: IconButton(
                                              visualDensity:
                                                  VisualDensity.compact,
                                              onPressed: () {
                                                setState(() {
                                                  _adhharDocImg2 = null;
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
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  ListView(
                    shrinkWrap: true,
                    children: [
                      _adhharDocImg1 == null
                          ? SizedBox.shrink()
                          : Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                basename(_adhharDocImg1.path),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .merge(
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                            ),
                      _adhharDocImg2 == null
                          ? SizedBox.shrink()
                          : Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                basename(_adhharDocImg2.path),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .merge(
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                            )
                    ],
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
                  color: Colors.grey,
                  onPressed: () {
                    // CustomComponents.showBackStopDialog(context);
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Back',
                    style: Theme.of(context).textTheme.button.copyWith(
                          color: MyColors.yellowColor(),
                        ),
                  ),
                ),
              ),
              SizedBox(
                width: 100,
                child: RaisedButton(
                  onPressed: () {
                    if (_adhharDocImg1 != null || _adhharDocImg2 != null) {
                      Navigator.pushNamed(context, Routes.uploadPan,
                          arguments: widget.customerData);
                    } else {
                      FinancialFreedom.sMKey.currentState.showSnackBar(
                        SnackBar(
                          content: Text(
                            "Please Upload Aadhaar",
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

class AdhaarVerificationCamera extends StatefulWidget {
  final Customer customerData;
  AdhaarVerificationCamera({this.customerData});
  @override
  _AdhaarVerificationCameraState createState() =>
      _AdhaarVerificationCameraState();
}

class _AdhaarVerificationCameraState extends State<AdhaarVerificationCamera> {
  File _adhharCameraImg;
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
                    'AADHAAR Verification',
                    style: Theme.of(context).textTheme.headline6.merge(
                          TextStyle(fontSize: 25),
                        ),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: RichText(
                      text: TextSpan(
                          text: 'Scan the ',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              .merge(TextStyle(
                                fontWeight: FontWeight.bold,
                              )),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Front',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .merge(TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: GetColor.sandybrown)),
                            ),
                          ]),
                    ),
                  ),
                  Text(
                      'Capture Front of customer\'s Aadhaar Card in below box'),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 40),
                    child: _adhharCameraImg == null
                        ? DottedBorder(
                            color: Colors.white,
                            strokeWidth: 2,
                            borderType: BorderType.RRect,
                            radius: Radius.circular(10.0),
                            dashPattern: [10, 10],
                            child: Container(
                              decoration: BoxDecoration(
                                color: GetColor.lightgray,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              height: 200,
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.all(40.0),
                                child: Image.asset('assets/shutter.png'),
                              ),
                            ),
                          )
                        : DottedBorder(
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
                                  child: Image.file(
                                    _adhharCameraImg,
                                    height: 200,
                                  ),
                                ),
                                _adhharCameraImg != null
                                    ? Align(
                                        alignment: Alignment.topRight,
                                        child: IconButton(
                                            visualDensity:
                                                VisualDensity.compact,
                                            onPressed: () {
                                              setState(() {
                                                _adhharCameraImg = null;
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
                  SizedBox(
                    width: 200,
                    child: RaisedButton(
                      onPressed: () async {
                        File _img =
                            await CameraFile.getFile(StringConstants.camera);
                        setState(() {
                          _adhharCameraImg = _img;
                        });
                        var res = await uploadDocument.uploadDocumentWithData(
                            _adhharCameraImg,
                            widget.customerData.caseID.toString(),
                            "Aadhar Card");
                        print('res img $res');
                        Map data = json.decode(res);
                        widget.customerData.aadhaarFront =
                            data["data"]["public_path"];
                      },
                      color: GetColor.lightgray,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.camera,
                              color: GetColor.sandybrown,
                            ),
                            Text(
                              'Take Photo',
                              style: Theme.of(context).textTheme.button.merge(
                                  TextStyle(
                                      fontSize: 15,
                                      color: GetColor.sandybrown)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: SizedBox(
                      width: 200,
                      child: RaisedButton(
                        onPressed: () {
                          if (_adhharCameraImg != null) {
                            Navigator.pushNamed(
                                context, Routes.takePhotoAadhar2,
                                arguments: widget.customerData);
                          } else {
                            FinancialFreedom.sMKey.currentState.showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Please Upload Aadhaar Front",
                                ),
                              ),
                            );
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'Continue',
                            style: Theme.of(context)
                                .textTheme
                                .button
                                .merge(TextStyle(fontSize: 15)),
                          ),
                        ),
                      ),
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              RaisedButton(
                color: Colors.grey,
                onPressed: () {
                  // CustomComponents.showBackStopDialog(context);
                  Navigator.pop(context);
                },
                child: Text(
                  'Back',
                  style: Theme.of(context).textTheme.button.copyWith(
                        color: MyColors.yellowColor(),
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
