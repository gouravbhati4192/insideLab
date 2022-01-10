class Customer {
  //Personal Details
  String _userID;
  String _fullName;
  String _dob;
  String _gender;
  String _pinCode;
  String _aadharCard;
  int _aadharCardNumber;
  String _panCard;
  String _panCardNumber;
  String _mobileNumber;
  String _emailID;
  String _maritalStatus;
  String _pastLoans;
  String _addressType;
  String _residentialStatus;

  //Work Details
  String _employmentType;
  String _occupation;
  String _organisationType;
  String _industry;
  String _companyName;
  String _firmName;
  String _fieldOfWork;
  String _designation;
  String _highestDegree;
  String _workExp;
  String _expCurrentEmployer;
  double _monthlySalary;
  double _ongoingMonthlyObligation;
  String _mode;
  String _salaryBank;
  bool _workingFromHome;
  String _ownershipStatus;
  String _informClientIncome;
  String _primaryAccount;
  String _yearsInBusiness;
  String _annualIncome;

//Loan Details
  String _loanType;
  double _loanAmount;
  int _loanTenure;
  int _noCreditCardsLoans;
  int _noBusinessLoan;
  int _noAutoLoans;
  int _noLoanAgainstProperty;
  int _noHomeLoans;
  int _noPersonalLoans;
  int _noEducationLoans;
  int _noOtherLoans;
  int _totalLoans;
  String _purposeOfLoan;
  int _totalEnquiries;
  bool _anyLoanInOneYear;

  String get userID => _userID;
  set userID(String value) => _userID = value;

  String get fullName => _fullName;
  set fullName(String value) {
    _fullName = value;
  }

  String get gender => _gender;

  set gender(String value) {
    _gender = value;
  }

  String get maritalStatus => _maritalStatus;
  set maritalStatus(String value) => _maritalStatus = value;

  String get pastLoans => _pastLoans;
  set pastLoans(String value) => _pastLoans = value;

  String get aadharCard => _aadharCard;
  set aadharCard(String value) => _aadharCard = value;

  int get aadharCardNumber => _aadharCardNumber;
  set aadharCardNumber(int value) {
    _aadharCardNumber = value;
  }

  String get panCard => _panCard;
  set panCard(String value) => _panCard = value;

  String get panCardNumber => _panCardNumber;
  set panCardNumber(String value) {
    _panCardNumber = value;
  }

  String get emailID => _emailID;

  set emailID(String value) {
    _emailID = value;
  }

  String get mobileNumber => _mobileNumber;

  set mobileNumber(String value) {
    _mobileNumber = value;
  }

  String get pinCode => _pinCode;

  set pinCode(String value) {
    _pinCode = value;
  }

  String get dob => _dob;

  set dob(String value) {
    _dob = value;
  }

  String get addressType => _addressType;
  set addressType(String value) => _addressType = value;

  String get residentialStatus => _residentialStatus;
  set residentialStatus(String value) => _residentialStatus = value;

  double get loanAmount => _loanAmount;
  set loanAmount(double value) {
    _loanAmount = value;
  }

  String get loanType => _loanType;
  set loanType(String value) {
    _loanType = value;
  }

  String get salaryBank => _salaryBank;
  set salaryBank(String value) {
    _salaryBank = value;
  }

  String get mode => _mode;
  set mode(String value) => _mode = value;

  double get ongoingMonthlyObligation => _ongoingMonthlyObligation;
  set ongoingMonthlyObligation(double value) {
    _ongoingMonthlyObligation = value;
  }

  double get monthlySalary => _monthlySalary;
  set monthlySalary(double value) {
    _monthlySalary = value;
  }

  String get workExp => _workExp;
  set workExp(String value) {
    _workExp = value;
  }

  String get expCurrentEmployer => _expCurrentEmployer;
  set expCurrentEmployer(String value) => _expCurrentEmployer;

  String get highestDegree => _highestDegree;
  set highestDegree(String value) => _highestDegree = value;

  String get designation => _designation;
  set designation(String value) {
    _designation = value;
  }

  String get fieldOfWork => _fieldOfWork;
  set fieldOfWork(String value) {
    _fieldOfWork = value;
  }

  String get companyName => _companyName;
  set companyName(String value) {
    _companyName = value;
  }

  String get firmName => _firmName;
  set firmName(String value) => _firmName = value;

  int get tenure => _loanTenure;
  set tenure(int value) {
    _loanTenure = value;
  }

  String get occupation => _occupation;
  set occupation(String value) => _occupation = value;

  String get employmentType => _employmentType;
  set employmentType(String value) => _employmentType = value;

  String get organisationType => _organisationType;
  set organisationType(String value) => _organisationType = value;

  String get industry => _industry;
  set industry(String value) => _industry = value;

  bool get workingFromHome => _workingFromHome;
  set workingFromHome(bool value) => _workingFromHome = value;

  String get ownershipStatus => _ownershipStatus;
  set ownershipStatus(String value) => _ownershipStatus = value;

  String get informClientIncome => _informClientIncome;
  set informClientIncome(String value) => _informClientIncome;

  String get primaryAccount => _primaryAccount;
  set primaryAccount(String value) => _primaryAccount = value;

  String get yearsInBusiness => _yearsInBusiness;
  set yearsInBusiness(String value) => _yearsInBusiness = value;

  int get totalLoans => _totalLoans;
  set totalLoans(int value) => _totalLoans = value;

  int get noCreditCardsLoans => _noCreditCardsLoans;
  set noCreditCardsLoans(int value) => _noCreditCardsLoans = value;

  int get noBusinessLoan => _noBusinessLoan;
  set noBusinessLoan(int value) => _noBusinessLoan = value;

  int get noAutoLoans => _noAutoLoans;
  set noAutoLoans(int value) => _noAutoLoans = value;

  int get noLoanAgainstProperty => _noLoanAgainstProperty;
  set noLoanAgainstProperty(int value) => _noLoanAgainstProperty = value;

  int get noHomeLoans => _noHomeLoans;
  set noHomeLoans(int value) => _noHomeLoans = value;

  int get noPersonalLoans => _noPersonalLoans;
  set noPersonalLoans(int value) => _noPersonalLoans = value;

  int get noEducationLoans => _noEducationLoans;
  set noEducationLoans(int value) => _noEducationLoans = value;

  int get noOtherLoans => _noOtherLoans;
  set noOtherLoans(int value) => _noOtherLoans = value;

  String get purposeOfLoan => _purposeOfLoan;
  set purposeOfLoan(String value) => _purposeOfLoan = value;

  int get totalEnquiries => _totalEnquiries;
  set totalEnquiries(int value) => _totalEnquiries = value;

  bool get anyLoanInOneYear => _anyLoanInOneYear;
  set anyLoanInOneYear(bool value) => _anyLoanInOneYear = value;

  String get annualIncome => _annualIncome;
  set annualIncome(String value) => _annualIncome = value;

  Map<String, dynamic> toJson() => {
        'id': userID,
        'full_name': fullName,
        'gender': gender,
        'marital_status': maritalStatus,
        'past_loans': pastLoans,
        'aadhar_card': aadharCard,
        'aadhar_card_number': aadharCardNumber,
        'pan_card': panCard,
        'pan_card_number': panCardNumber,
        'email': emailID,
        'mobile': mobileNumber,
        'pin_code': pinCode,
        'date_of_birth': dob,
        'address_type': addressType,
        'residential_status': residentialStatus,
        'load_amount': loanAmount,
        'load_type': loanType,
        'mode_of_salary': mode,
        'ongoing_monthly_obligations': ongoingMonthlyObligation,
        'monthly_salary': monthlySalary,
        'work_experience': workExp,
        'exp_with_current_employer': expCurrentEmployer,
        'highest_degree': highestDegree,
        'years_in_business': yearsInBusiness,
        'total_loans': totalLoans,
        'load_purpose': purposeOfLoan,
        'employer_name': companyName,
        'firm_name': firmName,
        'tenure': tenure,
        'occupation': occupation,
        'employment_type': employmentType,
        'organisation_type': organisationType,
        'industry': industry,
        'working_from_home': workingFromHome,
        'premise_ownership_status': ownershipStatus,
        'inform_client_income': informClientIncome,
        'primary_account': primaryAccount,
        'client_income': annualIncome
      };
}
