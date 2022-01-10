import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
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

UploadDocument uploadDocument = new UploadDocument();

class TakePhotoAadhar2 extends StatefulWidget {
  final Customer customerData;
  TakePhotoAadhar2({this.customerData});
  @override
  _TakePhotoAadhar2State createState() => _TakePhotoAadhar2State();
}

class _TakePhotoAadhar2State extends State<TakePhotoAadhar2> {
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
                              text: 'Back',
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
                  Text('Capture Back of customer\'s Adhaar Card in below box'),
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
                        widget.customerData.aadhaarBack =
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
                            Navigator.pushNamed(context, Routes.uploadPan,
                                arguments: widget.customerData);
                          } else {
                            FinancialFreedom.sMKey.currentState.showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Please Upload Aadhaar Back",
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

class TakePhotoPanCard extends StatefulWidget {
  final Customer customerData;
  TakePhotoPanCard({this.customerData});
  @override
  _TakePhotoPanCardState createState() => _TakePhotoPanCardState();
}

class _TakePhotoPanCardState extends State<TakePhotoPanCard> {
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
              padding: EdgeInsets.all(20),
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
                    padding: const EdgeInsets.symmetric(vertical: 35),
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
                  Text('Take a photo of customer\'s PAN Card'),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 40),
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
                                ? Padding(
                                    padding: const EdgeInsets.all(40.0),
                                    child: Image.asset('assets/shutter.png'),
                                  )
                                : Image.file(_panImage),
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
                  SizedBox(
                    width: 200,
                    child: RaisedButton(
                      onPressed: () async {
                        File _img =
                            await CameraFile.getFile(StringConstants.camera);
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
                        // Navigator.pushNamed(context, Routes.uploadPan);
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
                          if (_panImage != null) {
                            Navigator.pushNamed(
                                context, Routes.employmentDetails,
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
                          // Navigator.pushNamed(context, Routes.);
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
