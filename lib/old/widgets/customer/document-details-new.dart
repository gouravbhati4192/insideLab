import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:financial_freedom/old/Model/DocumentsScreenArguments.dart';
import 'package:financial_freedom/old/widgets/common/ApiConstants.dart';
import 'package:financial_freedom/old/widgets/common/CallApi.dart';
import 'package:financial_freedom/old/widgets/common/ShowSnackBar.dart';
import 'package:financial_freedom/old/widgets/common/UploadDocument.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:url_launcher/url_launcher.dart';

Color backgroundColor() => HexColor("#20314E");
Color yellowColor() => HexColor("#F4DE4C");
Color textBoxColor() => HexColor("#949695");

class DocumentDetailsNew extends StatefulWidget {
  @override
  _DocumentDetailsNewState createState() => _DocumentDetailsNewState();
}

var presentAddressProofList = ['Rental Agreement', 'Society Maintenance Bill'];
UploadDocument uploadDocument = new UploadDocument();

class _DocumentDetailsNewState extends State<DocumentDetailsNew> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  var selectedDocument = '';
  String documentName = '';
  String caseID = '';
  List<dynamic> documentMap = [];
  DocumentsScreenArguments arguments;
  Map<String, String> idAndName = new Map<String, String>();
  Map<String, String> idAndPath = new Map<String, String>();
  CallApi callApi = new CallApi();

  // String presentAddressType = "Rental Agreement";

  List<String> dropdownOptions = [];

  String dropdownValue;

  String docDesc = "";

  void getDocumentExplainer() {
    if (documentName.isNotEmpty &&
        documentName.trim() == 'Permanent Address Proof') {
      dropdownValue = "Electricity Bill";
      dropdownOptions = [
        "Electricity Bill",
        "Society/house maintenance bill",
        "Property document",
        "Property Tax receipt",
        "Other"
      ];
      docDesc =
          'Legal address of an individual where she/he is a registered resident with his/her name.';
      // docDesc =
      //     'When your customer declares his/her residential status as "OWNED".\nWe would need a proof of the same (as a document), with name of customer, spouse or parent reflecting on the document, other than KYC.';
    } else if (documentName.isNotEmpty &&
        documentName == 'Present Address Proof') {
      dropdownValue = "Rental/Lease Agreement";
      dropdownOptions = [
        "Rental/Lease Agreement",
        "Employer leased accommodation proof",
        "HRA letter (gov)",
        "Gas Bill",
        "Organization/Institution allotment letter",
        "Other"
      ];
      docDesc = 'Address where you reside now or where you receive mail now.';
      // docDesc =
      //     'When your customer declares his/her residential status as "RENTED", "SHARING", "ACCOMMODATION PROVIDED BY EMPLOYER".\nWe would need a proof of the same (as a document), with name of customer, spouse or parent reflecting on the document, other than KYC.\nIf customer\'s residential status is "OWNED", DO NOT upload any document in this section.';
    } else if (documentName.isNotEmpty &&
        documentName == 'Business Property Address') {
      dropdownValue = "Rental / Lease Agreement";
      dropdownOptions = [
        "Rental / Lease Agreement",
        "Trade License",
        "Business property ownership proof",
        "Electricity Bill",
        "Municipal tax bill",
        "Water bill",
        "Property papers"
      ];
      docDesc =
          'If your customer is RENTING the business property (office,warehouse, shop, factory, store, etc) provide a document proof to reflect the same. (trade license, rental or lease agreement , utility bill)\nIf customer OWNS the business property (office, warehouse, shop, factory, store, etc), provide ownership proof (electricity bill, property papers, municpal tax bill, water bill, any ownership document)\n\nNOTE : if ownership of business property is declared, customer shall get higher loan amount, improves changes of approval and may reduce interest rate.';
    } else if (documentName.isNotEmpty &&
        documentName == 'Business Continuity Proof') {
      dropdownValue = "GST/ VAT/Sales TAX Registration";
      dropdownOptions = [
        "GST/ VAT/Sales TAX Registration",
        "For Private Ltd - MOA/AOA/share holding certificate",
        "For Partnership firm - Partnership deed.",
        "For Sole proprietorship - Registration certificate"
      ];
      docDesc =
          'Documentary proof reflecting continuity of your customer\'s business for more than 3 years.';
    } else if (documentName.isNotEmpty && documentName == 'Income Proof') {
      docDesc =
          'Latest 2 years Financial Documents are requried \nFinancial Documents are ITR, P&L (profit and loss statement), and Balance Sheet audited or certified by CA. \n\n\n(upload all income related document in this section in PDF)';
    } else if (documentName.isNotEmpty &&
        documentName == 'Business Bank Statement') {
      docDesc =
          'Requires latest 6 months banking of Primary Business Account of the customer/company. \n\n(upload all related docs in this section in PDF format)';
    } else if (documentName.isNotEmpty &&
        documentName == 'GST Returns (optional)') {
      docDesc =
          'upload last 2 years GST returns here (if and when required)\n\n(upload all related docs in this section in PDF format)';
    } else if (documentName.isNotEmpty &&
        documentName == 'Highest Degree Qualification Proof') {
      docDesc =
          ' Generally the educational degree that you have been awarded or granted. This means a course that you have successfully completed.';
      // docDesc =
      //     'Upload customer\'s professional proof in this section\n\nFor DOCTOR : requires highest degree qualification certificate proof\n\nFor CA/Cost Accountant/Tax Accountant : Certificate of Practice or Membership certificate';
    } else if (documentName.isNotEmpty && documentName == 'Salary Slip') {
      docDesc =
          'Upload latest 3 months salary slip or salary certificate of the customer\n\n(upload all related docs in this section in PDF format)';
    } else if (documentName.isNotEmpty &&
        documentName == 'Salary Bank Statement') {
      docDesc =
          'Upload latest 3 - 6 months Bank statement reflecting salary statement\n\n(upload all related docs in this section in PDF format)';
    } else if (documentName.isNotEmpty && documentName == 'Form 16') {
      docDesc =
          'Upload Form 16 or Form 26as of the customer for last 2 year in case salary is flexible or above 35,000rs monthly.\n\n(upload all related docs in this section in PDF format)';
    } else if (documentName.isNotEmpty && documentName == 'Official ID Card') {
      docDesc =
          'An official card with your name, date of birth, photograph, or other information on it that proves proof of identity.';
      // docDesc =
      //     'Upload a photo of customer\'s official ID card provided by the employer/company insitition.\n(DO NOT upload business or visiting card of the customer)';
    }
    setState(() {});
  }

  Future<String> uploadDocumentForCase() async {
    File image = File((await FilePicker.platform.pickFiles(type: FileType.any)).files[0].path);
    var res = await uploadDocument.uploadDocumentWithData(
        image, caseID, documentName);
    if (res != null) {
      var uploadedDocument = json.decode(res)["data"];
      idAndName.putIfAbsent(uploadedDocument['id'].toString(),
          () => uploadedDocument['file_name']);
      idAndPath.putIfAbsent(uploadedDocument['id'].toString(),
          () => uploadedDocument['public_path']);
      return uploadedDocument['file_name'];
    }
    return '';
  }

  void deleteDocument(String documentID, int index) async {
    var response = await callApi
        .callDeleteApi(ApiConstants.DOCUMENTS_UPLOAD_API + '/' + documentID);
    if (response == '200') {
      ScaffoldMessenger.of(context)
          .showSnackBar(ShowSnackBar('Document deleted').showSuccess());
      setState(() {
        idAndPath.remove(documentID);
        idAndName.remove(documentID);
        print(idAndPath);
        print(idAndName);
      });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(ShowSnackBar('Unable to delete document').showError());
    }
  }

  postDocument(String filePath) async {
    try {
      String url = ApiConstants.BASE_URL + ApiConstants.DOCUMENTS_UPLOAD_API;
      Map<String, String> requestMap = {
        'attachment': filePath,
        'case_id': caseID,
        'type': documentName
      };
      var reply = await callApi.callPostApi(url, requestMap, flag: 1);
      print('' + reply);
    } catch (e) {
      print("Exception caught calling send otp api $e");
    }
  }

  bool firstTime = true;

  @override
  Widget build(BuildContext context) {
    arguments = ModalRoute.of(context).settings.arguments;
    if (firstTime && arguments != null) {
      firstTime = false;
      documentName = arguments.documentName;
      getDocumentExplainer();
      caseID = arguments.caseID;
      documentMap = arguments.documentsList;
      if (documentMap != null) {
        for (var i = 0; i < documentMap.length; i++) {
          var docDet = documentMap[i];
          if (docDet != null && docDet['document_type'] == documentName) {
            idAndName.putIfAbsent(
                docDet['id'].toString(), () => docDet['name']);
            idAndPath.putIfAbsent(
                docDet['id'].toString(), () => docDet['document_url']);
          }
        }
      }
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: backgroundColor()),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          documentName,
          style: TextStyle(
            fontSize: 16,
            color: backgroundColor(),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Visibility(
              visible: dropdownOptions.length != 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 0,
                      color: Colors.white,
                      // color: Colors.blueGrey[200],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Select a document and upload below',
                          style:
                              TextStyle(color: backgroundColor(), fontSize: 15),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(width: 10.0),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0, 0),
                                  color: Colors.grey,
                                  blurRadius: 3)
                            ]),
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: DropdownButton<String>(
                          elevation: 5,
                          value: dropdownValue,
                          underline: SizedBox.shrink(),
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          items: dropdownOptions
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          hint: Text(
                            "",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          onChanged: (String value) {
                            setState(() {
                              dropdownValue = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Colors.blueGrey[50],
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    docDesc,
                    style: TextStyle(color: Colors.black),
                    textAlign: TextAlign.justify,
                  ),
                  // Column(
                  //   children: [
                  //     Text(
                  //       'Present address proof is required by any lender, to confirm where does the borrower actually lives.\nIf the curretn residential city of the client from where he/she is applying the loan, is same as \'address city\' reflected on the Aadhaar, in such cases, lender only requires present address proof.',
                  //       textAlign: TextAlign.justify,
                  //     ),
                  //     Text(
                  //       '(if above is the scenario with your client. you don\'t need to upload any permanent address proof)',
                  //       textAlign: TextAlign.justify,
                  //       style: TextStyle(
                  //         fontWeight: FontWeight.bold,
                  //         fontStyle: FontStyle.italic,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ),
              ),
            ),
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                color: Colors.blue,
                child: InkWell(
                  onTap: () async {
                    var fileName = await uploadDocumentForCase();
                    if (fileName != '') {
                      setState(() {
                        //postDocument(fileName);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                          ShowSnackBar('Document uploaded').showSuccess());
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          ShowSnackBar('Error uploading document').showError());
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Click Here to upload',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        SizedBox(
                          height: 100,
                          child: Image.asset('assets/file-upload.png'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: idAndPath.length > 0
                  ? ListView.separated(
                      physics: AlwaysScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: idAndPath.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          color: Colors.blue[200],
                          elevation: 8.0,
                          shadowColor: Colors.black,
                          child: InkWell(
                            onTap: () {
                              String key = idAndPath.keys.elementAt(index);
                              var publicPath = idAndPath[key];
                              launch(publicPath);
                            },
                            child: ListTile(
                              title: Text(
                                idAndName[idAndPath.keys.elementAt(index)],
                                style: TextStyle(
                                  color: backgroundColor(),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Container(
                                height: 6,
                                color: backgroundColor(),
                              ),
                              trailing: Container(
                                width: 70,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(
                                    10.0,
                                  ),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    String key =
                                        idAndPath.keys.elementAt(index);
                                    deleteDocument(key, index);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          'Delete',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        Icon(
                                          Icons.delete,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );

                        // Card(
                        //     child: ListTile(
                        //   title: Text(documentsList[index]),
                        //   trailing: IconButton(
                        //     icon: Icon(
                        //       Icons.delete,
                        //       color: Colors.red,
                        //     ),
                        //     onPressed: () {
                        //       String key = idAndPath.keys.elementAt(index);
                        //       deleteDocument(key);
                        //     },
                        //   ),
                        //   onTap: () {
                        //     // View/Download
                        //     String key = idAndPath.keys.elementAt(index);
                        //     var publicPath = idAndPath[key];
                        //     launch(publicPath);
                        //   },
                        // ));
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          SizedBox(
                        height: 10.0,
                      ),
                    )
                  : Center(child: const Text('No items')),
            ),
            SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}
