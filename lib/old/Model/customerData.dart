class Customer {
  String _loanType;
  String _professionName;
  String _degreename;
  String _pincode;
  double _loanAmount;
  int _loanTenure;
  String _mobileNumber;
  String _emailID;
  String _userID;
  String _otpType;
  String _caseID;
  String _fullName;
  String _dob;
  String _gender;
  String _maritalStatus;
  String _pastLoans;
  String _address;
  String _residentialStatus;
  String _purposeOfLoan;
  String _employmentType;
  String _organisationType;
  String _currentworkexp;
  String _totalworkExp;
  String _empname;
  double _netmonthlySalary;
  String _salarymode;
  String _primaryAccount;
  String _ownershipStatus;

  String industryOfBusiness;

  String businessName;

  String companyType;

  String howOldIsTheBusiness;

  String natureOfBusiness;

  String healthOfBusiness;

  String incomeOfSelectedMethod;

  String primaryBankAccount;

  String latestYearsOfProfitability;

  String aadhaarFront;
  String aadhaarBack;
  String pan;

  get ownershipStatus => this._ownershipStatus;

  set ownershipStatus(value) => this._ownershipStatus = value;
  get primaryAccount => this._primaryAccount;

  set primaryAccount(value) => this._primaryAccount = value;
  String _optionDeclareIncome;

  get optionDeclareIncome => this._optionDeclareIncome;

  set optionDeclareIncome(value) => this._optionDeclareIncome = value;
  get salarymode => this._salarymode;

  set salarymode(value) => this._salarymode = value;
  String _annualIncome;

  get annualIncome => this._annualIncome;

  set annualIncome(value) => this._annualIncome = value;

  get netmonthlySalary => this._netmonthlySalary;

  set netmonthlySalary(value) => this._netmonthlySalary = value;
  String get totalworkExp => this._totalworkExp;

  set totalworkExp(String value) => this._totalworkExp = value;

  get empname => this._empname;

  set empname(value) => this._empname = value;
  get currentworkexp => this._currentworkexp;

  set currentworkexp(value) => this._currentworkexp = value;

  get organisationType => this._organisationType;

  set organisationType(value) => this._organisationType = value;
  get employmentType => this._employmentType;

  set employmentType(value) => this._employmentType = value;
  get purposeOfLoan => this._purposeOfLoan;

  set purposeOfLoan(value) => this._purposeOfLoan = value;

  get fullName => this._fullName;

  set fullName(value) => this._fullName = value;

  get dob => this._dob;

  set dob(value) => this._dob = value;

  get gender => this._gender;

  set gender(value) => this._gender = value;

  get maritalStatus => this._maritalStatus;

  set maritalStatus(value) => this._maritalStatus = value;

  get pastLoans => this._pastLoans;

  set pastLoans(value) => this._pastLoans = value;

  get address => this._address;

  set address(value) => this._address = value;

  get residentialStatus => this._residentialStatus;

  set residentialStatus(value) => this._residentialStatus = value;

  get caseID => this._caseID;

  set caseID(value) => this._caseID = value;
  String get otpType => this._otpType;

  set otpType(String value) => this._otpType = value;

  get userID => this._userID;

  set userID(value) => this._userID = value;

  get pincode => this._pincode;

  set pincode(value) => this._pincode = value;

  get loanAmount => this._loanAmount;

  set loanAmount(value) => this._loanAmount = value;

  get loanTenure => this._loanTenure;

  set loanTenure(value) => this._loanTenure = value;

  get mobileNumber => this._mobileNumber;

  set mobileNumber(value) => this._mobileNumber = value;

  get emailID => this._emailID;

  set emailID(value) => this._emailID = value;

  get degreename => this._degreename;

  set degreename(value) => this._degreename = value;
  get loanType => this._loanType;

  set loanType(value) => this._loanType = value;

  get professionName => this._professionName;

  set professionName(value) => this._professionName = value;

  Map<String, dynamic> toJson() => {
        'id': userID,
        'full_name': fullName,
        'gender': gender,
        'marital_status': maritalStatus,
        'past_loans': pastLoans,
        'aadhar_card': '',
        'aadhar_card_number': '',
        'pan_card': '',
        'pan_card_number': '',
        'email': emailID,
        'mobile': mobileNumber,
        'pin_code': pincode,
        'date_of_birth': dob,
        'address_type': address,
        'residential_status': residentialStatus,
        'load_amount': loanAmount,
        'load_type': loanType,
        'mode_of_salary': salarymode,
        'ongoing_monthly_obligations': '',
        'monthly_salary': netmonthlySalary,
        'work_experience': totalworkExp,
        'exp_with_current_employer': currentworkexp,
        'highest_degree': degreename,
        'years_in_business': '',
        'total_loans': loanAmount,
        'load_purpose': purposeOfLoan,
        'employer_name': empname,
        'firm_name': '',
        'tenure': loanTenure,
        'occupation': professionName,
        'employment_type': employmentType,
        'organisation_type': organisationType,
        'industry': '',
        'working_from_home': '',
        'premise_ownership_status': ownershipStatus,
        'inform_client_income': '',
        'primary_account': primaryAccount,
        'client_income': annualIncome
      };
}
