class ProductList {
  ProductList({
    this.error,
    this.data,
    this.message,
    this.showMessage,
  });

  int error;
  List<Datum> data;
  String message;
  bool showMessage;

  factory ProductList.fromJson(Map<String, dynamic> json) => ProductList(
        error: json["error"] == null ? null : json["error"],
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        message: json["message"] == null ? null : json["message"],
        showMessage: json["show_message"] == null ? null : json["show_message"],
      );

  Map<String, dynamic> toJson() => {
        "error": error == null ? null : error,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message == null ? null : message,
        "show_message": showMessage == null ? null : showMessage,
      };
}

class Datum {
  Datum({
    this.id,
    this.name,
    this.bankId,
    this.type,
    this.features,
    this.uiListing,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  int id;
  String name;
  int bankId;
  String type;
  Features features;
  UiListing uiListing;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        bankId: json["bank_id"] == null ? null : json["bank_id"],
        type: json["type"] == null ? null : json["type"],
        features: json["features"] == null
            ? null
            : Features.fromJson(json["features"]),
        uiListing: json["ui_listing"] == null
            ? null
            : UiListing.fromJson(json["ui_listing"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "bank_id": bankId == null ? null : bankId,
        "type": type == null ? null : type,
        "features": features == null ? null : features.toJson(),
        "ui_listing": uiListing == null ? null : uiListing.toJson(),
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
      };
}

class Features {
  Features({
    this.pageSetup,
    this.uiSetup,
  });

  Map pageSetup;
  UiSetup uiSetup;

  factory Features.fromJson(Map<String, dynamic> json) => Features(
        pageSetup: json["page_setup"] == null
            ? null
            : json["page_setup"],
        uiSetup: json["ui_setup"] == null
            ? null
            : UiSetup.fromJson(json["ui_setup"]),
      );

  Map<String, dynamic> toJson() => {
        "page_setup": pageSetup == null ? null : pageSetup,
        "ui_setup": uiSetup == null ? null : uiSetup.toJson(),
      };
}

class UiSetup {
  UiSetup({
    this.irr,
    this.processingFees,
  });

  double irr;
  double processingFees;

  factory UiSetup.fromJson(Map<String, dynamic> json) => UiSetup(
        irr: json["irr"] == null ? null : json["irr"].toDouble(),
        processingFees: json["processing_fees"] == null
            ? null
            : json["processing_fees"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "irr": irr == null ? null : irr,
        "processing_fees": processingFees == null ? null : processingFees,
      };
}

class UiListing {
  UiListing({
    this.pageSetup,
  });

  UiListingPageSetup pageSetup;

  factory UiListing.fromJson(Map<String, dynamic> json) => UiListing(
        pageSetup: json["page_setup"] == null
            ? null
            : UiListingPageSetup.fromJson(json["page_setup"]),
      );

  Map<String, dynamic> toJson() => {
        "page_setup": pageSetup == null ? null : pageSetup.toJson(),
      };
}

class UiListingPageSetup {
  UiListingPageSetup({
    this.page1,
    this.page2,
    this.page3,
  });

  String page1;
  String page2;
  String page3;

  factory UiListingPageSetup.fromJson(Map<String, dynamic> json) =>
      UiListingPageSetup(
        page1: json["page1"] == null ? null : json["page1"],
        page2: json["page2"] == null ? null : json["page2"],
        page3: json["page3"] == null ? null : json["page3"],
      );

  Map<String, dynamic> toJson() => {
        "page1": page1 == null ? null : page1,
        "page2": page2 == null ? null : page2,
        "page3": page3 == null ? null : page3,
      };
}
