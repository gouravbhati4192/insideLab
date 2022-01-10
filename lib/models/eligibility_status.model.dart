class EligibilityStatus {
    EligibilityStatus({
        this.status,
        this.id,
        this.explanation,
    });

    String status;
    int id;
    String explanation;

    factory EligibilityStatus.fromJson(Map<String, dynamic> json) => EligibilityStatus(
        status: json["status"] == null ? null : json["status"],
        id: json["id"] == null ? null : json["id"],
        explanation: json["explanation"] == null ? null : json["explanation"],
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "id": id == null ? null : id,
        "explanation": explanation == null ? null : explanation,
    };
}