import 'dart:developer';

import 'package:financial_freedom/controller/customer.controller.dart';
import 'package:financial_freedom/controller/user.controller.dart';
import 'package:financial_freedom/old/Home/comingsoon.dart';
import 'package:financial_freedom/old/Home/home.dart';
import 'package:financial_freedom/old/customer/adhaar_verification.dart';
import 'package:financial_freedom/old/customer/animated-product-list.dart';
import 'package:financial_freedom/old/customer/basic_details_customer.dart';
import 'package:financial_freedom/old/customer/congratulations-screen.dart';
import 'package:financial_freedom/old/customer/customerProductOtpScreen.dart';
import 'package:financial_freedom/old/customer/employment_details.dart';
import 'package:financial_freedom/old/customer/income_details.dart';
import 'package:financial_freedom/old/customer/monthly_oblogations.dart';
import 'package:financial_freedom/old/customer/newCustomer.dart';
import 'package:financial_freedom/old/customer/newProductDetails.dart';
import 'package:financial_freedom/old/customer/otpscreen.dart';
import 'package:financial_freedom/old/customer/pancard_verification.dart';
import 'package:financial_freedom/old/customer/personal_info.dart';
import 'package:financial_freedom/old/customer/productDetails.dart';
import 'package:financial_freedom/old/customer/profesional_loan.dart';
import 'package:financial_freedom/old/customer/select_degree.dart';
import 'package:financial_freedom/old/customer/select_profession.dart';
import 'package:financial_freedom/old/customer/takephoto_upload.dart';
import 'package:financial_freedom/old/customer/upload_adhaar.dart';
import 'package:financial_freedom/old/customer/upload_pan.dart';
import 'package:financial_freedom/old/widgets/login/login.dart' as oldLogin;
import 'package:financial_freedom/old/widgets/registration/conflictOfInterest.dart';
import 'package:financial_freedom/old/widgets/registration/registration-new.dart';
import 'package:financial_freedom/old/products/generalEnquiry.dart';
import 'package:financial_freedom/old/products/generalEnquiryDetails.dart';
import 'package:financial_freedom/old/widgets/common/StringConstants.dart';
import 'package:financial_freedom/old/widgets/common/colors.dart';
import 'package:financial_freedom/old/widgets/common/mycolors.dart';
import 'package:financial_freedom/old/widgets/customer/customer-profile.dart';
import 'package:financial_freedom/old/widgets/customer/document-details-new.dart';
import 'package:financial_freedom/old/widgets/customer/document-required.dart';
import 'package:financial_freedom/old/widgets/registration/TermsCondition.dart';
import 'package:financial_freedom/old/widgets/registration/bankDetails.dart';
import 'package:financial_freedom/old/widgets/registration/registration.dart';
import 'package:financial_freedom/old/widgets/common/routes.dart';
import 'package:financial_freedom/old/widgets/login/forgot_password.dart';
import 'package:financial_freedom/screens/splash/splash.screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'new ui pages/customer registration/find_loan_question_answer_page.dart';

int slab = 1;

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'normal', "Normal Notification",
    description: "This Channel id Used For Normal Notification",
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  log("A bg message just showed up");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  runApp(FinancialFreedom());
}

class FinancialFreedom extends StatelessWidget {
  static const String fontfamily = 'IBM Plex Sans';
  static GlobalKey<ScaffoldMessengerState> sMKey =
      GlobalKey<ScaffoldMessengerState>();
  static GlobalKey<NavigatorState> nKey = GlobalKey<NavigatorState>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserController()),
        ChangeNotifierProvider(create: (_) => CustomerController()),
      ],
      child: MaterialApp(
        scaffoldMessengerKey: sMKey,
        navigatorKey: nKey,
        title: StringConstants.appTitle,
        theme: ThemeData(
          primaryColor: GetColor.sandybrown,
          primarySwatch: MyColors.darkBlue,
          scaffoldBackgroundColor: GetColor.darkgray_background,
          textTheme: TextTheme(
            bodyText2: TextStyle(
                color: GetColor.bodytextcolor,
                fontFamily: fontfamily,
                fontSize: 14),
            headline6: TextStyle(
                color: GetColor.sandybrown,
                fontWeight: FontWeight.bold,
                fontFamily: fontfamily,
                fontSize: 30),
            button: TextStyle(color: GetColor.lightgray, fontSize: 14),
          ),
          buttonTheme: ButtonThemeData(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            buttonColor: GetColor.sandybrown,
          ),
        ),
        // home: SplashScreen(),
        initialRoute: Routes.splash,
        onGenerateRoute: (RouteSettings settings) {
          var routes = <String, WidgetBuilder>{
            Routes.splash: (context) => oldLogin.SplashScreen(),
            Routes.profesionalLoan: (context) =>
                ProfesionalLoan(customerData: settings.arguments),
            Routes.selectProfession: (context) =>
                SelectProfession(customerData: settings.arguments),
            Routes.basicDetailsCust: (context) =>
                BasicDetailsCustomer(customerData: settings.arguments),
            Routes.doctorDegree: (context) =>
                DoctorDegrees(customerData: settings.arguments),
            Routes.otpscreen: (context) =>
                OtpScreen(customerData: settings.arguments),

            Routes.personalInfo: (context) =>
                PersonalInfo(customerData: settings.arguments),

            Routes.uploadAdhaar: (context) =>
                UploadAdhaar(customerData: settings.arguments),
            Routes.adhaarVerificationByDoc: (context) =>
                AdhaarVerifactionDoc(customerData: settings.arguments),
            Routes.adhaarVerificationByCamera: (context) =>
                AdhaarVerificationCamera(customerData: settings.arguments),

            Routes.takePhotoAadhar2: (context) =>
                TakePhotoAadhar2(customerData: settings.arguments),
            Routes.takePhotoPanCard: (context) =>
                TakePhotoPanCard(customerData: settings.arguments),

            Routes.uploadPan: (context) =>
                UploadPan(customerData: settings.arguments),
            Routes.panVerificationByDoc: (context) =>
                PanVerifactionDoc(customerData: settings.arguments),
            Routes.employmentDetails: (context) =>
                EmploymentDetails(customerData: settings.arguments),
            Routes.incomeDetails: (context) =>
                IncomeDetails(customerData: settings.arguments),

            '/customerDetail': (context) =>
                CustomerProfile(customerID: settings.arguments),
            // '/otpScreen': (context) => OtpScreen(
            //     title: StringConstants.appTitle,
            //     agent: agentDetails,
            //     screenArgs: settings.arguments),
            // '/custOtpScreen': (context) => CustomerOtpScreen(
            //     title: StringConstants.appTitle,
            //     customer: customerDetails,
            //     screenArgs: settings.arguments),
            // '/customerProductOtpScreen': (context) => CustomerProductOtpScreen(
            //     title: StringConstants.appTitle,
            //     customer: customerDetails,
            //     screenArgs: settings.arguments),
            '/newCustomer/productDetails': (context) => AnimatedProductList(
                title: StringConstants.appTitle,
                screenArgs: settings.arguments),

            // '/custOtpScreen': (context) => CustomerOtpScreen(
            //     title: StringConstants.appTitle,
            //     customer: customerDetails,
            //     screenArgs: settings.arguments),
            '/customerProductOtpScreen': (context) => CustomerProductOtpScreen(
                title: StringConstants.appTitle,
                screenArgs: settings.arguments),
            '/newCustomer/productDetails': (context) => AnimatedProductList(
                title: StringConstants.appTitle,
                screenArgs: settings.arguments),
            '/documentList': (context) =>
                DocumentRequiredScreen(screenArgs: settings.arguments),
          };
          WidgetBuilder builder = routes[settings.name];
          return MaterialPageRoute(builder: (context) => builder(context));
        },
        routes: {
          Routes.login: (context) =>
              oldLogin.FinancialFreedomLogin(title: StringConstants.appTitle),
          Routes.home: (context) => Home(title: StringConstants.appTitle),
          Routes.newcustomer: (context) => NewCustomer(),
          Routes.findLoanQuesAns: (context) => FindLoanQuestionAnswer(),
          Routes.forgotpassword: (context) => ForgotPassword(),
          '/doneNewPassword': (context) => DoneNewPassword(),
          '/newCustomer/productSummary': (context) => ProductSummary(
                title: StringConstants.appTitle,
                index: selectedPageIndex,
              ),
          '/registerWithUs': (context) =>
              RegisterMain(title: StringConstants.appTitle),
          '/conflictOfInterest': (context) => ConflictOfInterest(
              title: StringConstants.appTitle, agent: agentDetails),
          '/bankDetails': (context) =>
              BankDetails(title: StringConstants.appTitle, agent: agentDetails),
          '/termsCondition': (context) => TermsCondition(
              title: StringConstants.appTitle, agent: agentDetails),

          '/documentDetails': (context) => DocumentDetailsNew(),
          // '/documentDetails': (context) => DocumentDetails(),
          '/comingsoon': (context) => ComingSoon(
                title: StringConstants.appTitle,
              ),
          '/generalEnquiry': (context) => GeneralEnquiry(
                title: StringConstants.appTitle,
              ),
          '/generalEnquiryDetails': (context) => GeneralEnquiryDetails(
                title: StringConstants.appTitle,
              ),
          '/congratulationsScreen': (context) => CongratulationsScreen(),
          Routes.monthlyObligations: (context) => MonthlyObligations(),
        },
      ),
    );
  }
}
