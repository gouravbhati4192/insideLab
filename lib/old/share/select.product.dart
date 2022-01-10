import 'package:dio/dio.dart';
import 'package:financial_freedom/new%20ui%20pages/customer.details.screen.dart';
import 'package:financial_freedom/old/Model/ProductsArguments.dart';
import 'package:financial_freedom/old/Model/customerData.dart';
import 'package:financial_freedom/old/share/animated-product-list.dart';
import 'package:financial_freedom/old/share/produce.list.model.dart';
import 'package:financial_freedom/old/share/product-comparative-analysis.dart';
import 'package:financial_freedom/old/widgets/common/colors.dart';
import 'package:financial_freedom/old/widgets/common/mycolors.dart';
import 'package:financial_freedom/old/widgets/common/raisedButton.dart';
import 'package:financial_freedom/old/widgets/common/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectProduct extends StatefulWidget {
  final String name;
  SelectProduct(this.name);
  @override
  _SelectProductState createState() => _SelectProductState();
}

class _SelectProductState extends State<SelectProduct> {
  bool firstTime = true;
  bool loading = true;
  ProductList productList;
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
          this.productList = ProductList.fromJson(res.data);
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

  getData() async {
    await getProductList();
    getProductData(0);
    setState(() => loading = false);
  }

  String getProductData(int productIndex) {
    String htmlPageData = '';
    productList.data[productIndex].features.pageSetup.keys
        .toList()
        .forEach((e) {
      htmlPageData += '<div>';
      htmlPageData += productList.data[productIndex].features.pageSetup[e];
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
      loading = false;
      // getData();
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: yellowColor()),
        title: Text(
          widget.name ?? '',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline6.merge(
                TextStyle(
                  fontSize: 18,
                  color: yellowColor(),
                ),
              ),
        ),
      ),
      body: loading
          ? Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 200,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 40),
                    child: ButtonTheme(
                      height: 50,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: RaisedButton(
                        child: Center(
                          child: Text(
                            'Product Comparative Analysis',
                            style: Theme.of(context).textTheme.headline6.merge(
                                TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500)),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        color: GetColor.lightgray,
                        onPressed: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => ProductComparativeAnalysis(
                                  type: widget.name.toString()),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 40),
                    child: ButtonTheme(
                      height: 50,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: RaisedButton(
                        child: Center(
                          child: Text(
                            'Product Detailed Analysis',
                            style: Theme.of(context).textTheme.headline6.merge(
                                TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500)),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        color: GetColor.lightgray,
                        onPressed: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => ShareProductList(
                                type: widget.name,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(
                  //     left: 18.0,
                  //     right: 18.0,
                  //     top: 75.0,
                  //     bottom: 8.0,
                  //   ),
                  //   child: Divider(
                  //     color: MyColors.yellowColor(),
                  //     thickness: 1,
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.only(
                  //       left: 16.0, top: 0.0, bottom: 8.0),
                  //   child: Row(
                  //     children: [
                  //       Text(
                  //         "Product List",
                  //         style: GoogleFonts.poppins(
                  //           color: MyColors.yellowColor(),
                  //           fontSize: 24,
                  //           fontWeight: FontWeight.bold,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // Expanded(
                  //   child: ListView.builder(
                  //     shrinkWrap: true,
                  //     itemCount: productList.data.length,
                  //     itemBuilder: (context, i) {
                  //       return Container(
                  //         margin: EdgeInsets.symmetric(
                  //             vertical: 0.0, horizontal: 10.0),
                  //         child: Card(
                  //           child: ListTile(
                  //             leading: Padding(
                  //               padding: const EdgeInsets.only(top: 6.0),
                  //               child: Icon(
                  //                 FlutterIcons.appstore1_ant,
                  //                 color: MyColors.backgroundColor(),
                  //               ),
                  //             ),
                  //             title: Text(
                  //               productList.data[i].name ?? '',
                  //               maxLines: 2,
                  //               style: GoogleFonts.poppins(
                  //                 color: MyColors.backgroundColor(),
                  //               ),
                  //             ),
                  //             subtitle: Text(
                  //               productList.data[i].type ?? '',
                  //               maxLines: 1,
                  //               style: GoogleFonts.poppins(
                  //                 color: MyColors.backgroundColor(),
                  //               ),
                  //             ),
                  //             trailing: IconButton(
                  //               icon: Icon(
                  //                 FlutterIcons.arrow_alt_circle_right_faw5,
                  //                 color: MyColors.backgroundColor(),
                  //               ),
                  //               onPressed: () {
                  //                 // index = i;
                  //                 setState(() {});
                  //                 // toggle();
                  //               },
                  //             ),
                  //           ),
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // )
                ],
              ),
            ),
    );
  }
}
