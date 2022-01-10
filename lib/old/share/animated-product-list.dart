import 'dart:developer';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:financial_freedom/new%20ui%20pages/customer.details.screen.dart';
import 'package:financial_freedom/old/Home/home.dart';
import 'package:financial_freedom/old/share/produce.list.model.dart';
import 'package:financial_freedom/old/widgets/common/mycolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:simple_html_css/simple_html_css.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';

class ShareProductList extends StatefulWidget {
  final String type;
  ShareProductList({Key key, this.type}) : super(key: key);

  @override
  _ShareProductListState createState() => _ShareProductListState();
}

class _ShareProductListState extends State<ShareProductList>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  bool firstTime = true;
  bool isWeb = false;
  List<Datum> productList = [];
  ProductList data;
  Future<bool> getProductList() async {
    try {
      Response res = await Dio().get(
        'https://crmtest.insiderlab.in/api/get_all_products',
        options: Options(
          headers: {"verify-myself": "banana"},
        ),
      );
      if (res.statusCode == 200) {
        if (res.data['error'] == 0) {
          this.data = ProductList.fromJson(res.data);
          data.data.forEach((e) {
            if (e.type.toLowerCase() ==
                widget.type.split(" ")[0].toLowerCase()) {
              productList.add(e);
            }
          });
          setState(() {});
        }
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 350,
      ),
    );
  }

  void toggle() => animationController.isDismissed
      ? animationController.forward()
      : animationController.reverse();

  int index = 0;
  bool loading = true;
  getData() async {
    if (await getProductList()) {
      getProductData(0);
      setState(() => loading = false);
    }
  }

  Widget getHtmlPage(
    int pageIndex,
  ) {
    var html = getProductData(pageIndex);
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
        // overrideStyle: {
        //   "p": TextStyle(color: Colors.white),
        //   "ul": TextStyle(color: Colors.white),
        //   "li": TextStyle(color: Colors.white),
        //   // specify any tag not just the supported ones,
        //   // and apply TextStyles to them and/override them
        // },
      ),
    );
  }

  String getProductData(int productIndex) {
    String htmlPageData = '';
    productList[productIndex].features.pageSetup.keys.toList().forEach((e) {
      htmlPageData += '<div>';
      htmlPageData += productList[productIndex].features.pageSetup[e];
      htmlPageData += '<div>';
    });
    // log(htmlPageData, name: 'html page data');
    // if (pageSetup != null) {
    //   //String keyName = pageSetup.keys.elementAt(productIndex);
    //   if (pageSetup[productIndex]['features'] != null &&
    //       pageSetup[productIndex]['features'].length > 0) {
    //     var uiPages = pageSetup[productIndex]['features']['page_setup'];
    //     String pageKeyName = uiPages.keys.elementAt(pageIndex);
    //     return '<div>' + uiPages[pageKeyName] + '</div>';
    //   }
    // }
    return htmlPageData;
  }

  @override
  Widget build(BuildContext context) {
    if (firstTime) {
      firstTime = false;
      getData();
    }
    return loading
        ? Scaffold(
            appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              iconTheme: IconThemeData(color: yellowColor()),
              title: Text(
                'Product Detailed Analysis',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline6.merge(
                      TextStyle(
                        fontSize: 18,
                        color: yellowColor(),
                      ),
                    ),
              ),
            ),
          )
        : LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 500) {
                isWeb = true;
              } else {
                isWeb = false;
              }
              return AnimatedBuilder(
                animation: animationController,
                builder: (context, _) {
                  double slide = MediaQuery.of(context).size.width *
                      1.3 *
                      (1 - animationController.value);

                  double scale = 0.6 + (animationController.value * 0.4);

                  return Stack(
                    children: [
                      Scaffold(
                        appBar: AppBar(
                          elevation: 0,
                          centerTitle: true,
                          iconTheme: IconThemeData(color: yellowColor()),
                          title: Text(
                            'Product Detailed Analysis',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headline6.merge(
                                  TextStyle(
                                    fontSize: 18,
                                    color: yellowColor(),
                                  ),
                                ),
                          ),
                        ),
                        backgroundColor: MyColors.backgroundColor(),
                        body: SafeArea(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 80.0,
                                      width: double.maxFinite,
                                    ),
                                    // Padding(
                                    //   padding: const EdgeInsets.all(8.0),
                                    //   child: Text(
                                    //     "Product List",
                                    //     style: GoogleFonts.poppins(
                                    //       color: MyColors.yellowColor(),
                                    //       fontSize: 24,
                                    //       fontWeight: FontWeight.bold,
                                    //     ),
                                    //   ),
                                    // ),
                                    SizedBox(
                                      height: 40.0,
                                      width: double.maxFinite,
                                    ),
                                    SizedBox(
                                      width: isWeb
                                          ? MediaQuery.of(context).size.width *
                                              0.5
                                          : MediaQuery.of(context).size.width *
                                              0.6,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: productList.length,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, i) {
                                          return Container(
                                            margin: EdgeInsets.symmetric(
                                              vertical: isWeb ? 20.0 : 0.0,
                                            ),
                                            child: Card(
                                              child: ListTile(
                                                leading: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 6.0),
                                                  child: Icon(
                                                    FlutterIcons.appstore1_ant,
                                                    color: MyColors
                                                        .backgroundColor(),
                                                  ),
                                                ),
                                                title: Text(
                                                  productList[i].name ?? '',
                                                  maxLines: 2,
                                                  style: GoogleFonts.poppins(
                                                    color: MyColors
                                                        .backgroundColor(),
                                                  ),
                                                ),
                                                subtitle: Text(
                                                  productList[i].type ?? '',
                                                  maxLines: 1,
                                                  style: GoogleFonts.poppins(
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
                                                  onPressed: () {
                                                    if (index != i) {
                                                      _isLoading = true;
                                                    }
                                                    index = i;
                                                    setState(() {});
                                                    toggle();
                                                  },
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
                        ),
                        floatingActionButton: FloatingActionButton(
                          onPressed: () {
                            var message =
                                'Hey! , ${HomeState.agentName.value} - Financial Therapist, has shared with you a list of loan products from Insider Lab App\n${Uri.encodeComponent("https://insiderlab.wostore.in/#/products-case/${widget.type.split(" ")[0].toLowerCase()}")}';
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
                            MediaQuery.of(context).size.width * 1.3,
                          ),
                        alignment: Alignment.centerLeft,
                        child: Container(
                          width: constraints.maxWidth,
                          margin: EdgeInsets.all(0.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              50.0 * (1 - animationController.value),
                            ),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(
                                2.0 * (1 - animationController.value)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  50.0 * (1 - animationController.value)),
                              child: Stack(
                                children: [
                                  Scaffold(
                                    backgroundColor: MyColors.backgroundColor(),
                                    appBar: AppBar(
                                      backgroundColor: MyColors.yellowColor(),
                                      elevation: 10.0,
                                      leading: IconButton(
                                        splashRadius: 20.0,
                                        icon: Icon(
                                          Icons.arrow_back,
                                          color: Colors.black,
                                        ),
                                        onPressed: () {
                                          toggle();
                                        },
                                      ),
                                      centerTitle: true,
                                      title: Text(
                                        "Product Details",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    body: Container(
                                      width: constraints.maxWidth,
                                      decoration: BoxDecoration(
                                        // color: MyColors.yellowColor(),
                                        color: Colors.blueGrey[100],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: SingleChildScrollView(
                                          child: getHtmlPage(index),
                                        ),
                                      ),
                                    ),
                                  ),
                                  animationController.value == 1
                                      ? SizedBox.shrink()
                                      : Positioned.fill(
                                          child: BackdropFilter(
                                            filter: ImageFilter.blur(
                                                sigmaX: 5 *
                                                    (1 -
                                                        animationController
                                                            .value),
                                                sigmaY: 5 *
                                                    (1 -
                                                        animationController
                                                            .value)),
                                            child: Container(
                                              color:
                                                  Colors.black.withOpacity(0),
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
                          width: constraints.maxWidth,
                          margin: EdgeInsets.all(0.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              50.0 * (1 - animationController.value),
                            ),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(
                                2.0 * (1 - animationController.value)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  50.0 * (1 - animationController.value)),
                              child: Stack(
                                children: [
                                  WillPopScope(
                                    onWillPop: () async {
                                      print(animationController.value);
                                      if (animationController.value == 0.0) {
                                        return true;
                                      } else {
                                        toggle();
                                        return false;
                                      }
                                    },
                                    child: Scaffold(
                                      backgroundColor:
                                          MyColors.backgroundColor(),
                                      appBar: AppBar(
                                        backgroundColor: MyColors.yellowColor(),
                                        elevation: 10.0,
                                        leading: IconButton(
                                          splashRadius: 20.0,
                                          icon: Icon(
                                            Icons.arrow_back,
                                            color: Colors.black,
                                          ),
                                          onPressed: () {
                                            toggle();
                                          },
                                        ),
                                        centerTitle: true,
                                        title: Text(
                                          "Product Details",
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      body: Container(
                                        width: constraints.maxWidth,
                                        decoration: BoxDecoration(
                                          // color: MyColors.yellowColor(),
                                          color: Colors.blueGrey[100],
                                        ),
                                        child: LoadingOverlay(
                                          isLoading: _isLoading,
                                          child: Center(
                                            child: SfPdfViewer.network(
                                              getLink(
                                                  type: widget.type,
                                                  name:
                                                      productList[index].name),
                                              onDocumentLoaded: (data) {
                                                setState(() {
                                                  _isLoading = false;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  animationController.value == 1
                                      ? SizedBox.shrink()
                                      : Positioned.fill(
                                          child: BackdropFilter(
                                            filter: ImageFilter.blur(
                                                sigmaX: 5 *
                                                    (1 -
                                                        animationController
                                                            .value),
                                                sigmaY: 5 *
                                                    (1 -
                                                        animationController
                                                            .value)),
                                            child: Container(
                                              color:
                                                  Colors.black.withOpacity(0),
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
              );
            },
          );
  }

  String getLink({String type, String name}) {
    if (type == "Personal Loan") {
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
    if (type == "Professional Loan") {
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
    if (type == "Business Loan") {
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

  bool _isLoading = true;
}
