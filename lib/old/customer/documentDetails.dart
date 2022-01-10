import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:financial_freedom/old/Model/DocumentsScreenArguments.dart';
import 'package:financial_freedom/old/widgets/common/ApiConstants.dart';
import 'package:financial_freedom/old/widgets/common/CallApi.dart';
import 'package:financial_freedom/old/widgets/common/ShowSnackBar.dart';
import 'package:financial_freedom/old/widgets/common/UploadDocument.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DocumentDetails extends StatefulWidget {
  @override
  _DocumentDetailsState createState() => _DocumentDetailsState();
}

var presentAddressProofList = ['Rental Agreement', 'Society Maintenance Bill'];
UploadDocument uploadDocument = new UploadDocument();

class _DocumentDetailsState extends State<DocumentDetails> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  var selectedDocument = '';
  String documentName = '';
  String caseID = '';
  List<String> documentsList = new List<String>();
  List<dynamic> documentMap = new List<dynamic>();
  DocumentsScreenArguments arguments;
  Map<String, String> idAndName = new Map<String, String>();
  Map<String, String> idAndPath = new Map<String, String>();
  CallApi callApi = new CallApi();

  String getDocumentExplainer() {
    log(documentName.toString());
    if (!documentName.isEmpty && documentName == 'Present Address Proof') {
      return 'Present address proof is required by any lender, to confirm where does the borrower actually lives.\nIf the current residential city of the client from where he/she is applying the loan, is same as \'address city\' reflected on the Aadhaar, in such cases, lender only requires present address proof. (if above is the scenario with your client, you don\'t need to upload any permanent address proof)';
    } else if (!documentName.isEmpty &&
        documentName == 'Permanent Address Proof') {
      return 'In case their is any other address on KYC of your client, which is not the present and permanent address. Permanent address proof is a mandatory document.\nPermanent address proof is mandatory if someone does not has an address proof of the city they are residing or, their KYC (aadhaar/DL/PAN) does not have the address where they live currently or permanently.\nIf your client\'s KYC has present or permanent address reflected, permanent address proof is not required.';
    } else if (!documentName.isEmpty &&
        documentName == 'Latest 3 Months Salary Slips') {
      return 'Collect latest 3 month salary slips of the client.\nThe salary slips should reflect:\n - The salary credit period(month), which should be latest,\n - Name of the employer, and\n - The amount of salary credited to your client.\nMake sure your client provides you an original PDF, or upload a scan copy.\nAvoid Uploading a photocopy document.\n(You can upload seperate PDF(doc) for each month salary statement or as one pdf document)';
    } else if (!documentName.isEmpty &&
        documentName == 'Latest 3-6 Months Bank Statements') {
      return 'Latest 3 month bank statement of the client, this account should show the latest salary/income credits.';
    } else if (!documentName.isEmpty && documentName == 'Latest 2 Years ITR') {
      return '2 Years of Financial documents, is a set of,\n - Balance sheet document\n - P&L (profit & Loss Statement) document\n - ITR(Income Tax Return) document\nNote: If turnover is above 1 crore annually,e ach document, and collectively should be audited and signed by CA/CS.\nUpload original PDF or scanned copy, photocopy of the original document will not work.\n(if you have these documents in seperate pdfs, upload multiple files, or otherwise, upload the combined pdf)';
    } else if (!documentName.isEmpty &&
        documentName == 'Professional Qualification Proof') {
      return 'For Doctors:\nHighest degree/diploma/certificate is the recent degreea doctor has achieved. Example, if a doctor is MBBS+MD, MD is the highest degree qualification.\nAny qualification a doctor does, is recognised and register by Medical council of India.\nWe need to collect the same document, which has the doctor\'s certified degree, registration number and date of registration.\nFor CA/CS/cost accountant:\nWe need to collect, The qualification proof of a CA, i.e. the degree/diploma certified by the dedicated council to certify the professional has achieved the qualification. And, COP (certificate of practicing) which proves theprofessional is a practicing CA/CS/cost accountant.';
    }
    return 'Description Here';
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
      scaffoldKey.currentState
          .showSnackBar(ShowSnackBar('Document deleted').showSuccess());
      setState(() {
        documentsList.removeAt(index);
        idAndPath.remove(documentID);
        idAndName.remove(documentID);
        print(idAndPath);
        print(idAndName);
        print(documentsList);
      });
    } else {
      scaffoldKey.currentState
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
      caseID = arguments.caseID;
      documentMap = arguments.documentsList;
      if (documentMap != null) {
        for (var i = 0; i < documentMap.length; i++) {
          var docDet = documentMap[i];
          if (docDet != null && docDet['document_type'] == documentName) {
            documentsList.add(docDet['name']);
            idAndName.putIfAbsent(
                docDet['id'].toString(), () => docDet['name']);
            idAndPath.putIfAbsent(
                docDet['id'].toString(), () => docDet['document_url']);
          }
        }
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(documentName + "111"),
      ),
      key: scaffoldKey,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: ListView(
            children: [
              Visibility(
                visible: documentName == 'Present Address Proof',
                child: Container(
                  margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Card(
                      child: ListTile(
                    subtitle: Text(
                      'Select and upload any of the below document of your client\'s present (current) address proof.',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  )),
                ),
              ),
              Visibility(
                visible: documentName == 'Present Address Proof',
                child: Container(
                  margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    dropdownColor: Colors.indigo.shade50,
                    items: presentAddressProofList
                        .map((label) => DropdownMenuItem(
                              child: Text(
                                label,
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor),
                              ),
                              value: label,
                            ))
                        .toList(),
                    onChanged: (String value) {
                      setState(() {
                        selectedDocument = value;
                      });
                    },
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Card(
                  elevation: 3,
                  child: ListTile(
                    subtitle: Text(
                      getDocumentExplainer(),
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 8,
                    child: Container(
                      height: 50,
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: Builder(
                        builder: (context) => RaisedButton(
                          shape: StadiumBorder(),
                          textColor: Colors.white,
                          color: Theme.of(context).primaryColor,
                          child: Text('Upload Document'),
                          onPressed: () async {
                            var fileName = await uploadDocumentForCase();
                            if (fileName != '') {
                              setState(() {
                                documentsList.add(fileName);
                                //postDocument(fileName);
                              });
                              scaffoldKey.currentState.showSnackBar(
                                  ShowSnackBar('Document uploaded')
                                      .showSuccess());
                            } else {
                              scaffoldKey.currentState.showSnackBar(
                                  ShowSnackBar('Error uploading document')
                                      .showError());
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              documentsList.length > 0
                  ? ListView.separated(
                      physics: AlwaysScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: idAndPath.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                            child: ListTile(
                          title: Text(documentsList[index]),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              String key = idAndPath.keys.elementAt(index);
                              deleteDocument(key, index);
                            },
                          ),
                          onTap: () {
                            // View/Download
                            String key = idAndPath.keys.elementAt(index);
                            var publicPath = idAndPath[key];
                            launch(publicPath);
                          },
                        ));
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(),
                    )
                  : Center(child: const Text('No items')),
            ],
          ),
        ),
      ),
    );
  }
}
