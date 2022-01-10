import 'package:financial_freedom/old/customer/customerDetails.dart';

class DocumentsScreenArguments {
  final String caseID;
  final dynamic customerDetails;
  final String documentName;
  final List<dynamic> documentsList;

  DocumentsScreenArguments(this.caseID,this.customerDetails, this.documentName, this.documentsList);
}
