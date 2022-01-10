import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:financial_freedom/api/api.dart';
import 'package:financial_freedom/main.dart';
import 'package:financial_freedom/models/approval_status.model.dart';
import 'package:financial_freedom/models/comment.case.list.model.dart';
import 'package:financial_freedom/models/document.type.model.dart';
import 'package:financial_freedom/models/eligibility_status.model.dart';
import 'package:flutter/material.dart';

class CustomerController extends ChangeNotifier {
  EligibilityStatus eligibilityStatus;
  ApprovalStatus finalLoanApprovalCaseStatus;
  DocumentTypeModel documentTypes;
  CommentsCaseList commentCaseList;

  Future<bool> getEligibilityStatus({
    @required String caseId,
    @required String token,
  }) async {
    eligibilityStatus = null;
    Response response;
    try {
      response = await Dio().get(
        API.eligibilityStatus,
        queryParameters: {
          "case_id": caseId,
        },
        options: Options(
          headers: {
            "verify-myself": "banana",
            "Authorization": "Bearer $token",
          },
        ),
      );
      if (response.statusCode != 200) {
        log(response.statusMessage, name: "Get Eligibility Status API Failed");
        FinancialFreedom.sMKey.currentState
            .showSnackBar(SnackBar(content: Text(response.statusMessage)));
        return false;
      }
      if (response.statusCode == 200 && response.data['error'] != 0) {
        log(response.statusMessage, name: "Get Eligibility Status API Failed");
        FinancialFreedom.sMKey.currentState
            .showSnackBar(SnackBar(content: Text(response.data["message"])));
        return false;
      }
    } on DioError catch (e) {
      if (e.response == null) {
        log(e.message.toString(), name: "Get Eligibility Status API Error");
        FinancialFreedom.sMKey.currentState
            .showSnackBar(SnackBar(content: Text("Network not available")));
      } else {
        log(e.response.data.toString(),
            name: "Get Eligibility Status API Error");
        FinancialFreedom.sMKey.currentState
            .showSnackBar(SnackBar(content: Text("Network not available")));
      }
      return false;
    }

    try {
      log(json.encode(response.data), name: "Get Eligibility Status API Data");
      // this.token = response.data['data']['token'];
      if (response.data["data"] != null) {
        this.eligibilityStatus =
            EligibilityStatus.fromJson(response.data["data"]);
      }
      notifyListeners();
      return true;
    } catch (e) {
      log(e.toString(), name: "Get Eligibility Status API Exception");
      FinancialFreedom.sMKey.currentState
          .showSnackBar(SnackBar(content: Text(e.toString())));
      return false;
    }
  }

  Future<bool> getFinalLoanApprovalCaseStatus({
    @required String caseId,
    @required String token,
  }) async {
    Response response;
    try {
      response = await Dio().get(
        API.finalLoanApprovalCase,
        queryParameters: {
          "case_id": caseId,
        },
        options: Options(
          headers: {
            "verify-myself": "banana",
            "Authorization": "Bearer $token",
          },
        ),
      );
      if (response.statusCode != 200) {
        log(response.statusMessage,
            name: "Get Final Loan Approval Case Status API Failed");
        FinancialFreedom.sMKey.currentState
            .showSnackBar(SnackBar(content: Text(response.statusMessage)));
        return false;
      }
      if (response.statusCode == 200 && response.data['error'] != 0) {
        log(response.statusMessage,
            name: "Get Final Loan Approval Case Status API Failed");
        FinancialFreedom.sMKey.currentState
            .showSnackBar(SnackBar(content: Text(response.data["message"])));
        return false;
      }
    } on DioError catch (e) {
      if (e.response == null) {
        log(e.message.toString(),
            name: "Get Final Loan Approval Case Status API Error");
        FinancialFreedom.sMKey.currentState
            .showSnackBar(SnackBar(content: Text("Network not available")));
      } else {
        log(e.response.data.toString(),
            name: "Get Final Loan Approval Case Status API Error");
        FinancialFreedom.sMKey.currentState
            .showSnackBar(SnackBar(content: Text("Network not available")));
      }
      return false;
    }

    try {
      log(json.encode(response.data),
          name: "Get Final Loan Approval Case Status API Data");
      // this.token = response.data['data']['token'];
      if (response.data["data"] != null) {
        this.finalLoanApprovalCaseStatus =
            ApprovalStatus.fromJson(response.data["data"]);
      }
      notifyListeners();
      return true;
    } catch (e) {
      log(e.toString(),
          name: "Get Final Loan Approval Case Status API Exception");
      FinancialFreedom.sMKey.currentState
          .showSnackBar(SnackBar(content: Text(e.toString())));
      return false;
    }
  }

  Future<bool> getDocumentTypeCaseList({
    @required String caseId,
    @required String token,
  }) async {
    Response response;
    try {
      response = await Dio().get(
        API.documentTypeCaseList,
        queryParameters: {
          "case_id": caseId,
        },
        options: Options(
          headers: {
            "verify-myself": "banana",
            "Authorization": "Bearer $token",
          },
        ),
      );
      if (response.statusCode != 200) {
        log(response.statusMessage, name: "Get Document Case List API Failed");
        FinancialFreedom.sMKey.currentState
            .showSnackBar(SnackBar(content: Text(response.statusMessage)));
        return false;
      }
      if (response.statusCode == 200 && response.data['error'] != 0) {
        log(response.statusMessage, name: "Get Document Case List API Failed");
        FinancialFreedom.sMKey.currentState
            .showSnackBar(SnackBar(content: Text(response.data["message"])));
        return false;
      }
    } on DioError catch (e) {
      if (e.response == null) {
        log(e.message.toString(), name: "Get Document Case List API Error");
        FinancialFreedom.sMKey.currentState
            .showSnackBar(SnackBar(content: Text("Network not available")));
      } else {
        log(e.response.data.toString(),
            name: "Get Document Case List API Error");
        FinancialFreedom.sMKey.currentState
            .showSnackBar(SnackBar(content: Text("Network not available")));
      }
      return false;
    }

    try {
      log(json.encode(response.data), name: "Get Document Case List API Data");
      // this.token = response.data['data']['token'];
      if (response.data != null) {
        this.documentTypes = DocumentTypeModel.fromJson(response.data);
      }
      notifyListeners();
      return true;
    } catch (e) {
      log(e.toString(), name: "Get Document Case List API Exception");
      FinancialFreedom.sMKey.currentState
          .showSnackBar(SnackBar(content: Text(e.toString())));
      return false;
    }
  }

  Future<bool> sentComment({
    @required String caseId,
    @required String caseComments,
    @required String token,
  }) async {
    Response response;
    try {
      response = await Dio().post(
        API.commentSent,
        data: {
          "id": caseId,
          "case_comments": caseComments,
        },
        options: Options(
          headers: {
            "verify-myself": "banana",
            "Authorization": "Bearer $token",
          },
        ),
      );
      if (response.statusCode != 200) {
        log(response.statusMessage, name: "Sent Comment List API Failed");
        FinancialFreedom.sMKey.currentState
            .showSnackBar(SnackBar(content: Text(response.statusMessage)));
        return false;
      }
      if (response.statusCode == 200 && response.data['error'] != 0) {
        log(response.statusMessage, name: "Sent Comment List API Failed");
        FinancialFreedom.sMKey.currentState
            .showSnackBar(SnackBar(content: Text(response.data["message"])));
        return false;
      }
    } on DioError catch (e) {
      if (e.response == null) {
        log(e.message.toString(), name: "Sent Comment List API Error");
        FinancialFreedom.sMKey.currentState
            .showSnackBar(SnackBar(content: Text("Network not available")));
      } else {
        log(e.response.data.toString(), name: "Sent Comment List API Error");
        FinancialFreedom.sMKey.currentState
            .showSnackBar(SnackBar(content: Text("Network not available")));
      }
      return false;
    }

    try {
      log(json.encode(response.data), name: "Sent Comment List API Data");
      // this.token = response.data['data']['token'];
      // if (response.data != null) {
      //   this.documentTypes = DocumentTypeModel.fromJson(response.data);
      // }
      // notifyListeners();
      return true;
    } catch (e) {
      log(e.toString(), name: "Sent Comment List API Exception");
      FinancialFreedom.sMKey.currentState
          .showSnackBar(SnackBar(content: Text(e.toString())));
      return false;
    }
  }

  Future<bool> getCommentList({
    @required String caseId,
    @required String token,
  }) async {
    Response response;
    try {
      response = await Dio().get(
        API.commentCaseList,
        queryParameters: {
          "case_id": caseId,
        },
        options: Options(
          headers: {
            "verify-myself": "banana",
            "Authorization": "Bearer $token",
          },
        ),
      );
      if (response.statusCode != 200) {
        log(response.statusMessage, name: "Get Comment List API Failed");
        FinancialFreedom.sMKey.currentState
            .showSnackBar(SnackBar(content: Text(response.statusMessage)));
        return false;
      }
      if (response.statusCode == 200 && response.data['error'] != 0) {
        log(response.statusMessage, name: "Get Comment List API Failed");
        FinancialFreedom.sMKey.currentState
            .showSnackBar(SnackBar(content: Text(response.data["message"])));
        return false;
      }
    } on DioError catch (e) {
      if (e.response == null) {
        log(e.message.toString(), name: "Get Comment List API Error");
        FinancialFreedom.sMKey.currentState
            .showSnackBar(SnackBar(content: Text("Network not available")));
      } else {
        log(e.response.data.toString(), name: "Get Comment List API Error");
        FinancialFreedom.sMKey.currentState
            .showSnackBar(SnackBar(content: Text("Network not available")));
      }
      return false;
    }

    try {
      log(json.encode(response.data), name: "Get Comment List API Data");
      // this.token = response.data['data']['token'];
      if (response.data["data"] != null) {
        this.commentCaseList = CommentsCaseList.fromJson(response.data);
      }
      notifyListeners();
      return true;
    } catch (e) {
      log(e.toString(), name: "Get Comment List API Exception");
      FinancialFreedom.sMKey.currentState
          .showSnackBar(SnackBar(content: Text(e.toString())));
      return false;
    }
  }
}
