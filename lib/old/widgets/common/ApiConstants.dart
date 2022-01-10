class ApiConstants {
  //static String BASE_URL = 'http://api.ff.kriyawantika.com/api/';
  static String BASE_URL = 'https://crmtest.insiderlab.in/api/';
  // static String BASE_URL = 'https://crm.insiderlab.in/api/';

  static String POST_METHOD = 'POST';
  static String RESULT_OK = 'OK';
  //Headers
  static String HEADER_VERIFY = 'verify-myself';
  static String HEADER_CONTENT_TYPE = 'content-type';
  static String HEADER_AUTHORIZATION =
      'Authorization'; //append token after login api

  //Registration Process Apis
  static String SEND_OTP_API = 'send-otp';
  static String VERIFY_OTP_API = 'verify-otp';
  static String UPLOAD_FILE_API = 'assets';
  static String DOCUMENTS_UPLOAD_API = 'documents';
  static String REGISTER_API = 'register';
  static String GET_QUESTION_LIST = 'get-questions';
  static String SAVE_LISTING = 'save-questions';

  //Login Api
  static String LOGIN_API = 'login';

  //Upload api Constants of key
  static String ATTACHMENT = 'attachment';

  //home
  static String HOME = 'home';

  //Verify Pin code
  static String VERIFY_PINCODE = "pin_codes/";
  // Fetch occupations
  static String FETCH_OCCUPATIONS = 'occupations';
  // Get Case Details
  static String CASE_DETAILS = 'cases/';
  // Save case
  static String CREATE_CASE = 'Create-Cases';

  static String ANALYTICS = 'professional_analytics';
  static String PRODUCTS = 'products';

  static String FORGOTPASSWORD_API = 'forget-password-send-otp';
  static String CHANGEPASSWORD_API = 'change-password';
  static String VERIFY_OTP_RESET_API = 'verify-otp-reset-password';

  static String updateCases = "Update-Cases";
  static String agentDetails = "agent-details";
  static String updateAgent = "Update-Agent";
}