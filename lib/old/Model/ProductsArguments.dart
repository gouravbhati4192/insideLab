class ProductsArguments {
  final String caseID;
  final String emailID;
  final Map productsMap;
  final bool allowBack;
  final String loanType;

  ProductsArguments(this.caseID, this.productsMap, this.emailID, {this.allowBack = true, this.loanType});
}

class GeneralEnquiryArguments {
  final List productsList;

  GeneralEnquiryArguments(this.productsList);
}
