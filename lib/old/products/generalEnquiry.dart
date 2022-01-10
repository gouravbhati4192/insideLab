import 'dart:convert';

import 'package:financial_freedom/old/Home/home.dart';
import 'package:financial_freedom/old/Model/ProductsArguments.dart';
import 'package:financial_freedom/old/widgets/common/ApiConstants.dart';
import 'package:financial_freedom/old/widgets/common/CallApi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

TextStyle getSubTextStyle(var context) {
  return Theme.of(context)
      .textTheme
      .bodyText2
      .merge(TextStyle(fontSize: 16, color: Colors.white));
}

CallApi _callApi = new CallApi();
List productsList;

class GeneralEnquiry extends StatefulWidget {
  final String title;

  GeneralEnquiry({this.title});

  @override
  _GeneralEnquiryState createState() => _GeneralEnquiryState();
}

TextStyle getTitleTextStyle(var context) {
  return Theme.of(context).textTheme.bodyText1.merge(TextStyle(
      fontSize: 18, color: Colors.white, fontStyle: FontStyle.italic));
}

class _GeneralEnquiryState extends State<GeneralEnquiry> {
  int value;
  String caseID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: getAllProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var jsonData = json.decode(snapshot.data);
            if (jsonData != null) {
              productsList = jsonData['data'];
            }
            return Container(
              height: double.infinity,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.all(20),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "General Inquiry",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.all(8),
                      itemCount: productsList.length,
                      itemBuilder: (context, index) {
                        // Map elementMap = productsList[index];
                        return Material(
                            color: Theme.of(context).primaryColor,
                            child: ListTile(
                              onTap: () => showProductSummary(),
                              leading: Icon(
                                Icons.request_quote_outlined,
                                size: 40,
                                color: Colors.white,
                              ),
                              title: Text(
                                productsList[index]['name'] == null
                                    ? ''
                                    : productsList[index]['name'],
                                style: getTitleTextStyle(context),
                              ),
                              subtitle: Text(
                                  productsList[index]['type'] == null
                                      ? ''
                                      : productsList[index]['type'],
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
                'Hey! , ${HomeState.agentName.value} - Financial Therapist, has shared with you a list of Loan products from Insider Lab App\n${Uri.encodeComponent("https://insiderlab.wostore.in/#/products-case/")}';
            var url = "whatsapp://send?text=" + message;
            launch(url);
          },
          hoverColor: Theme.of(context).primaryColor,
          child: Icon(Icons.share),
          foregroundColor: Theme.of(context).primaryColor,
          backgroundColor: Colors.indigo.shade50),
    );
  }

  Future<String> getAllProducts() {
    var productsList = _callApi.callGetApi(ApiConstants.PRODUCTS, true);
    return productsList;
  }

  void showProductSummary() {
    GeneralEnquiryArguments argu = new GeneralEnquiryArguments(productsList);
    Navigator.pushNamed(context, '/generalEnquiryDetails', arguments: argu);
  }
}
