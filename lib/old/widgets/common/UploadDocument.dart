import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:financial_freedom/old/widgets/common/ApiConstants.dart';
import 'package:http/http.dart' as http;

import 'SharedPref.dart';

class UploadDocument {
  SharedPref _pref = new SharedPref();
  // Method for file upload
  Future<String> uploadFile(File file, String caseId, String type,
      {int userId}) async {
    print(caseId);
    print(userId);
    String url = ApiConstants.BASE_URL + ApiConstants.UPLOAD_FILE_API;
    // try {
    //   var token = await _pref.getToken();
    //   log({
    //     "case_id": caseId,
    //     "user_id": userId,
    //     "type": type,
    //     "attachment": MultipartFile.fromFileSync(file.path),
    //   }.toString());
    //   Response response = await Dio().post(url,
    //       options: Options(headers: {
    //         "verify-myself": "banana",
    //         "Authorization": "Bearer $token"
    //       }),
    //       data: FormData.fromMap({
    //         "case_id": caseId,
    //         "user_id": userId,
    //         "type": type,
    //         "attachment": MultipartFile.fromFileSync(file.path),
    //       }));
    //   if (response.statusCode == 200) {
    //     return json.encode(response.data);
    //   }
    //   return null;
    // } catch (e) {
    //   print("Exception Caught: $e");
    //   return null;
    // }
    try {
      var request =
          http.MultipartRequest(ApiConstants.POST_METHOD, Uri.parse(url));
      if (userId == null) {
        request.fields.addAll({"case_id": caseId, "type": type});
      } else {
        request.fields.addAll({"user_id": userId.toString()});
      }
      request.files.add(await http.MultipartFile.fromPath(
          ApiConstants.ATTACHMENT, file.path));
      var token = await _pref.getToken();
      print(token);
      Map<String, String> headers = {
        ApiConstants.HEADER_VERIFY: 'banana',
        ApiConstants.HEADER_AUTHORIZATION: 'Bearer $token'
      };
      request.headers.addAll(headers);
      print("before send");
      var response = await request.send();
      print('After send');
      if (response.statusCode == 200) {
        if (response.reasonPhrase == ApiConstants.RESULT_OK) {
          final respStr = await response.stream.bytesToString();
          print("Uploaded!");
          return respStr;
        } else {
          print('Something went wrong..');
          return null;
        }
      } else {
        print("Error");
        throw Exception('Failed to load Api');
      }
    } catch (e) {
      print("Exception Caught: $e");
      return null;
    }
  }

  Future<String> uploadDocumentWithData(
      File file, String caseID, String documentType) async {
    String url = ApiConstants.BASE_URL + ApiConstants.DOCUMENTS_UPLOAD_API;
    try {
      var request =
          http.MultipartRequest(ApiConstants.POST_METHOD, Uri.parse(url));
      request.fields['case_id'] = caseID;
      request.fields['type'] = documentType;
      request.files.add(await http.MultipartFile.fromPath(
          ApiConstants.ATTACHMENT, file.path));
      //request.fields['attachment'] = file.path;
      var token = await _pref.getToken();
      Map<String, String> headers = {
        ApiConstants.HEADER_VERIFY: 'banana',
        ApiConstants.HEADER_CONTENT_TYPE: 'multipart/form-data',
        ApiConstants.HEADER_AUTHORIZATION: 'Bearer $token'
      };
      request.headers.addAll(headers);
      print("before send");
      var response = await request.send();
      print('After send');
      if (response.statusCode == 200) {
        if (response.reasonPhrase == ApiConstants.RESULT_OK) {
          final respStr = await response.stream.bytesToString();
          print("Uploaded!");
          return respStr;
        } else {
          print('Something went wrong..');
          return null;
        }
      } else {
        print("Error");
        throw Exception('Failed to load Api');
      }
    } catch (e) {
      print("Exception Caught: $e");
      return null;
    }
  }
}
