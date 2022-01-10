import 'package:financial_freedom/new%20ui%20pages/customer.details.screen.dart';
import 'package:financial_freedom/old/Home/home.dart';
import 'package:financial_freedom/old/widgets/common/mycolors.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:simple_html_css/simple_html_css.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductComparativeAnalysis extends StatefulWidget {
  final String type;
  const ProductComparativeAnalysis({this.type});

  @override
  _ProductComparativeAnalysisState createState() =>
      _ProductComparativeAnalysisState();
}

// class _ProductComparativeAnalysisState
//     extends State<ProductComparativeAnalysis> {
//   Widget getHtmlPage() {
//     return Builder(
//       builder: (context) => HTML.toRichText(
//         context,
//         '''
// <h3>Which is a better bank for Home Loan – SBI or Indian Bank?
// </h3>
// <p></p>
// <p>SBI offers lower Home Loan EMI at ₹ 645  on a Home Loan for 30 Years as compared to Indian Bank with a minimum EMI of ₹ 809  for 20 Years. Average customer ratings for SBI is currently at 4.2/5.0 which makes it a good choice for taking a Home Loan.</p>

// <h3>How does  SBI Home Loan compare with Indian Bank Home Loan?
// </h3>
// <p>
// It is important to do a detailed comparison of SBI and  Home Loan on all loan terms and conditions to understand their differences and take an informed decision. Keep in mind that each bank’s scheme has its own pros and cons that have to be evaluated before choosing the best offer. Some of the key results of the comparison between the two banks are:

// </p><ul class="list-icon-more">
// <li>Lowest Interest rate of SBI Home Loan is 6.70%, which is lower than the lowest interest rate of Indian Bank at 7.55%  and hence, SBI is offering a cheaper loan option.</li>
// <li>When compared on other  Home Loan charges such as processing fees, SBI charges a lower processing fees of Nil vs Indian Bank with a processing fees of 0.23%  of loan amount.  </li>
// <li>SBI has a maximum processing fee of ₹ 10,000 compared to Indian Bank with higher processing fees of ₹ 20,381. Hence, customers looking for a higher loan amount will get a benefit on processing fees by opting for SBI.</li>
// <li>Indian Bank is a Public Sector Bank with its Home Loan rates benchmarked to RLLR. SBI is a Public Sector Bank with its home loan rates benchmarked to RLLR. Hence, both banks are benchmarked to same rate which make them a comparable option to choose from.</li>
// <li>SBI has an average customer ratings of 4.2, while Indian Bank has an average customer rating of 3, based on which it is clear that SBI has a high customer service focus, an easy Home Loan process and a quick turnaround.</li>
// <li>All these banks offer discounted schemes for women and hence, this factor will not be important in making the decision to borrow from Indian Bank or SBI.</li>
// <li>One unique feature of SBI is its overdraft facility which allows borrowers to minimize their interest outgo by paying interest only on the loan amount utilized. This scheme makes it an apt choice for self-employed and businessmen with fluctuating fund requirements.</li>
// </ul>
// <p></p>
// <h3>Which bank offers lower interest rate on Home Loan – SBI or Indian Bank?
// </h3>
// <p>As per the current rates, SBI offers a lower interest rate of 6.70% on Home Loan when compared to Indian Bank which offers a Home Loan at 7.55%.</p>
// <h3>Popular Housing Loans Tools</h3>
// <div class="link-row mb-3">
// <ul class="">
//         <li><a href="https://www.myloancare.in/home-loan-interest-rates/">Home Loan Interest Rates</a></li>
//         <li><a href="https://www.myloancare.in/home-loan-emi-calculator/">Home Loan EMI Calculator</a></li>
//         <li><a href="https://www.myloancare.in/home-loan-eligibility-calculator/">Home Loan Eligibility Calculator</a></li>
//         <li><a href="https://www.myloancare.in/home-loan/balance-transfer/">Home Loan Balance Transfer</a></li>
//     </ul>
// </div>

// <h3>Popular Search for SBI Home Loan</h3>
// <div class="link-row mb-3">
// <ul class="">
//         <li><a href="https://www.myloancare.in/home-loan-interest-rates/sbi">SBI Home Loan Rates</a></li>
//         <li><a href="https://www.myloancare.in/home-loan-eligibility-calculator/sbi">SBI Home Loan Eligibility</a></li>
//         <li><a href="https://www.myloancare.in/home-loan-emi-calculator/sbi">SBI Home Loan Calculator</a></li>
//         <li><a href="https://www.myloancare.in/home-loan/sbi-statement">SBI Home Loan Statement</a></li>
//         <li><a href="https://www.myloancare.in/loan-for-land-purchase/sbi">SBI Plot Loan</a></li>
//             </ul>
// </div>

// <h3>Popular Search for Indian Bank Home Loan</h3>
// <div class="link-row mb-3">
// <ul class="">
//         <li><a href="https://www.myloancare.in/home-loan-interest-rates/indian-bank">Indian Bank Home Loan Rates</a></li>
//         <li><a href="https://www.myloancare.in/home-loan-eligibility-calculator/indian-bank">Indian Bank Home Loan Eligibility</a></li>
//         <li><a href="https://www.myloancare.in/home-loan-emi-calculator/indian-bank">Indian Bank Home Loan Calculator</a></li>
//         <li><a href="https://www.myloancare.in/home-loan/indian-bank-statement">Indian Bank Home Loan Statement</a></li>
//             </ul>
// </div>

// <h3>Compare SBI Home Loan With Other Banks</h3>
// <div class="link-row mb-3">
//     <ul class="">
//         <li><a href="https://www.myloancare.in/home-loan/compare-sbi-vs-bank-of-baroda">SBI Vs BOB Home Loan</a></li>        <li><a href="https://www.myloancare.in/home-loan/compare-sbi-vs-citibank">SBI Vs Citibank Home Loan</a></li>        <li><a href="https://www.myloancare.in/home-loan/compare-sbi-vs-icici-bank">SBI Vs  ICICI Home Loan</a></li>         <li><a href="https://www.myloancare.in/home-loan/compare-sbi-vs-axis-bank">SBI Vs Axis Bank Home Loan</a></li>        <li><a href="https://www.myloancare.in/home-loan/compare-sbi-vs-pnb-housing-finance">SBI Vs PNB Home Loan</a></li>    </ul>
// </div>

// <h3>Compare Indian Bank Home Loan With Other Banks</h3>
// <div class="link-row mb-3">
//     <ul class="">
//         <li><a href="https://www.myloancare.in/home-loan/compare-indian-bank-vs-bank-of-baroda">Indian Bank Vs BOB Home Loan</a></li>        <li><a href="https://www.myloancare.in/home-loan/compare-indian-bank-vs-citibank">Indian Bank Vs Citibank Home Loan</a></li>        <li><a href="https://www.myloancare.in/home-loan/compare-indian-bank-vs-icici-bank">Indian Bank Vs  ICICI Home Loan</a></li>         <li><a href="https://www.myloancare.in/home-loan/compare-indian-bank-vs-axis-bank">Indian Bank Vs Axis Bank Home Loan</a></li>        <li><a href="https://www.myloancare.in/home-loan/compare-indian-bank-vs-pnb-housing-finance">Indian Bank Vs PNB Home Loan</a></li>    </ul>
// </div>
// <h3>Check Pradhan Mantri Awas Yojana Scheme</h3>
// <div class="link-row mb-3">
// <ul class="">
//         <li><a href="https://www.myloancare.in/home-loan/pradhan-mantri-awas-yojana-pmay/">PMAY Scheme</a></li>
//         <li><a href="https://www.myloancare.in/home-loan/pradhan-mantri-awas-yojana-eligibility/">PMAY Eligibility</a></li>
//         <li><a href="https://www.myloancare.in/home-loan/pradhan-mantri-awas-yojana-list/">PMAY List</a></li>
//         <li><a href="https://www.myloancare.in/home-loan/pmay-application-form-online/">PMAY Application Form</a></li>
//         <li><a href="https://www.myloancare.in/home-loan/pmay-application-status-check/">PMAY Application Status</a></li>
//         <li><a href="https://www.myloancare.in/home-loan/pradhan-mantri-awas-yojana-gramin/">PMAY Gramin</a></li>
//         <li><a href="https://www.myloancare.in/home-loan/indira-gandhi-awas-yojana-iay/">Indira Gandhi Awas Yojana</a></li>
//     </ul>
// </div>
//                             ''',
//         linksCallback: (link) async {
//           await launch(link);
//         },
//         // defaultTextStyle: TextStyle(
//         //   fontSize: 16,
//         // ),
//         overrideStyle: {
//           "h3": TextStyle(
//             color: Colors.orange[900],
//             fontWeight: FontWeight.bold,
//           ),
//           // "p": TextStyle(color: Colors.white),
//           // "ul": TextStyle(color: Colors.white),
//           // "li": TextStyle(color: Colors.white),
//           // specify any tag not just the supported ones,
//           // and apply TextStyles to them and/override them
//         },
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: MyColors.backgroundColor(),
//       appBar: AppBar(
//         backgroundColor: MyColors.yellowColor(),
//         elevation: 10.0,
//         title: Text(
//           "Product Comparative Analysis",
//           style: TextStyle(
//             color: Colors.black,
//           ),
//         ),
//       ),
//       body: Container(
//         height: 1000,
//         decoration: BoxDecoration(
//           color: Colors.blueGrey[100],
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: SingleChildScrollView(child: getHtmlPage()
// //             Text(
// //               """Which is a better bank for Home Loan – SBI or Indian Bank?

// // SBI offers lower Home Loan EMI at ₹ 645 on a Home Loan for 30 Years as compared to Indian Bank with a minimum EMI of ₹ 809 for 20 Years. Average customer ratings for SBI is currently at 4.2/5.0 which makes it a good choice for taking a Home Loan.
// // How does SBI Home Loan compare with Indian Bank Home Loan?

// // It is important to do a detailed comparison of SBI and Home Loan on all loan terms and conditions to understand their differences and take an informed decision. Keep in mind that each bank’s scheme has its own pros and cons that have to be evaluated before choosing the best offer. Some of the key results of the comparison between the two banks are:

// //     Lowest Interest rate of SBI Home Loan is 6.70%, which is lower than the lowest interest rate of Indian Bank at 7.55% and hence, SBI is offering a cheaper loan option.
// //     When compared on other Home Loan charges such as processing fees, SBI charges a lower processing fees of Nil vs Indian Bank with a processing fees of 0.23% of loan amount.
// //     SBI has a maximum processing fee of ₹ 10,000 compared to Indian Bank with higher processing fees of ₹ 20,381. Hence, customers looking for a higher loan amount will get a benefit on processing fees by opting for SBI.
// //     Indian Bank is a Public Sector Bank with its Home Loan rates benchmarked to RLLR. SBI is a Public Sector Bank with its home loan rates benchmarked to RLLR. Hence, both banks are benchmarked to same rate which make them a comparable option to choose from.
// //     SBI has an average customer ratings of 4.2, while Indian Bank has an average customer rating of 3, based on which it is clear that SBI has a high customer service focus, an easy Home Loan process and a quick turnaround.
// //     All these banks offer discounted schemes for women and hence, this factor will not be important in making the decision to borrow from Indian Bank or SBI.
// //     One unique feature of SBI is its overdraft facility which allows borrowers to minimize their interest outgo by paying interest only on the loan amount utilized. This scheme makes it an apt choice for self-employed and businessmen with fluctuating fund requirements.

// // Which bank offers lower interest rate on Home Loan – SBI or Indian Bank?

// // As per the current rates, SBI offers a lower interest rate of 6.70% on Home Loan when compared to Indian Bank which offers a Home Loan at 7.55%.""",
// //               style: TextStyle(
// //                 color: Colors.black,
// //               ),
// //             ),
//               ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           var message =
//               'Hey! An agent has shared with you a list of Financial products from Insider Lab App\nhttps://www.insiderlab.in/products/';
//           /*+widget.screenArgs.caseID;*/
//           var url = "whatsapp://send?text=" + message;

//           launch(url);
//         },
//         hoverColor: Theme.of(context).primaryColor,
//         child: Icon(Icons.share),
//         foregroundColor: MyColors.darkBlue,
//         backgroundColor: Colors.indigo.shade50,
//       ),
//     );
//   }
// }

class _ProductComparativeAnalysisState
    extends State<ProductComparativeAnalysis> {
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: yellowColor()),
        title: Text(
          'Product Comparative Analysis',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline6.merge(
                TextStyle(
                  fontSize: 16,
                  color: yellowColor(),
                ),
              ),
        ),
      ),
      body: LoadingOverlay(
        isLoading: _isLoading,
        child: Center(
          child: SfPdfViewer.network(
            widget.type == "Personal Loan"
                ? 'https://www.insiderlab.in/pro-comp/Personal%20Loan.pdf'
                : (widget.type == "Professional Loan"
                    ? 'https://www.insiderlab.in/pro-comp/Professional%20Loan.pdf'
                    : 'https://www.insiderlab.in/pro-comp/Business%20Loan.pdf'),
            onDocumentLoaded: (data) {
              setState(() {
                _isLoading = false;
              });
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var message =
              'Hey! , ${HomeState.agentName.value} - Financial Therapist, has shared with you a list of Loan products from Insider Lab App\n${Uri.encodeComponent(widget.type == "Personal Loan" ? 'https://www.insiderlab.in/pro-comp/Personal%20Loan.pdf' : (widget.type == "Professional Loan" ? 'https://www.insiderlab.in/pro-comp/Professional%20Loan.pdf' : 'https://www.insiderlab.in/pro-comp/Business%20Loan.pdf'))}';
          /*+widget.screenArgs.caseID;*/
          var url = "whatsapp://send?text=" + message;

          launch(url);
        },
        hoverColor: Theme.of(context).primaryColor,
        child: Icon(Icons.share),
        foregroundColor: MyColors.yellowColor(),
        backgroundColor: MyColors.darkBlue,
      ),
    );
  }
}
