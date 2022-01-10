import 'dart:convert';

import 'package:financial_freedom/old/Home/home.dart';
import 'package:financial_freedom/old/Model/ProductsArguments.dart';
import 'package:financial_freedom/old/widgets/common/CallApi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NewProductDetails extends StatefulWidget {
  final String title;
  final ProductsArguments screenArgs;
  NewProductDetails({this.title, this.screenArgs});

  @override
  _NewProductDetailsState createState() => _NewProductDetailsState();
}

int selectedPageIndex;

class _NewProductDetailsState extends State<NewProductDetails> {
  int value;
  Future<String> products;
  CallApi _callApi = new CallApi();
  Map analyticsProducts;

  TextStyle getTitleTextStyle(var context) {
    return Theme.of(context).textTheme.bodyText1.merge(TextStyle(
        fontSize: 18, color: Colors.white, fontStyle: FontStyle.italic));
  }

  TextStyle getSubTextStyle(var context) {
    return Theme.of(context)
        .textTheme
        .bodyText2
        .merge(TextStyle(fontSize: 16, color: Colors.white));
  }

  @override
  void initState() {
    super.initState();
    products = getProductAnalytics();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pushNamedAndRemoveUntil(
            context, '/customerDetail', (Route route) => false,
            arguments: widget.screenArgs.caseID);
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/customerDetail', (Route route) => false,
                  arguments: widget.screenArgs.caseID);
            },
          ),
        ),
        body: FutureBuilder(
          future: products,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var jsonData = json.decode(snapshot.data);
              if (jsonData != null) {
                analyticsProducts = jsonData['data'];
              }
              return Container(
                height: double.infinity,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        "Product Details",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.all(8),
                        itemCount: analyticsProducts.length,
                        itemBuilder: (context, index) {
                          String key = analyticsProducts.keys.elementAt(index);
                          return Material(
                              color: Theme.of(context).primaryColor,
                              child: ListTile(
                                onTap: () => showProductSummary(index),
                                leading: Icon(
                                  Icons.request_quote_outlined,
                                  size: 40,
                                  color: Colors.white,
                                ),
                                title: Text(
                                  analyticsProducts[key]['product_name'],
                                  style: getTitleTextStyle(context),
                                ),
                                subtitle: Text(
                                    'EMI: ' +
                                        (analyticsProducts[key]['emi'])
                                            .toStringAsFixed(3),
                                    style: getSubTextStyle(context)),
                                trailing: Icon(
                                  Icons.navigate_next_rounded,
                                  size: 30,
                                  color: Colors.white,
                                ),
                              ));
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider();
                        },
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              var message =
                  'Hey! , ${HomeState.agentName.value} - Financial Therapist, has shared with you a list of Loan products from Insider Lab App\n${Uri.encodeComponent("https://insiderlab.wostore.in/#/products-case")}';
              var url = "whatsapp://send?text=" + message;

              launch(url);
            },
            hoverColor: Theme.of(context).primaryColor,
            child: Icon(Icons.share),
            foregroundColor: Theme.of(context).primaryColor,
            backgroundColor: Colors.indigo.shade50),
      ),
    );
  }

  Future<String> getProductAnalytics() {
    var analytics = _callApi.callProductAnalysis(widget.screenArgs.caseID);
    return analytics;
  }

  void showProductSummary(int index) {
    selectedPageIndex = index;
    ProductsArguments argu = new ProductsArguments(
        widget.screenArgs.caseID, analyticsProducts, widget.screenArgs.emailID);
    Navigator.pushNamed(context, '/newCustomer/productSummary',
        arguments: argu);
  }
}
