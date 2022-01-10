import 'dart:convert';
import 'dart:developer';
import 'dart:ui';

import 'package:financial_freedom/old/Home/home.dart';
import 'package:financial_freedom/old/Model/customerData.dart';
import 'package:financial_freedom/old/Model/OTPScreenArgs.dart';
import 'package:financial_freedom/old/Model/ProductsArguments.dart';
import 'package:financial_freedom/old/customer/otpscreenproduct.dart';
import 'package:financial_freedom/old/widgets/common/ApiConstants.dart';
import 'package:financial_freedom/old/widgets/common/CallApi.dart';
import 'package:financial_freedom/old/widgets/common/mycolors.dart';
import 'package:financial_freedom/old/widgets/common/routes.dart';
import 'package:financial_freedom/old/widgets/customer/customer-profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:simple_html_css/simple_html_css.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';

class AnimatedProductList extends StatefulWidget {
  final String title;
  final ProductsArguments screenArgs;

  AnimatedProductList({Key key, this.screenArgs, this.title}) : super(key: key);

  @override
  _AnimatedProductListState createState() => _AnimatedProductListState();
}

class _AnimatedProductListState extends State<AnimatedProductList>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;

  int value;
  Future<String> products;
  CallApi _callApi = new CallApi();
  Map<String, dynamic> analyticsProducts;
  String loanName;
  var customerData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // log(widget.screenArgs.loanType);
    products = getProductAnalytics();
    _callApi
        .callGetApi(ApiConstants.CASE_DETAILS + widget.screenArgs.caseID, true)
        .then((value) => customerData = json.decode(value));
    // log(customerData[0]['load_type'].toString());
    // log(customerData[0]['first_name'].toString());
    animationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 350,
      ),
    );
  }

  Widget getHtmlPage(int pageIndex, int productIndex, Map data) {
    var html = getPageData(pageIndex, productIndex, data);
    return Builder(
      builder: (context) => HTML.toRichText(
        context,
        html,
        linksCallback: (link) async {
          await launch(link);
        },
        // defaultTextStyle: TextStyle(
        //   fontSize: 16,
        // ),
        overrideStyle: {
          'p': TextStyle(color: Colors.white),
          'ul': TextStyle(color: Colors.white),
          'li': TextStyle(color: Colors.white),
          'strong': TextStyle(color: Colors.white),
          'br ': TextStyle(color: Colors.white),
          'div': TextStyle(color: Colors.white),
        },
      ),
    );
    // return Html(
    //   data: html,
    //   style: {
    //     'p': Style(color: Colors.white),
    //     'ul': Style(color: Colors.white),
    //     'li': Style(color: Colors.white),
    //     'strong': Style(color: Colors.white),
    //     'br ': Style(color: Colors.white),
    //     'div': Style(color: Colors.white),
    //   },
    // );
  }

  String getPageData(int pageIndex, int productIndex, Map data) {
    if (data != null) {
      String keyName = data.keys.elementAt(productIndex);
      var uiPages = data[keyName]['page_setup'];
      String pageKeyName = uiPages.keys.elementAt(pageIndex);
      return '<div>' + uiPages[pageKeyName] + '</div>';
    }
    return '';
  }

  Future<String> getProductAnalytics() {
    var analytics = _callApi.callProductAnalysis(widget.screenArgs.caseID);
    return analytics;
  }

  void toggle() => animationController.isDismissed
      ? animationController.forward()
      : animationController.reverse();

  int index = 0;

  @override
  Widget build(BuildContext context) {
    print(widget.screenArgs.caseID);
    return WillPopScope(
      onWillPop: () async {
        print(animationController.value);
        if (animationController.value == 0.0) {
          if (widget.screenArgs.allowBack) {
            return true;
          }
          Navigator.pushNamedAndRemoveUntil(
              context, Routes.home, (route) => false);
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, _, __) => CustomerProfile(
                customerID: widget.screenArgs.caseID.toString(),
              ),
            ),
          );
          return false;
        } else {
          toggle();
          return false;
        }
      },
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, _) {
          double slide = MediaQuery.of(context).size.width *
              1.4 *
              (1 - animationController.value);

          double scale = 0.6 + (animationController.value * 0.4);

          return Stack(
            children: [
              Scaffold(
                backgroundColor: MyColors.backgroundColor(),
                appBar: AppBar(
                  backgroundColor: MyColors.backgroundColor(),
                  elevation: 10.0,
                  title: Text(
                    widget.title,
                    style: GoogleFonts.poppins(
                      color: MyColors.yellowColor(),
                    ),
                  ),
                ),
                body: FutureBuilder(
                    future: products,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var jsonData = json.decode(snapshot.data);
                        if (jsonData != null) {
                          // log(jsonData['data'].toString(), name: 'json data');

                          analyticsProducts = jsonData['data'];

                          // log(analyticsProducts.toString(),
                          //     name: 'this is anaylytics');
                        }
                        if (analyticsProducts == null) {
                          return Container();
                        }
                        return SafeArea(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 40.0,
                                      width: double.maxFinite,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        customerData['data']['load_type']
                                                .toString() +
                                            ' loan options for ' +
                                            customerData['data']['first_name'],
                                        style: GoogleFonts.poppins(
                                          fontSize: 20,
                                          color: MyColors.yellowColor(),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: analyticsProducts.length,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, i) {
                                          String key = analyticsProducts.keys
                                              .elementAt(i);
                                          return !(analyticsProducts[key]
                                                      ['product_name']
                                                  .toString()
                                                  .contains(widget
                                                      .screenArgs.loanType))
                                              ? SizedBox.shrink()
                                              : GestureDetector(
                                                  onTap: () {
                                                    if (index != i) {
                                                      _isLoading = true;
                                                    }
                                                    loanName =
                                                        analyticsProducts[key]
                                                            ['product_name'];
                                                    print(loanName);
                                                    print(widget
                                                        .screenArgs.loanType);
                                                    index = i;
                                                    setState(() {});
                                                    toggle();
                                                  },
                                                  child: Card(
                                                    child: ListTile(
                                                      // leading: Padding(
                                                      //   padding:
                                                      //       const EdgeInsets.only(
                                                      //           top: 6.0),
                                                      //   child: Icon(
                                                      //     FlutterIcons.appstore1_ant,
                                                      //     color: MyColors
                                                      //         .backgroundColor(),
                                                      //   ),
                                                      // ),
                                                      title: Text(
                                                        analyticsProducts[key]
                                                            ['product_name'],
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color: MyColors
                                                              .backgroundColor(),
                                                        ),
                                                      ),
                                                      subtitle: Text(
                                                        'EMI: ' +
                                                            (analyticsProducts[
                                                                    key]['emi'])
                                                                .toStringAsFixed(
                                                                    3),
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color: MyColors
                                                              .backgroundColor(),
                                                        ),
                                                      ),
                                                      trailing: IconButton(
                                                        icon: Icon(
                                                          FlutterIcons
                                                              .arrow_alt_circle_right_faw5,
                                                          color: MyColors
                                                              .backgroundColor(),
                                                        ),
                                                        onPressed: null,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    var message =
                        'Hey! , ${HomeState.agentName.value} - Financial Therapist, has shared with you a list of Loan products from Insider Lab App\n${Uri.encodeComponent("https://insiderlab.wostore.in/#/products-case/${widget.screenArgs.loanType.split(" ")[0].toLowerCase()}")}")}';
                    var url = "whatsapp://send?text=" + message;
                    // print(message);
                    launch(url);
                  },
                  hoverColor: Theme.of(context).primaryColor,
                  child: Icon(Icons.share),
                  foregroundColor: MyColors.darkBlue,
                  backgroundColor: Colors.indigo.shade50,
                ),
              ),
              Transform(
                transform: Matrix4.identity()
                  ..scale(0.57)
                  ..translate(
                    MediaQuery.of(context).size.width * 1.4,
                  ),
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: EdgeInsets.all(0.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      50.0 * (1 - animationController.value),
                    ),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.all(2.0 * (1 - animationController.value)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          50.0 * (1 - animationController.value)),
                      child: Stack(
                        children: [
                          Scaffold(
                            backgroundColor: MyColors.backgroundColor(),
                            appBar: AppBar(
                              backgroundColor: MyColors.backgroundColor(),
                              elevation: 10.0,
                              leading: IconButton(
                                splashRadius: 20.0,
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  color: MyColors.yellowColor(),
                                ),
                                onPressed: () {
                                  toggle();
                                },
                              ),
                              centerTitle: true,
                              title: Text(
                                "Product Details",
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  color: MyColors.yellowColor(),
                                ),
                              ),
                            ),
                            body: Container(
                              decoration: BoxDecoration(
                                // color: MyColors.yellowColor(),
                                color: Colors.blueGrey[100],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: SingleChildScrollView(),
                              ),
                            ),
                          ),
                          animationController.value == 1
                              ? SizedBox.shrink()
                              : Positioned.fill(
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX:
                                            5 * (1 - animationController.value),
                                        sigmaY: 5 *
                                            (1 - animationController.value)),
                                    child: Container(
                                      color: Colors.black.withOpacity(0),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Transform(
                transform: Matrix4.identity()
                  ..scale(scale)
                  ..translate(
                    slide,
                  ),
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: EdgeInsets.all(0.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        50.0 * (1 - animationController.value)),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.all(2.0 * (1 - animationController.value)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          50.0 * (1 - animationController.value)),
                      child: Stack(
                        children: [
                          Scaffold(
                            backgroundColor: MyColors.backgroundColor(),
                            appBar: AppBar(
                              backgroundColor: MyColors.backgroundColor(),
                              elevation: 10.0,
                              leading: IconButton(
                                splashRadius: 20.0,
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  color: MyColors.yellowColor(),
                                ),
                                onPressed: () {
                                  toggle();
                                },
                              ),
                              centerTitle: true,
                              title: Text(
                                "Product Details",
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  color: MyColors.yellowColor(),
                                ),
                              ),
                            ),
                            body: LoadingOverlay(
                              isLoading: _isLoading,
                              child: Center(
                                child: widget.screenArgs.loanType == null ||
                                        loanName == null
                                    ? SizedBox()
                                    : SfPdfViewer.network(
                                        getLink(
                                            type: widget.screenArgs.loanType,
                                            name: loanName),
                                        onDocumentLoaded: (data) {
                                          setState(() {
                                            _isLoading = false;
                                          });
                                        },
                                      ),
                              ),
                            ),
                            bottomNavigationBar: ButtonBar(
                              mainAxisSize: MainAxisSize.max,
                              alignment: MainAxisAlignment.center,
                              buttonMinWidth: double.maxFinite,
                              children: [
                                SizedBox(
                                  width: double.maxFinite,
                                  child: TextButton(
                                    onPressed: () {
                                      String key = analyticsProducts.keys
                                          .elementAt(index);
                                      var prodName = analyticsProducts[key]
                                          ['product_name'];
                                      var msg = 'Are you sure you want to select ' +
                                          prodName +
                                          '? An OTP will be sent to customer\'s email. Get in touch with customer to retrieve the same.';
                                      return showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text('Select Product'),
                                              content: Text(msg),
                                              actions: [
                                                FlatButton(
                                                  child: Text('No'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                                FlatButton(
                                                  child: Text('Yes'),
                                                  onPressed: () {
                                                    selectProduct(index);
                                                  },
                                                ),
                                              ],
                                              elevation: 24.0,
                                            );
                                          });
                                    },
                                    child: Text(
                                      "Select",
                                      style: TextStyle(
                                        color: MyColors.darkBlue,
                                      ),
                                    ),
                                    style: TextButton.styleFrom(
                                      backgroundColor: MyColors.yellowColor(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          animationController.value == 1
                              ? SizedBox.shrink()
                              : Positioned.fill(
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX:
                                            5 * (1 - animationController.value),
                                        sigmaY: 5 *
                                            (1 - animationController.value)),
                                    child: Container(
                                      color: Colors.black.withOpacity(0),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void selectProduct(int productIndex) {
    callSendOtpApi(productIndex);
  }

  void callSendOtpApi(int productIndex) {
    String keyName = analyticsProducts.keys.elementAt(productIndex);

    String caseID = widget.screenArgs.caseID;
    String emailID = widget.screenArgs.emailID;
    CallApi _callApi = new CallApi();
    try {
      Customer customerData = Customer();
      customerData.otpType = 'case';
      customerData.emailID = widget.screenArgs.emailID;
      customerData.caseID = widget.screenArgs.caseID;

      Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => OtpScreenProduct(
                    customerData: customerData,
                    productID: keyName,
                  )));
      // OTPScreenArgs args = new OTPScreenArgs(
      //     '/customerDetail', 'product_selection', keyName, caseID, emailID);
      // Navigator.pushNamed(context, '/customerProductOtpScreen',
      //     arguments: args);
    } catch (e) {
      print("Exception caught calling send otp api $e");
    }
  }

  String getLink({String type, String name}) {
    print(type);
    print(name);

    if (type == "Personal") {
      if (name == "IDFC Personal Loan") {
        return "https://www.insiderlab.in/pro-det/PersonalLoan/IDFC-PL-PD.pdf";
      }
      if (name == "Bajaj Finance Personal Loan") {
        return "https://www.insiderlab.in/pro-det/PersonalLoan/BAJAJ-PL-PD.pdf";
      }
      if (name == "HDFC Personal Loan") {
        return "https://www.insiderlab.in/pro-det/PersonalLoan/HDFC-PL-PD.pdf";
      }
      if (name == "ICICI Bank Personal Loan") {
        return "https://www.insiderlab.in/pro-det/PersonalLoan/ICICI-PL-PD.pdf";
      }
    }
    if (type == "Professional") {
      if (name == "IDFC Professional Loan") {
        return "https://www.insiderlab.in/pro-det/ProfessionalLoan/IDFC-PL-PD.pdf";
      }
      if (name == "Bajaj Finance Professional Loan") {
        return "https://www.insiderlab.in/pro-det/ProfessionalLoan/BAJAJ-PL-PD.pdf";
      }
      if (name == "HDFC Professional Loan") {
        return "https://www.insiderlab.in/pro-det/ProfessionalLoan/HDFC-PL-PD.pdf";
      }
      if (name == "ICICI Bank Professional Loan") {
        return "https://www.insiderlab.in/pro-det/ProfessionalLoan/ICICI-PL-PD.pdf";
      }
    }
    if (type == "Business") {
      if (name == "IDFC Business Loan") {
        return "https://www.insiderlab.in/pro-det/BusinessLoan/IDFC-BL-PD.pdf";
      }
      if (name == "Bajaj Finance Business Loan") {
        return "https://www.insiderlab.in/pro-det/BusinessLoan/BAJAJ-BL-PD.pdf";
      }
      if (name == "HDFC Business Loan") {
        return "https://www.insiderlab.in/pro-det/BusinessLoan/HDFC-BL-PD.pdf";
      }
      if (name == "ICICI Bank Business Loan") {
        return "https://www.insiderlab.in/pro-det/BusinessLoan/ICICI-BL-PD.pdf";
      }
    }
  }
}
