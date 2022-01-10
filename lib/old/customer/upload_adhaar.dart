import 'package:financial_freedom/old/Model/customerData.dart';
import 'package:financial_freedom/old/components.dart';
import 'package:financial_freedom/old/widgets/common/colors.dart';
import 'package:financial_freedom/old/widgets/common/mycolors.dart';
import 'package:financial_freedom/old/widgets/common/routes.dart';
import 'package:flutter/material.dart';

class UploadAdhaar extends StatefulWidget {
  final Customer customerData;
  UploadAdhaar({this.customerData});
  @override
  _UploadAdhaarState createState() => _UploadAdhaarState();
}

class _UploadAdhaarState extends State<UploadAdhaar> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: () async {
      // CustomComponents.showBackStopDialog(context);
      return true;
    },
      child: Scaffold( appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
                        icon: Icon(Icons.arrow_back,color: Colors.yellow,),
                        onPressed: (){
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
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Let us Know Your Customer',
                  style: Theme.of(context).textTheme.headline6.merge(
                        TextStyle(fontSize: 25),
                      ),
                  textAlign: TextAlign.center,
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 40),
                      child: RichText(
                        text: TextSpan(
                            text: 'Select option to upload',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .merge(TextStyle(fontWeight: FontWeight.bold)),
                            children: <TextSpan>[
                              TextSpan(
                                text: ' aadhaar'.toUpperCase(),
                                style:
                                    Theme.of(context).textTheme.bodyText2.merge(
                                          TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: GetColor.sandybrown),
                                        ),
                              )
                            ]),
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, Routes.adhaarVerificationByDoc,
                              arguments: widget.customerData);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Text(
                            'Upload Aadhaar',
                            style: Theme.of(context)
                                .textTheme
                                .button
                                .merge(TextStyle(fontSize: 18)),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: Text(
                        'or'.toUpperCase(),
                        style: Theme.of(context).textTheme.bodyText2.merge(
                              TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: GetColor.sandybrown),
                            ),
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, Routes.adhaarVerificationByCamera,
                              arguments: widget.customerData);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Text(
                            'Take Photo',
                            style: Theme.of(context)
                                .textTheme
                                .button
                                .merge(TextStyle(fontSize: 18)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomLeft,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
