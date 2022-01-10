class ApprovalStatus {
    ApprovalStatus({
        this.id,
        this.loanAmount,
        this.interestRate,
        this.tenure,
        this.processingFees,
    });

    int id;
    int loanAmount;
    int interestRate;
    int tenure;
    int processingFees;

    factory ApprovalStatus.fromJson(Map<String, dynamic> json) => ApprovalStatus(
        id: json["id"] == null ? null : json["id"],
        loanAmount: json["loan_amount"] == null ? null : json["loan_amount"],
        interestRate: json["interest_rate"] == null ? null : json["interest_rate"],
        tenure: json["tenure"] == null ? null : json["tenure"],
        processingFees: json["processing_fees"] == null ? null : json["processing_fees"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "loan_amount": loanAmount == null ? null : loanAmount,
        "interest_rate": interestRate == null ? null : interestRate,
        "tenure": tenure == null ? null : tenure,
        "processing_fees": processingFees == null ? null : processingFees,
    };
}