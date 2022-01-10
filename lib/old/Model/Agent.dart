class Agent {
  //Registration details
  String _firstName;
  String _lastName;
  String _location;
  String _emailID;
  String _mobileNumber;
  String _password;
  String _confirmPassword;
  String _aadharCard;
  String _panCard;
  int _uid;
  Map<String, dynamic> _questionListJson;
  //Question List
  String _ans1;
  String _ans2;
  String _ans3;
  String _ans4; //yes-no type
  String _ans5; //yes-no type
  String _ans6; //yes-no type
  //if yes
  String _ans61;
  String _ans62;
  String _ans63;
  String _ans64;
  String _ans7;

  //Bank Details
  String _bankName;
  String _accountName;

  get questionListJson => _questionListJson;

  set questionListJson(Map<String, dynamic> value) {
    _questionListJson = value;
  }

  int _accountNumber;
  String _ifscCode;

  String get bankName => _bankName;

  set bankName(String value) {
    _bankName = value;
  }

  String get ans64 => _ans64;

  set ans64(String value) {
    _ans64 = value;
  } //yes-no type

  int get uid => _uid;

  set uid(int value) {
    _uid = value;
  }

  String get firstName => _firstName;

  set firstName(String value) {
    _firstName = value;
  }

  String get lastName => _lastName;

  String get panCard => _panCard;

  set panCard(String value) {
    _panCard = value;
  }

  String get aadharCard => _aadharCard;

  set aadharCard(String value) {
    _aadharCard = value;
  }

  String get confirmPassword => _confirmPassword;

  set confirmPassword(String value) {
    _confirmPassword = value;
  }

  String get password => _password;

  set password(String value) {
    _password = value;
  }

  String get mobileNumber => _mobileNumber;

  set mobileNumber(String value) {
    _mobileNumber = value;
  }

  String get emailID => _emailID;

  set emailID(String value) {
    _emailID = value;
  }

  String get location => _location;

  set location(String value) {
    _location = value;
  }

  set lastName(String value) {
    _lastName = value;
  }

  String get ans7 => _ans7;

  set ans7(String value) {
    _ans7 = value;
  }

  String get ans63 => _ans63;

  set ans63(String value) {
    _ans63 = value;
  }

  String get ans62 => _ans62;

  set ans62(String value) {
    _ans62 = value;
  }

  String get ans61 => _ans61;

  set ans61(String value) {
    _ans61 = value;
  }

  String get ans6 => _ans6;

  set ans6(String value) {
    _ans6 = value;
  }

  String get ans5 => _ans5;

  set ans5(String value) {
    _ans5 = value;
  }

  String get ans4 => _ans4;

  set ans4(String value) {
    _ans4 = value;
  }

  String get ans3 => _ans3;

  set ans3(String value) {
    _ans3 = value;
  }

  String get ans2 => _ans2;

  set ans2(String value) {
    _ans2 = value;
  }

  String get ans1 => _ans1;

  set ans1(String value) {
    _ans1 = value;
  }

  String get accountName => _accountName;

  set accountName(String value) {
    _accountName = value;
  }

  int get accountNumber => _accountNumber;

  set accountNumber(int value) {
    _accountNumber = value;
  }

  String get ifscCode => _ifscCode;

  set ifscCode(String value) {
    _ifscCode = value;
  }
}
