class CommentsCaseList {
  CommentsCaseList({
    this.error,
    this.message,
    this.data,
  });

  int error;
  String message;
  List<Datum> data;

  factory CommentsCaseList.fromJson(Map<String, dynamic> json) =>
      CommentsCaseList(
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
    this.userId,
    this.caseComments,
    this.userComments,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int caseId;
  int userId;
  String caseComments;
  String userComments;
  DateTime createdAt;
  DateTime updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        caseId: json["case_id"],
        userId: json["user_id"],
        caseComments: json["case_comments"],
        userComments: json["user_comments"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "case_id": caseId,
        "user_id": userId,
        "case_comments": caseComments,
        "user_comments": userComments,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
