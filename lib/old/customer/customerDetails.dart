import 'dart:convert';

import 'package:financial_freedom/old/Model/DocumentsScreenArguments.dart';
import 'package:financial_freedom/old/Model/ProductsArguments.dart';
import 'package:financial_freedom/old/widgets/common/ApiConstants.dart';
import 'package:financial_freedom/old/widgets/common/CallApi.dart';
import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomerDetails extends StatefulWidget {
  final String customerID;

  const CustomerDetails({Key key, this.customerID}) : super(key: key);
  @override
  _CustomerDetailsState createState() => _CustomerDetailsState();
}

CallApi _callApi = new CallApi();

class _CustomerDetailsState extends State<CustomerDetails> {
  Future customerData;
  var _controller = new TextEditingController();
  var _infostyle = TextStyle(fontSize: 10, color: Colors.black);
  var _valuestyle =
      TextStyle(fontSize: 10, color: Colors.black, fontWeight: FontWeight.bold);
  List<String> _timeline_status = [
    'In Process',
    'Document Collection',
    'Submitted',
    'Eligibility Inquiry',
    'Bank Login',
    'Approved',
    'Disbursed',
  ];

  @override
  void initState() {
    super.initState();
    customerData = _callApi.callGetApi(
        ApiConstants.CASE_DETAILS + widget.customerID, true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pushNamedAndRemoveUntil(
            context, '/home', (Route route) => false);
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Customer Details',
          ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder(
              future: customerData,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var customerDetailsJson;
                  var jsonData = json.decode(snapshot.data);
                  if (jsonData['data'] != null) {
                    customerDetailsJson = jsonData['data'];
                  }
                  return ListView(
                    children: [
                      Card(
                        color: Colors.blue[700],
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ListTile(
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                customerDetailsJson['first_name'] == null
                                    ? ''
                                    : customerDetailsJson['first_name'],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                customerDetailsJson['load_type'] == null
                                    ? ''
                                    : customerDetailsJson['load_type'],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.call,
                              color: Colors.indigo[900],
                            ),
                            onPressed: () {
                              launch('tel://' +
                                  (customerDetailsJson['mobile'] == null
                                      ? ''
                                      : customerDetailsJson['mobile']));
                            },
                          ),
                        ),
                      ),
                      Container(
                        height: 50,
                        child: Timeline.tileBuilder(
                          scrollDirection: Axis.horizontal,
                          builder: TimelineTileBuilder.fromStyle(
                            contentsAlign: ContentsAlign.alternating,
                            contentsBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                              child: Text(
                                _timeline_status[index],
                                style: TextStyle(
                                    color: Colors.black, fontSize: 10),
                              ),
                            ),
                            itemCount: _timeline_status.length,
                          ),
                        ),
                      ),
                      Container(
                        height: 130,
                        margin: EdgeInsets.all(8),
                        color: Colors.grey[300],
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 2, 0, 0),
                              child: Text(
                                'Application Info',
                                style: TextStyle(
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: RichText(
                                      text: TextSpan(
                                        text: 'Case ID:',
                                        style: _infostyle,
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: customerDetailsJson['id'] ==
                                                      null
                                                  ? ''
                                                  : customerDetailsJson['id']
                                                      .toString(),
                                              style: _valuestyle),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: RichText(
                                      text: TextSpan(
                                        text: 'Address on Aadhaar:',
                                        style: _infostyle,
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: customerDetailsJson[
                                                          'address_type'] ==
                                                      null
                                                  ? ''
                                                  : customerDetailsJson[
                                                          'address_type']
                                                      .toString(),
                                              style: _valuestyle),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: RichText(
                                      text: TextSpan(
                                        text: 'Salary:',
                                        style: _infostyle,
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: customerDetailsJson[
                                                          'monthly_salary'] ==
                                                      null
                                                  ? ''
                                                  : '${customerDetailsJson['monthly_salary']}/month',
                                              style: _valuestyle),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: RichText(
                                      text: TextSpan(
                                        text: 'Residential Status:',
                                        style: _infostyle,
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: customerDetailsJson[
                                                          'residential_status'] ==
                                                      null
                                                  ? ''
                                                  : customerDetailsJson[
                                                      'residential_status'],
                                              style: _valuestyle),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: RichText(
                                      text: TextSpan(
                                        text: 'Employment type:',
                                        style: _infostyle,
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: customerDetailsJson[
                                                          'employment_type'] ==
                                                      null
                                                  ? ''
                                                  : customerDetailsJson[
                                                      'employment_type'],
                                              style: _valuestyle),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: RichText(
                                      text: TextSpan(
                                        text: 'Occupation:',
                                        style: _infostyle,
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: customerDetailsJson[
                                                          'occupation'] ==
                                                      null
                                                  ? ''
                                                  : customerDetailsJson[
                                                      'occupation'],
                                              style: _valuestyle),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: RichText(
                                      text: TextSpan(
                                        text: 'Company:',
                                        style: _infostyle,
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: customerDetailsJson[
                                                          'employer_name'] ==
                                                      null
                                                  ? ''
                                                  : customerDetailsJson[
                                                      'employer_name'],
                                              style: _valuestyle),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: RichText(
                                      text: TextSpan(
                                        text: 'Location:',
                                        style: _infostyle,
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: customerDetailsJson[
                                                          'pin_code'] ==
                                                      null
                                                  ? ''
                                                  : customerDetailsJson[
                                                      'pin_code'],
                                              style: _valuestyle),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: RichText(
                                      text: TextSpan(
                                        text: 'Total Experience:',
                                        style: _infostyle,
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: customerDetailsJson[
                                                          'work_experience'] ==
                                                      null
                                                  ? ''
                                                  : customerDetailsJson[
                                                      'work_experience'],
                                              style: _valuestyle),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: RichText(
                                      text: TextSpan(
                                        text: 'Income:',
                                        style: _infostyle,
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: customerDetailsJson[
                                                          'client_income'] ==
                                                      null
                                                  ? ''
                                                  : customerDetailsJson[
                                                      'client_income'],
                                              style: _valuestyle),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: RichText(
                                text: TextSpan(
                                  text: ' Type of Income:',
                                  style: _infostyle,
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: customerDetailsJson[
                                                    'inform_client_income'] ==
                                                null
                                            ? ''
                                            : customerDetailsJson[
                                                'inform_client_income'],
                                        style: _valuestyle),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Card(
                        color: Colors.blue[700],
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ListTile(
                          onTap: () {
                            ProductsArguments args = new ProductsArguments(
                                customerDetailsJson['id'].toString(),
                                null,
                                customerDetailsJson['email'].toString());
                            Navigator.pushNamed(
                                context, '/newCustomer/productDetails',
                                arguments: args);
                          },
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Selection',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    customerDetailsJson['product_name'] == null
                                        ? 'Product Not Selected'
                                        : customerDetailsJson['product_name']
                                            .toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    customerDetailsJson['load_amount'] == null
                                        ? ''
                                        : customerDetailsJson['load_amount'],
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 100),
                      Card(
                        color: Colors.blue[700],
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/documentList',
                                    arguments: new DocumentsScreenArguments(
                                        customerDetailsJson['id'] == null
                                            ? ''
                                            : customerDetailsJson['id']
                                                .toString(),
                                        customerDetailsJson,'',
                                        customerDetailsJson['document_list'] ==
                                                null
                                            ? ''
                                            : customerDetailsJson[
                                                'document_list']));
                              },
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'documents'.toUpperCase(),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(
                                        Icons.done_rounded,
                                        color: Colors.white,
                                      ),
                                      Icon(
                                        Icons.upload_file,
                                        color: Colors.indigo[900],
                                      ),
                                      Icon(
                                        Icons.upload_file,
                                        color: Colors.indigo[900],
                                      ),
                                      Icon(
                                        Icons.upload_file,
                                        color: Colors.indigo[900],
                                      ),
                                      Icon(
                                        Icons.upload_file,
                                        color: Colors.indigo[900],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )),
                      ),
                      SizedBox(height: 15),
                      Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        child: Card(
                          shadowColor: Colors.grey,
                          elevation: 7,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Activity',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.all(8),
          height: 75,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                flex: 9,
                child: Card(
                  color: Colors.blue[700],
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextField(
                      controller: _controller,
                      decoration:
                          InputDecoration.collapsed(hintText: "Comment..."),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Expanded(
                      child: IconButton(
                          icon: Icon(Icons.support_agent),
                          color: Colors.indigo,
                          onPressed: () {}),
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 7, 0, 0),
                      child: Text(
                        'support',
                        style: TextStyle(fontSize: 10, color: Colors.black),
                      ),
                    )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
