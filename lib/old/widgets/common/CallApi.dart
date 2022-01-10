import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:financial_freedom/old/widgets/common/ApiConstants.dart';
import 'package:financial_freedom/old/widgets/common/SharedPref.dart';

class CallApi {
  SharedPref _pref = new SharedPref();

  Future<String> callPostApi(String url, Map jsonMap, {flag: int}) async {
    HttpClient httpClient = new HttpClient();
    var reply;

    try {
      HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
      request.headers.set(ApiConstants.HEADER_CONTENT_TYPE, 'application/json');
      request.headers.set(ApiConstants.HEADER_VERIFY, 'banana');

      if (flag == 1) {
        var token = await _pref.getToken();
        request.headers.set(ApiConstants.HEADER_AUTHORIZATION, 'Bearer $token');
      }
      request.add(utf8.encode(json.encode(jsonMap)));
      HttpClientResponse response = await request.close();
      print('Response :  ${response.statusCode} , ${response.reasonPhrase}');

      switch (response.statusCode) {
        case 200:
          reply = await response.transform(utf8.decoder).join();
          print("Result json : $reply");
          break;

        case 201:
          reply = await response.transform(utf8.decoder).join();
          print("Result 201 : $reply");
          break;

        case 400:
          reply = await response.transform(utf8.decoder).join();
          print("Result 400 : $reply");
          break;

        case 401:
          reply = await response.transform(utf8.decoder).join();
          print("Result 401 : $reply");
          break;

        case 405:
          reply = await response.transform(utf8.decoder).join();
          print("Result 405 : $reply");
          break;

        case 500:
          reply = await response.transform(utf8.decoder).join();
          print("Result 500 : $reply");
          break;

        default:
          print("Something went wrong.!");
          reply = 'Something went wrong.!';
      }

      httpClient.close();
      return reply;
    } catch (e) {
      print("Exception Caught: $e");
      return null;
    }
  }

  Future<String> callGetApi(String appendUrl, bool isTokenRequired) async {
    String _respJson, _token;
    String url = ApiConstants.BASE_URL + appendUrl;
    HttpClient httpClient = new HttpClient();
    HttpClientResponse _response;
    HttpClientRequest _request = await httpClient.getUrl(Uri.parse(url));
    _request.headers.set(ApiConstants.HEADER_CONTENT_TYPE, 'application/json');
    _request.headers.set(ApiConstants.HEADER_VERIFY, 'banana');
    if (isTokenRequired) {
      _token = await _pref.getToken();
      _request.headers.set(ApiConstants.HEADER_AUTHORIZATION, 'Bearer $_token');
      _response = await _request.close();
    } else {
      _response = await _request.close();
    }
    if (_response.statusCode == 200) {
      _respJson = await _response.transform(utf8.decoder).join();
      // log("get api /$appendUrl Response  : $_respJson");
    } else {}
    httpClient.close();
    return _respJson;
  }

  Future<String> callProductAnalysis(String caseID) async {
//     return '''

// {
//    "error": 0,
//    "message": "Successfully retrieved data",
//    "show_message": true,
//    "data": {
//       "1": {
//          "product_name": "IDFC Professional Loan",
//          "emi": 315.75522,
//          "ui_listing": {
//             "page1": "<p style="text-align: center;"><strong>IDFC Bank Main Features<\/strong><\/p><p style=\"text-align: left;\"><br>Your Desired Loan Amount 30000<br>IDFC can provide a Maximum Loan of 30000<br><br></p><p>You personalised interest for this product will be around 12.5% Interest Rate<\/p><p><br>Tenure for this product 0<\/p><p>Your monthly EMI - 315.75520833333<\/p><p>Why you should choose IDFC::<\/p><ul><li>Fast online approval with high sanction amount and flexible tenure upto 5 years<\/li><li>Preapproved Program upto 40 lacs<\/li><li>Easy to meet loan eligibility requirements<\/li><li>Customised offers to match CIBIL score<\/li><li>Flexibility to make up to 40%* part payment(Part-prepay your loan whenever you have surplus funds)<\/li><li>Transfer existing personal loan to enjoy benefits<\/li><\/ul><p>*Terms and conditions apply.<\/p><p>&nbsp;<\/p>",
//             "page2": "<p style="text-align: center;"><strong>IDFC Bank Eligibility Criteria<\/strong><\/p><p style=\"text-align: left;\"><br><strong>Processing fee</strong> for this product 3.5% of Receivable/Desired Loan 3</p><p><strong>Insurance charges<\/strong> Are not mandatory they are as per requirement<br><br><\/p><p><strong>Prepayment Charges&nbsp;<\/strong>Maximum 40% of current Principal outstanding is allowed for part payment with charge of 2%<\/p><p><strong>Foreclosure Charges<\/strong> -5% of the outstanding principal Loan Amount<\/p><p>On assumption that you pay 2.5lakh @ 24th month of your tenure<br>Charges levied for part payment will be around - Rs13000<\/p><p><strong>Foreclosure Charges<\/strong> - 5% of the outstanding principal Loan Amount<br>On assumption that you go for the foreclosure after 3Years(@37th month) which will be of Prinicipal Amount around Rs48000<br>Levied charges - Rs24000<\/p><p><strong>Bounce Charges<\/strong>- Rs400<br>A fee that borrower has to pay if they bounces a EMI payment<\/p><p><strong>AMC<\/strong> - 0% <br>AMC is Annual/Additional Maintenance Charges</p><p>&nbsp;</p>",
//             "page3": "<p style="text-align: center;"><strong>Document Required and External Resources<br><br><\/strong><\/p><p>IDFC Product Link :: https://www.idfcfirstbank.com/banking-products/loans/business-loans.html<\/p><p>EMI Calculator Link :: https://www.idfcbank.com/home-loan-calculators/emi-calculator-hl.html<\/p><p style=\"text-align: left;\">KYC Documents - Pan card/Aadhaar card<br>Medical Registration Certificate<br>Bank Statement(Required in case of BDS/BAMS/BHMS/DHMS)<br><br><\/p><p>Customer issue not Resolved then escalate to - <a href=\"mailto:admin@insiderlab.in\">admin@insiderlab.in<\/a><br><a href=\"mailto:escalate@insiderlab.in\">escalate@insiderlab.in<\/a><br><br>Customer Care Mail Id - <a href=\"mailto:head.customerservice@idfcfirstbank.com\">head.customerservice@idfcfirstbank.com<\/a><\/p><p>Customer Care No. - 18605009900<\/p>"
//          },
//          "page_setup": {
//             "page1": "<p style=\"text-align: center;\"><strong>IDFC Bank Main Features<\/strong><\/p><p style=\"text-align: left;\"><br>Your Desired Loan Amount 30000<br>IDFC can provide a Maximum Loan of 30000<br><br><\/p><p>You personalised interest for this product will be around 12.5% Interest Rate<\/p><p><br>Tenure for this product 0<\/p><p>Your monthly EMI - 315.75520833333<\/p><p>Why you should choose IDFC::<\/p><ul><li>Fast online approval with high sanction amount and flexible tenure upto 5 years<\/li><li>Preapproved Program upto 40 lacs<\/li><li>Easy to meet loan eligibility requirements<\/li><li>Customised offers to match CIBIL score<\/li><li>Flexibility to make up to 40%* part payment(Part-prepay your loan whenever you have surplus funds)<\/li><li>Transfer existing personal loan to enjoy benefits<\/li><\/ul><p>*Terms and conditions apply.<\/p><p>&nbsp;<\/p>",
//             "page2": "<p style=\"text-align: center;\"><strong>IDFC Bank Eligibility Criteria<\/strong><\/p><p style=\"text-align: left;\"><br><strong>Processing fee<\/strong> for this product 3.5% of Receivable/Desired Loan 3<\/p><p><strong>Insurance charges<\/strong> Are not mandatory they are as per requirement<br><br><\/p><p><strong>Prepayment Charges&nbsp;<\/strong>Maximum 40% of current Principal outstanding is allowed for part payment with charge of 2%<\/p><p><strong>Foreclosure Charges<\/strong> -5% of the outstanding principal Loan Amount<\/p><p>On assumption that you pay 2.5lakh @ 24th month of your tenure<br>Charges levied for part payment will be around - Rs13000<\/p><p><strong>Foreclosure Charges<\/strong> - 5% of the outstanding principal Loan Amount<br>On assumption that you go for the foreclosure after 3Years(@37th month) which will be of Prinicipal Amount around Rs48000<br>Levied charges - Rs24000<\/p><p><strong>Bounce Charges<\/strong>- Rs400<br>A fee that borrower has to pay if they bounces a EMI payment<\/p><p><strong>AMC<\/strong> - 0% <br>AMC is Annual/Additional Maintenance Charges<\/p><p>&nbsp;<\/p>",
//             "page3": "<p style=\"text-align: center;\"><strong>Document Required and External Resources<br><br><\/strong><\/p><p>IDFC Product Link :: https://www.idfcfirstbank.com/banking-products/loans/business-loans.html<\/p><p>EMI Calculator Link :: https://www.idfcbank.com/home-loan-calculators/emi-calculator-hl.html<\/p><p style=\"text-align: left;\">KYC Documents - Pan card/Aadhaar card<br>Medical Registration Certificate<br>Bank Statement(Required in case of BDS/BAMS/BHMS/DHMS)<br><br><\/p><p>Customer issue not Resolved then escalate to - <a href=\"mailto:admin@insiderlab.in\">admin@insiderlab.in<\/a><br><a href=\"mailto:escalate@insiderlab.in\">escalate@insiderlab.in<\/a><br><br>Customer Care Mail Id - <a href=\"mailto:head.customerservice@idfcfirstbank.com\">head.customerservice@idfcfirstbank.com<\/a><\/p><p>Customer Care No. - 18605009900<\/p>"
//          }
//       },
//       "2": {
//          "product_name": "Bajaj Finserve Professional Loan",
//          "emi": 315.75522,
//          "ui_listing": {
//             "page1": "<p style=\"text-align: center;\"><strong>Bajaj Finance ltd Main Features<\/strong><\/p><p style=\"text-align: left;\"><br>Your Desired Loan Amount 30000<br>Bajaj Can provide a Maximum Loan of 30000<br><br><\/p><p>You personalised interest for this product will be around 12.5% Interest Rate<br>Your awarded Interest Rate range will be 14%-16%<\/p><p>Tenure for this product 0<\/p><p>Your monthly EMI - 315.75520833333<\/p><p>Why you should choose Bajaj::<\/p><ul><li>Preapproved offer on the basis of Degree upto 37 Lakhs without any financial documents.(on the basis of KYC and Registration certificate)<\/li><li>Disbursal from bank within 24 hours<\/li><li>Product provides Flexibility of Unsecured Overdraft Limit.(In a personal overdraft, the customer is permitted to withdraw funds as well as repay them at his/her convenience and you only need to pay interest on the amount that stays overdue)<\/li><li>0% Part Prepayment Chagres for flexi loan product(Part-prepay your loan whenever you have surplus funds, without any extra charge)<\/li><li>BFS provides Flexi loans where you get greater flexibility and convenience and can also reduce your EMIs by up to 45%*<br>Borrow money as and when you need from your sanction, without the need for multiple applications and additional documentation.<\/li><\/ul><p>*Terms and conditions apply.<\/p><p>&nbsp;<\/p>",
//             "page2": "<p style=\"text-align: center;\"><strong>Bajaj Finance Eligibility Criteria<\/strong><\/p><p style=\"text-align: left;\"><br><strong>Processing fee<\/strong> for this product 2% of Receivable/Desired Loan 2<\/p><p><strong>Insurance charges<\/strong> 0-2% of Desired/Receivable loan Amount will be 0-2<br><br><\/p><p><strong>Prepayment Charges<\/strong> - 2% of the part payment amount paid<\/p><p>Borrowers age should be between 23yrs-70yrs<\/p><p><br><strong>Foreclosure Charges<\/strong> - 4% of the Remaining Principal Amount<\/p><p><strong>Bounce Charges<\/strong>- Rs3000<br>A fee that borrower has to pay if they bounces a EMI payment<\/p><p><strong>AMC<\/strong> - 0.5% of the Loan Amount on withdrawable limit for initial tenure, after that 0.25% for the subsequent period<br>AMC is Annual/Additional Maintenance Charges<\/p><p>&nbsp;<\/p>",
//             "page3": "<p style=\"text-align: center;\"><strong>Document Required and External Resources<\/strong><\/p><p style=\"text-align: left;\"><br>Bajaj Product Link :: https://www.bajajfinserv.in/professional-loan<\/p><p style=\"text-align: left;\">EMI Calculator Link :: https://www.bajajfinservmarkets.in/loans/markets-icash/emi-calculator.html<\/p><p style=\"text-align: left;\">KYC Documents - Pan card/Aadhaar card<br>Medical Registration Certificate<br>Bank Statement(Required in case of BDS/BAMS/BHMS/DHMS)<br><br><\/p><p>Customer issue not Resolved then escalate to - <a href=\"mailto:admin@insiderlab.in\">admin@insiderlab.in<\/a><br><a href=\"mailto:escalate@insiderlab.in\">escalate@insiderlab.in<\/a><br><br>Customer Care Mail Id - <a href=\"mailto:wecare@bajajfinserv.in\">wecare@bajajfinserv.in <\/a><\/p><p>Customer Care No.- +91 8698010101<\/p>"
//          },
//          "page_setup": {
//             "page1": "<p style=\"text-align: center;\"><strong>Bajaj Finance ltd Main Features<\/strong><\/p><p style=\"text-align: left;\"><br>Your Desired Loan Amount 30000<br>Bajaj Can provide a Maximum Loan of 30000<br><br><\/p><p>You personalised interest for this product will be around 12.5% Interest Rate<br>Your awarded Interest Rate range will be 14%-16%<\/p><p>Tenure for this product 0<\/p><p>Your monthly EMI - 315.75520833333<\/p><p>Why you should choose Bajaj::<\/p><ul><li>Preapproved offer on the basis of Degree upto 37 Lakhs without any financial documents.(on the basis of KYC and Registration certificate)<\/li><li>Disbursal from bank within 24 hours<\/li><li>Product provides Flexibility of Unsecured Overdraft Limit.(In a personal overdraft, the customer is permitted to withdraw funds as well as repay them at his/her convenience and you only need to pay interest on the amount that stays overdue)<\/li><li>0% Part Prepayment Chagres for flexi loan product(Part-prepay your loan whenever you have surplus funds, without any extra charge)<\/li><li>BFS provides Flexi loans where you get greater flexibility and convenience and can also reduce your EMIs by up to 45%*<br>Borrow money as and when you need from your sanction, without the need for multiple applications and additional documentation.<\/li><\/ul><p>*Terms and conditions apply.<\/p><p>&nbsp;<\/p>",
//             "page2": "<p style=\"text-align: center;\"><strong>Bajaj Finance Eligibility Criteria<\/strong><\/p><p style=\"text-align: left;\"><br><strong>Processing fee<\/strong> for this product 2% of Receivable/Desired Loan 2<\/p><p><strong>Insurance charges<\/strong> 0-2% of Desired/Receivable loan Amount will be 0-2<br><br><\/p><p><strong>Prepayment Charges<\/strong> - 2% of the part payment amount paid<\/p><p>Borrowers age should be between 23yrs-70yrs<\/p><p><br><strong>Foreclosure Charges<\/strong> - 4% of the Remaining Principal Amount<\/p><p><strong>Bounce Charges<\/strong>- Rs3000<br>A fee that borrower has to pay if they bounces a EMI payment<\/p><p><strong>AMC<\/strong> - 0.5% of the Loan Amount on withdrawable limit for initial tenure, after that 0.25% for the subsequent period<br>AMC is Annual/Additional Maintenance Charges<\/p><p>&nbsp;<\/p>",
//             "page3": "<p style=\"text-align: center;\"><strong>Document Required and External Resources<\/strong><\/p><p style=\"text-align: left;\"><br>Bajaj Product Link :: https://www.bajajfinserv.in/professional-loan<\/p><p style=\"text-align: left;\">EMI Calculator Link :: https://www.bajajfinservmarkets.in/loans/markets-icash/emi-calculator.html<\/p><p style=\"text-align: left;\">KYC Documents - Pan card/Aadhaar card<br>Medical Registration Certificate<br>Bank Statement(Required in case of BDS/BAMS/BHMS/DHMS)<br><br><\/p><p>Customer issue not Resolved then escalate to - <a href=\"mailto:admin@insiderlab.in\">admin@insiderlab.in<\/a><br><a href=\"mailto:escalate@insiderlab.in\">escalate@insiderlab.in<\/a><br><br>Customer Care Mail Id - <a href=\"mailto:wecare@bajajfinserv.in\">wecare@bajajfinserv.in <\/a><\/p><p>Customer Care No.- +91 8698010101<\/p>"
//          }
//       },
//       "3": {
//          "product_name": "HDFC Professional Loan",
//          "emi": 280.06686,
//          "ui_listing": {
//             "page1": "<p style=\"text-align: center;\"><strong>HDFC Bank Main Features<\/strong><\/p><p style=\"text-align: left;\"><br>Your Desired Loan Amount 30000<br>HDFC can provide a Maximum Loan of 30000<br><br><\/p><p>You personalised interest for this product will be around 11.1% Interest Rate<br>Your awarded Interest Rate range will be 11.1<\/p><p>Tenure for this product 0<\/p><p>Your monthly EMI - 280.066875<\/p><p>Why you should choose HDFC::<\/p><ul><li>Fastest Loan approval with zero hidden charges<\/li><li>Disbursal from bank within 24 hours<\/li><li>Get pocket-friendly EMI repayment options<\/li><li>Enjoy minimal and simple documentation and quick disbursal<\/li><li>Location Serviceable highest in the industry of private banks<\/li><\/ul><p>*Terms and conditions apply.<\/p><p>&nbsp;<\/p>",
//             "page2": "<p style=\"text-align: center;\"><strong>HDFC Eligibility Criteria<\/strong><\/p><p style=\"text-align: left;\"><br><strong>Processing fee<\/strong> for this product 2.5% of Receivable/Desired Loan 2.5<\/p><p><strong>Insurance charges<\/strong> Are not mandatory they are as per requirement<br><br><\/p><p><strong>Prepayment Charges<br><\/strong>0-12 Months - Not Allowed<br>13-24 Months - 4% of Principal Outstanding<br>25-36 Months - 3% of Principal Outstanding<br>&gt;36 Months - 2% of principal outstanding<\/p><p><strong>Foreclosure Charges<\/strong> -2%-4% of the loan Amount allowed only after 12 months<\/p><p><strong>Bounce Charges<\/strong>- Rs550<br>A fee that borrower has to pay if they bounces a EMI payment<\/p><p><strong>AMC<\/strong> - 0% <br>AMC is Annual/Additional Maintenance Charges<\/p><p>&nbsp;<\/p>",
//             "page3": "<p style=\"text-align: center;\"><strong>Document Required and External Resources<\/strong><\/p><p style=\"text-align: left;\">HDFC <span style=\"font-weight: 400;\">Product Link<\/span> :: <a href=\"https://www.hdfcbank.com/personal/borrow/other-loans/loan-for-professionals\">https://www.hdfcbank.com/personal/borrow/other-loans/loan-for-professionals<\/a><br><br><span style=\"font-weight: 400;\">EMI Calculator Link ::<\/span> <a href=\"https://www.hdfcbank.com/personal/tools-and-calculators/loans-for-professionals\">https://www.hdfcbank.com/personal/tools-and-calculators/loans-for-professionals<\/a><\/p><p style=\"text-align: left;\">KYC Documents - Pan Card/Aadhaar Card<br>Medical Registration Certification/Certificate of Practice<br><br>Bank Statement(Latest 3 months)<br>Latest ITR along with computation of income, Balance Sheet and Profit &amp; Loss Account for the last 2 years. Financial should be certified or audited by a CA<\/p><p>Customer issue not Resolved then escalate to - <a href=\"mailto:admin@insiderlab.in\">admin@insiderlab.in<\/a><br><a href=\"mailto:escalate@insiderlab.in\">escalate@insiderlab.in<\/a><br><br>Customer Care Mail Id- <a href=\"mailto:loansupport@hdfcbank.com\"><span style=\"text-decoration: underline;\">loansupport@hdfcbank.com<\/span><\/a><\/p><p>Customer Care No.-STD Code-61606161, 6160616<\/p><p>&nbsp;<\/p>"
//          },
//          "page_setup": {
//             "page1": "<p style=\"text-align: center;\"><strong>HDFC Bank Main Features<\/strong><\/p><p style=\"text-align: left;\"><br>Your Desired Loan Amount 30000<br>HDFC can provide a Maximum Loan of 30000<br><br><\/p><p>You personalised interest for this product will be around 11.1% Interest Rate<br>Your awarded Interest Rate range will be 11.1<\/p><p>Tenure for this product 0<\/p><p>Your monthly EMI - 280.066875<\/p><p>Why you should choose HDFC::<\/p><ul><li>Fastest Loan approval with zero hidden charges<\/li><li>Disbursal from bank within 24 hours<\/li><li>Get pocket-friendly EMI repayment options<\/li><li>Enjoy minimal and simple documentation and quick disbursal<\/li><li>Location Serviceable highest in the industry of private banks<\/li><\/ul><p>*Terms and conditions apply.<\/p><p>&nbsp;<\/p>",
//             "page2": "<p style=\"text-align: center;\"><strong>HDFC Eligibility Criteria<\/strong><\/p><p style=\"text-align: left;\"><br><strong>Processing fee<\/strong> for this product 2.5% of Receivable/Desired Loan 2.5<\/p><p><strong>Insurance charges<\/strong> Are not mandatory they are as per requirement<br><br><\/p><p><strong>Prepayment Charges<br><\/strong>0-12 Months - Not Allowed<br>13-24 Months - 4% of Principal Outstanding<br>25-36 Months - 3% of Principal Outstanding<br>&gt;36 Months - 2% of principal outstanding<\/p><p><strong>Foreclosure Charges<\/strong> -2%-4% of the loan Amount allowed only after 12 months<\/p><p><strong>Bounce Charges<\/strong>- Rs550<br>A fee that borrower has to pay if they bounces a EMI payment<\/p><p><strong>AMC<\/strong> - 0% <br>AMC is Annual/Additional Maintenance Charges<\/p><p>&nbsp;<\/p>",
//             "page3": "<p style=\"text-align: center;\"><strong>Document Required and External Resources<\/strong><\/p><p style=\"text-align: left;\">HDFC <span style=\"font-weight: 400;\">Product Link<\/span> :: <a href=\"https://www.hdfcbank.com/personal/borrow/other-loans/loan-for-professionals\">https://www.hdfcbank.com/personal/borrow/other-loans/loan-for-professionals<\/a><br><br><span style=\"font-weight: 400;\">EMI Calculator Link ::<\/span> <a href=\"https://www.hdfcbank.com/personal/tools-and-calculators/loans-for-professionals\">https://www.hdfcbank.com/personal/tools-and-calculators/loans-for-professionals<\/a><\/p><p style=\"text-align: left;\">KYC Documents - Pan Card/Aadhaar Card<br>Medical Registration Certification/Certificate of Practice<br><br>Bank Statement(Latest 3 months)<br>Latest ITR along with computation of income, Balance Sheet and Profit &amp; Loss Account for the last 2 years. Financial should be certified or audited by a CA<\/p><p>Customer issue not Resolved then escalate to - <a href=\"mailto:admin@insiderlab.in\">admin@insiderlab.in<\/a><br><a href=\"mailto:escalate@insiderlab.in\">escalate@insiderlab.in<\/a><br><br>Customer Care Mail Id- <a href=\"mailto:loansupport@hdfcbank.com\"><span style=\"text-decoration: underline;\">loansupport@hdfcbank.com<\/span><\/a><\/p><p>Customer Care No.-STD Code-61606161, 6160616<\/p><p>&nbsp;<\/p>"
//          }
//       },
//       "4": {
//          "product_name": "ICICI Bank Professional Loan",
//          "emi": 328.52084,
//          "ui_listing": {
//             "page1": "<p style=\"text-align: center;\"><strong>ICICI Bank Main Features<\/strong><\/p><p style=\"text-align: left;\"><br>Your Desired Loan Amount 30000<br>ICICI can provide a Maximum Loan of 30000<br><br><\/p><p>You personalised interest for this product will be around 13% Interest Rate<br>Your awarded Interest Rate range will be 10.99%-15%<\/p><p>Tenure for this product 0<\/p><p>Your monthly EMI - 328.52083333333<\/p><p>Why you should choose ICICI::<\/p><ul><li>Faster processing and Best after sales service and support<\/li><li>Attractive Interest Rates and flexible repayment option<\/li><li>Get pocket-friendly EMI repayment options<\/li><li>No security/collateral required<\/li><\/ul><p>*Terms and conditions apply.<\/p><p>&nbsp;<\/p>",
//             "page2": "<p style=\"text-align: center;\"><strong>ICICI Bank Eligibility Criteria<\/strong><\/p><p style=\"text-align: left;\"><br><strong>Processing fee<\/strong> for this product 2.25% of Receivable/Desired Loan 2.5<\/p><p><strong>Insurance charges<\/strong> Are not mandatory they are as per requirement<br><br><\/p><p><strong>Prepayment Charges <\/strong>5% of the outstanding Loan Amount<\/p><p>When you pay a certain amount(Not equivalent to your loan amount) back to lender which brings down the principal amount unpaid, which in turn brings down your EMIs and the total interest you pay.<\/p><p><strong>Foreclosure Charges<\/strong> -5% of the outstanding Loan Amount<br>It is a fee or charge that you have to pay to the Lender if you decide to repay a loan before the end of its term<\/p><p><strong>Bounce Charges<\/strong>- Rs400<br>A fee that borrower has to pay if they bounces a EMI payment<\/p><p><strong>AMC<\/strong> - 0% <br>AMC is Annual/Additional Maintenance Charges<\/p><p>&nbsp;<\/p>",
//             "page3": "<p style=\"text-align: center;\"><strong>Document Required and External Resources<br><br><\/strong><\/p><p>ICICI Product Link :: <a href=\"https://www.icicibank.com/Personal-Banking/loans/personal-loan/business-instalment-loan.page\">https://www.icicibank.com/Personal-Banking/loans/personal-loan/business-instalment-loan.page<\/a><\/p><p>EMI Calculator Link :: https://www.icicibank.com/calculator/personal-loan-emi-calculator.page?#toptitle<\/p><p>KYC Documents - Pan Card/Aadhaar Card<br>Medical Registration Certification/Certificate of Practice<\/p><p>Income proof (Audited financials for the last two years)<br>Latest 3 months Bank statement<br><br>Customer issue not Resolved then escalate to - <a href=\"mailto:admin@insiderlab.in\">admin@insiderlab.in<\/a><br><a href=\"mailto:escalate@insiderlab.in\">escalate@insiderlab.in<\/a><\/p><p>Customer Care Mail Id- <a href=\"mailto:escalate@insiderlab.com\"><span style=\"text-decoration: underline;\">customer.care@icicibank.com<\/span><\/a><\/p><p>Customer Care No.-18601206699<\/p>"
//          },
//          "page_setup": {
//             "page1": "<p style=\"text-align: center;\"><strong>ICICI Bank Main Features<\/strong><\/p><p style=\"text-align: left;\"><br>Your Desired Loan Amount 30000<br>ICICI can provide a Maximum Loan of 30000<br><br><\/p><p>You personalised interest for this product will be around 13% Interest Rate<br>Your awarded Interest Rate range will be 10.99%-15%<\/p><p>Tenure for this product 0<\/p><p>Your monthly EMI - 328.52083333333<\/p><p>Why you should choose ICICI::<\/p><ul><li>Faster processing and Best after sales service and support<\/li><li>Attractive Interest Rates and flexible repayment option<\/li><li>Get pocket-friendly EMI repayment options<\/li><li>No security/collateral required<\/li><\/ul><p>*Terms and conditions apply.<\/p><p>&nbsp;<\/p>",
//             "page2": "<p style=\"text-align: center;\"><strong>ICICI Bank Eligibility Criteria<\/strong><\/p><p style=\"text-align: left;\"><br><strong>Processing fee<\/strong> for this product 2.25% of Receivable/Desired Loan 2.5<\/p><p><strong>Insurance charges<\/strong> Are not mandatory they are as per requirement<br><br><\/p><p><strong>Prepayment Charges <\/strong>5% of the outstanding Loan Amount<\/p><p>When you pay a certain amount(Not equivalent to your loan amount) back to lender which brings down the principal amount unpaid, which in turn brings down your EMIs and the total interest you pay.<\/p><p><strong>Foreclosure Charges<\/strong> -5% of the outstanding Loan Amount<br>It is a fee or charge that you have to pay to the Lender if you decide to repay a loan before the end of its term<\/p><p><strong>Bounce Charges<\/strong>- Rs400<br>A fee that borrower has to pay if they bounces a EMI payment<\/p><p><strong>AMC<\/strong> - 0% <br>AMC is Annual/Additional Maintenance Charges<\/p><p>&nbsp;<\/p>",
//             "page3": "<p style=\"text-align: center;\"><strong>Document Required and External Resources<br><br><\/strong><\/p><p>ICICI Product Link :: <a href=\"https://www.icicibank.com/Personal-Banking/loans/personal-loan/business-instalment-loan.page\">https://www.icicibank.com/Personal-Banking/loans/personal-loan/business-instalment-loan.page<\/a><\/p><p>EMI Calculator Link :: https://www.icicibank.com/calculator/personal-loan-emi-calculator.page?#toptitle<\/p><p>KYC Documents - Pan Card/Aadhaar Card<br>Medical Registration Certification/Certificate of Practice<\/p><p>Income proof (Audited financials for the last two years)<br>Latest 3 months Bank statement<br><br>Customer issue not Resolved then escalate to - <a href=\"mailto:admin@insiderlab.in\">admin@insiderlab.in<\/a><br><a href=\"mailto:escalate@insiderlab.in\">escalate@insiderlab.in<\/a><\/p><p>Customer Care Mail Id- <a href=\"mailto:escalate@insiderlab.com\"><span style=\"text-decoration: underline;\">customer.care@icicibank.com<\/span><\/a><\/p><p>Customer Care No.-18601206699<\/p>"
//          }
//       }
//    }
// }

// ''';
    String _respJson, _token;
    String url =
        ApiConstants.BASE_URL + ApiConstants.ANALYTICS + '?case_id=' + caseID;
    HttpClient httpClient = new HttpClient();
    HttpClientResponse _response;
    HttpClientRequest _request = await httpClient.getUrl(Uri.parse(url));
    _request.headers.set(ApiConstants.HEADER_CONTENT_TYPE, 'application/json');
    _request.headers.set(ApiConstants.HEADER_VERIFY, 'banana');

    _token = await _pref.getToken();
    _request.headers.set(ApiConstants.HEADER_AUTHORIZATION, 'Bearer $_token');
    _response = await _request.close();

    if (_response.statusCode == 200) {
      _respJson = await _response.transform(utf8.decoder).join();
    }
    httpClient.close();
    // log(_respJson.toString(), name: 'this is response');
    return _respJson;
  }

  Future<String> callPutApi(String url, Map jsonMap) async {
    HttpClient httpClient = new HttpClient();
    try {
      var uri = ApiConstants.BASE_URL + url;
      HttpClientRequest request = await httpClient.putUrl(Uri.parse(uri));
      request.headers.set(ApiConstants.HEADER_CONTENT_TYPE, 'application/json');
      request.headers.set(ApiConstants.HEADER_VERIFY, 'banana');
      var token = await _pref.getToken();
      request.headers.set(ApiConstants.HEADER_AUTHORIZATION, 'Bearer $token');
      request.add(utf8.encode(json.encode(jsonMap)));
      HttpClientResponse response = await request.close();
      httpClient.close();
      if (response.statusCode == 200) {
        return response.transform(utf8.decoder).join();
      } else {
        return response.statusCode.toString();
      }
    } catch (e) {}
    return 'Exception occurred';
  }

  Future<String> callDeleteApi(String url) async {
    HttpClient httpClient = new HttpClient();
    try {
      var uri = ApiConstants.BASE_URL + url;
      HttpClientRequest request = await httpClient.deleteUrl(Uri.parse(uri));
      request.headers.set(ApiConstants.HEADER_CONTENT_TYPE, 'application/json');
      request.headers.set(ApiConstants.HEADER_VERIFY, 'banana');
      var token = await _pref.getToken();
      request.headers.set(ApiConstants.HEADER_AUTHORIZATION, 'Bearer $token');
      HttpClientResponse response = await request.close();
      httpClient.close();
      if (response.statusCode == 200) {
        return response.statusCode.toString();
      } else {
        return response.statusCode.toString();
      }
    } catch (e) {
      // log('Exception occurred: ' + e.toString());
    }
    return 'Error deleting record';
  }
}
