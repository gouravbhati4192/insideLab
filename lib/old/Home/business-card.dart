import 'package:dio/dio.dart';
import 'package:financial_freedom/old/widgets/common/SharedPref.dart';
import 'package:financial_freedom/old/widgets/common/mycolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class AgentCardScreen extends StatefulWidget {
  final String id;
  AgentCardScreen({Key key, this.id}) : super(key: key);

  @override
  _AgentCardScreenState createState() => _AgentCardScreenState();
}

class _AgentCardScreenState extends State<AgentCardScreen> {
  bool loading = true;
  bool noData = false;
  bool showButton = false;
  var screenSize;
  Map data;

  Future<bool> getAgentDetials({String id}) async {
    SharedPref _pref = new SharedPref();
    try {
      Response res = await Dio().get(
        'https://crmtest.insiderlab.in/api/agent-details-new',
        queryParameters: {"id": id},
        options: Options(
          headers: {
            "verify-myself": "banana",
            "Authorization": "Bearer ${await _pref.getToken()}"
          },
        ),
      );
      setState(() {
        loading = false;
      });
      if (res.statusCode == 200) {
        if (res.data['error'] == 0) {
          if (res.data['data'] != null) {
            data = res.data['data'];
            return true;
          } else {
            return false;
          }
        }
      } else {
        return false;
      }
    } catch (e) {
      print('dio exception');
      print(e);
      return false;
    }
  }

  bool firstTime = true;

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    if (firstTime) {
      firstTime = false;
      getAgentDetials(id: widget.id);
    }
    return loading
        ? Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            backgroundColor: MyColors.backgroundColor(),
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: noData
                    ? Container(
                        child: Text(
                          'No Record Found',
                          style: GoogleFonts.poppins(
                            color: MyColors.yellowColor(),
                            fontSize: 35,
                          ),
                        ),
                      )
                    : Container(
                        // color: MyColors.yellowColor(),
                        color: Colors.white,
                        width: 400,
                        height: MediaQuery.of(context).size.height,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 30,
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 42.0),
                                    child: Text(
                                      "powered by",
                                      style: GoogleFonts.poppins(
                                        color: MyColors.textBoxColor(),
                                        fontStyle: FontStyle.italic,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 100,
                                width: 400,
                                child: Image(
                                  image: AssetImage('assets/logo.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: [
                              //     Flexible(
                              //       flex: 0,
                              //       child: Padding(
                              //         padding: const EdgeInsets.only(
                              //             top: 8.0, right: 2.0),
                              //         child: Container(
                              //           decoration: BoxDecoration(
                              //             color: Colors.black,
                              //             borderRadius:
                              //                 BorderRadius.circular(3.0),
                              //           ),
                              //           child: Padding(
                              //             padding: const EdgeInsets.symmetric(
                              //                 vertical: 2.0, horizontal: 1.0),
                              //             child: Text(
                              //               'In',
                              //               textAlign: TextAlign.center,
                              //               style: GoogleFonts.poppins(
                              //                 color: MyColors.yellowColor(),
                              //                 fontWeight: FontWeight.bold,
                              //                 fontSize: 22,
                              //               ),
                              //             ),
                              //           ),
                              //         ),
                              //       ),
                              //     ),
                              //     Flexible(
                              //       child: Padding(
                              //         padding: const EdgeInsets.only(top: 10.0),
                              //         child: Text(
                              //           "side₹Lab Fintech Pvt Ltd.",
                              //           textAlign: TextAlign.center,
                              //           style: GoogleFonts.poppins(
                              //             color: Colors.black,
                              //             fontWeight: FontWeight.bold,
                              //             fontSize: 22,
                              //           ),
                              //         ),
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: InkWell(
                                        onTap: () async {
                                          if (await canLaunch(
                                              'https://www.insiderlab.in')) {
                                            launch('https://www.insiderlab.in');
                                          }
                                        },
                                        child: Text(
                                          "www.insiderlab.in",
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.poppins(
                                            decoration:
                                                TextDecoration.underline,
                                            color: MyColors.textBoxColor(),
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    height: 40,
                                    child: Image(
                                      image: AssetImage('assets/mail.png'),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: InkWell(
                                        onTap: () async {
                                          launch('mailto:admin@insiderlab.in');
                                        },
                                        child: Text(
                                          "admin@insiderlab.in",
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.poppins(
                                            decoration:
                                                TextDecoration.underline,
                                            color: MyColors.textBoxColor(),
                                            fontSize: 12,
                                          ),
                                        ),
                                      ), 
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 70,
                              ),
                              SizedBox(
                                height: 200,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Image(
                                        image: AssetImage(
                                          'assets/agent.png',
                                        ),
                                        width: 170,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0, top: 10.0),
                                            child: Text(
                                              data["name"],
                                              textAlign: TextAlign.start,
                                              style: GoogleFonts.poppins(
                                                color:
                                                    MyColors.backgroundColor(),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 22,
                                              ),
                                            ),
                                          ),
                                          // SizedBox(
                                          //   width: 10,
                                          // ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 8.0,
                                              top: 10.0,
                                              right: 8.0,
                                            ),
                                            child: Text(
                                              'Financial Therapist',
                                              textAlign: TextAlign.start,
                                              style: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                          // SizedBox(
                                          //   width: 10,
                                          // ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0, top: 10.0),
                                            child: Text(
                                              "User ID : ${widget.id.toString().padLeft(3, "0")}",
                                              textAlign: TextAlign.start,
                                              style: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 60,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: screenSize.width < 420
                                    ? mobileContactInfo()
                                    : webContactInfo(),
                              )
                            ],
                          ),
                        ),
                      ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              heroTag: "share-agent",
              onPressed: () {
                var message =
                    'Hey! Check Out My Business Card\n${Uri.encodeComponent("https://insiderlab.wostore.in/#/agent-card/")}' +
                        widget.id.toString();
                var url = "whatsapp://send?text=" + message;

                launch(url);
              },
              hoverColor: Theme.of(context).primaryColor,
              child: Icon(Icons.share),
              foregroundColor: MyColors.darkBlue,
              backgroundColor: MyColors.yellowColor(),
            ),
          );
  }

  MouseRegion webContactInfo() {
    return MouseRegion(
      onEnter: (a) {
        setState(() => showButton = true);
      },
      onExit: (a) {
        setState(() => showButton = false);
      },
      child: Container(
        decoration: BoxDecoration(
          color: MyColors.backgroundColor(),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.phone_android_outlined,
                  color: MyColors.yellowColor(),
                  size: 25,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  data["mobile"],
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
                showButton
                    ? Row(
                        children: [
                          IconButton(
                            color: MyColors.yellowColor(),
                            onPressed: () async {
                              launch('tel:${data["mobile"]}');
                            },
                            icon: Icon(
                              Icons.call,
                            ),
                          ),
                          IconButton(
                            color: MyColors.yellowColor(),
                            onPressed: () async {
                              launch(
                                  'https://api.whatsapp.com/send?phone=+91${data["mobile"]}');
                            },
                            icon: Icon(
                              FlutterIcons.whatsapp_mco,
                            ),
                          )
                        ],
                      )
                    : SizedBox.shrink()
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.email,
                  color: MyColors.yellowColor(),
                  size: 25,
                ),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: InkWell(
                    onTap: () async {
                      launch('mailto:${data["email"]}');
                    },
                    child: Text(
                      data["email"],
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }

  Container mobileContactInfo() {
    return Container(
      decoration: BoxDecoration(
        color: MyColors.backgroundColor(),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.phone_android_outlined,
                color: MyColors.yellowColor(),
                size: 25,
              ),
              SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () {
                  setState(() => showButton = !showButton);
                },
                child: Text(
                  data["mobile"],
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
              ),
              showButton
                  ? Flexible(
                      child: IconButton(
                        color: MyColors.yellowColor(),
                        onPressed: () async {
                          launch('tel:${data["mobile"]}');
                        },
                        icon: Icon(
                          Icons.call,
                        ),
                      ),
                    )
                  : SizedBox.shrink(),
              showButton
                  ? Flexible(
                      child: IconButton(
                      color: MyColors.yellowColor(),
                      onPressed: () async {
                        launch(
                            'https://api.whatsapp.com/send?phone=+91${data["mobile"]}');
                      },
                      icon: Icon(
                        FlutterIcons.whatsapp_mco,
                      ),
                    ))
                  : SizedBox.shrink()
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.email,
                color: MyColors.yellowColor(),
                size: 25,
              ),
              SizedBox(
                width: 10,
              ),
              Flexible(
                child: InkWell(
                  onTap: () async {
                    launch('mailto:${data["email"]}');
                  },
                  child: Text(
                    data["email"],
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
