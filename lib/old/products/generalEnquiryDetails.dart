import 'package:financial_freedom/old/Model/ProductsArguments.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';
// import 'package:flutter_html/style.dart';

TextStyle getTextStyle(var context) {
  return Theme.of(context).textTheme.bodyText2.merge(TextStyle(
      fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold));
}

List pageSetup;

class GeneralEnquiryDetails extends StatefulWidget {
  final String title;

  GeneralEnquiryDetails({Key key, this.title}) : super(key: key);
  @override
  _GeneralEnquiryDetailsState createState() => _GeneralEnquiryDetailsState();
}

class _GeneralEnquiryDetailsState extends State<GeneralEnquiryDetails> {
  PageController _controller =
      PageController(initialPage: 0, viewportFraction: 0.9);
  TextStyle headingTextStyle;
  int tapCount;

  @override
  void initState() {
    super.initState();
    tapCount = 0;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Widget getHtmlPage(int pageIndex, int productIndex) {
  //   var html = getPageData(pageIndex, productIndex);
  //   return SingleChildScrollView(
  //       child: Html(
  //     data: html,
  //     style: {
  //       'p': Style(color: Colors.white),
  //       'ul': Style(color: Colors.white),
  //       'li': Style(color: Colors.white)
  //     },
  //   ));
  // }

  String getPageData(int pageIndex, int productIndex) {
    if (pageSetup != null) {
      //String keyName = pageSetup.keys.elementAt(productIndex);
      if (pageSetup[productIndex]['features'] != null &&
          pageSetup[productIndex]['features'].length > 0) {
        var uiPages = pageSetup[productIndex]['features']['page_setup'];
        String pageKeyName = uiPages.keys.elementAt(pageIndex);
        return '<div>' + uiPages[pageKeyName] + '</div>';
      }
    }
    return '';
  }

  Widget getCard(var context, int pageIndex, int productIndex) {
    return Card(
      margin: const EdgeInsets.all(10),
      color: Theme.of(context).primaryColor,
      shadowColor: Colors.grey[700],
      elevation: 7.0,
      semanticContainer: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              height: 100.0,
              width: 100.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.deepOrange, Colors.orangeAccent]),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 4,
                      blurRadius: 5,
                      offset: Offset(0, 3))
                ],
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(50),
                  bottomLeft: Radius.circular(100),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              height: 60.0,
              width: 60.0,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 4,
                      blurRadius: 5,
                      offset: Offset(0, 3))
                ],
                gradient: LinearGradient(
                    colors: [Colors.orangeAccent, Colors.deepOrange]),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(60),
                  bottomLeft: Radius.circular(50),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 40, 30, 40),
            // child: getHtmlPage(pageIndex, productIndex),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool buildUI = false;
    GeneralEnquiryArguments args = ModalRoute.of(context).settings.arguments;
    pageSetup = args.productsList;
    if (pageSetup != null) {
      buildUI = true;
    }
    headingTextStyle = Theme.of(context).textTheme.headline6.merge(
          TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        );
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: buildUI
            ? Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: PageView.builder(
                  itemCount: pageSetup.length,
                  controller: _controller,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (tapCount <= 3) {
                              tapCount++;
                            }
                            if (tapCount > 3) {
                              tapCount = 0;
                            }
                          });
                        },
                        child: getCard(context, tapCount, index));
                  },
                ),
              )
            : Container(
                padding: new EdgeInsets.all(32.0),
                child: Center(
                  child: Column(
                    children: [
                      Card(
                        child: Container(
                          padding: new EdgeInsets.all(32.0),
                          child: Column(
                            children: [
                              Icon(
                                Icons.error_outline_outlined,
                                color: Colors.red[900],
                                size: 30,
                              ),
                              Text(
                                'Something went wrong',
                                style: new TextStyle(fontSize: 18),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ));
  }
}
