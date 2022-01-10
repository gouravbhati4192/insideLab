class User {
    User({
        this.id,
        this.name,
        this.email,
        this.panCard,
        this.aadharCard,
        this.mobileVerifiedAt,
        this.mobile,
        this.location,
        this.emailVerifiedAt,
        this.createdAt,
        this.updatedAt,
        this.disabled,
        this.userType,
        this.bankName,
        this.accountHolderName,
        this.accountNumber,
        this.ifscCode,
        this.address,
        this.currentProfession,
        this.employmentType,
        this.workExperience,
        this.employerName,
        this.financialIndustry,
        this.holdGovOffice,
        this.dob,
        this.gender,
        this.whatsappNumber,
        this.profileImage,
        this.firebaseToken,
        this.docs,
    });

    int id;
    String name;
    String email;
    dynamic panCard;
    dynamic aadharCard;
    dynamic mobileVerifiedAt;
    dynamic mobile;
    dynamic location;
    dynamic emailVerifiedAt;
    DateTime createdAt;
    DateTime updatedAt;
    String disabled;
    String userType;
    dynamic bankName;
    dynamic accountHolderName;
    dynamic accountNumber;
    dynamic ifscCode;
    dynamic address;
    dynamic currentProfession;
    dynamic employmentType;
    dynamic workExperience;
    dynamic employerName;
    dynamic financialIndustry;
    dynamic holdGovOffice;
    dynamic dob;
    dynamic gender;
    dynamic whatsappNumber;
    dynamic profileImage;
    dynamic firebaseToken;
    List<String> docs;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        panCard: json["pan_card"],
        aadharCard: json["aadhar_card"],
        mobileVerifiedAt: json["mobile_verified_at"],
        mobile: json["mobile"],
        location: json["location"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        disabled: json["disabled"] == null ? null : json["disabled"],
        userType: json["user_type"] == null ? null : json["user_type"],
        bankName: json["bank_name"],
        accountHolderName: json["account_holder_name"],
        accountNumber: json["account_number"],
        ifscCode: json["ifsc_code"],
        address: json["address"],
        currentProfession: json["current_profession"],
        employmentType: json["employment_type"],
        workExperience: json["work_experience"],
        employerName: json["employer_name"],
        financialIndustry: json["financial_industry"],
        holdGovOffice: json["hold_gov_office"],
        dob: json["dob"],
        gender: json["gender"],
        whatsappNumber: json["whatsapp_number"],
        profileImage: json["profile_image"],
        firebaseToken: json["firebase_token"],
        docs: json["docs"] == null ? null : List<String>.from(json["docs"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "pan_card": panCard,
        "aadhar_card": aadharCard,
        "mobile_verified_at": mobileVerifiedAt,
        "mobile": mobile,
        "location": location,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "disabled": disabled == null ? null : disabled,
        "user_type": userType == null ? null : userType,
        "bank_name": bankName,
        "account_holder_name": accountHolderName,
        "account_number": accountNumber,
        "ifsc_code": ifscCode,
        "address": address,
        "current_profession": currentProfession,
        "employment_type": employmentType,
        "work_experience": workExperience,
        "employer_name": employerName,
        "financial_industry": financialIndustry,
        "hold_gov_office": holdGovOffice,
        "dob": dob,
        "gender": gender,
        "whatsapp_number": whatsappNumber,
        "profile_image": profileImage,
        "firebase_token": firebaseToken,
        "docs": docs == null ? null : List<dynamic>.from(docs.map((x) => x)),
    };
}
