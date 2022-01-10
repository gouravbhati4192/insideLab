class DocumentTypeModel {
  DocumentTypeModel({
    this.error,
    this.message,
    this.data,
  });

  int error;
  String message;
  List<Datum> data;

  factory DocumentTypeModel.fromJson(Map<String, dynamic> json) =>
      DocumentTypeModel(
        error: json["error"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.id,
    this.caseId,
    this.status,
    this.comments,
    this.documentType,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  int id;
  int caseId;
  String status;
  String comments;
  String documentType;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        caseId: json["case_id"],
        status: json["status"],
        comments: json["comments"],
        documentType: json["document_type"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "case_id": caseId,
        "status": status,
        "comments": comments,
        "document_type": documentType,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
      };
}
