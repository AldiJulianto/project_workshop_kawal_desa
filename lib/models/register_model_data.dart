// To parse this JSON data, do
//
//     final responseRegisterData = responseRegisterDataFromJson(jsonString);

import 'dart:convert';

ResponseRegisterData responseRegisterDataFromJson(String str) => ResponseRegisterData.fromJson(json.decode(str));

String responseRegisterDataToJson(ResponseRegisterData data) => json.encode(data.toJson());

class ResponseRegisterData {
  ResponseRegisterData({
    this.code,
    this.status,
    this.message,
  });

  int code;
  bool status;
  String message;

  factory ResponseRegisterData.fromJson(Map<String, dynamic> json) => ResponseRegisterData(
    code: json["code"],
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "status": status,
    "message": message,
  };
}
