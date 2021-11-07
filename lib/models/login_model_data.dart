// To parse this JSON data, do
//
//     final loginData = loginDataFromJson(jsonString);

import 'dart:convert';

LoginData loginDataFromJson(String str) => LoginData.fromJson(json.decode(str));

String loginDataToJson(LoginData data) => json.encode(data.toJson());

class LoginData {
  LoginData({
    this.code,
    this.status,
    this.message,
    this.data
  });

  int code;
  bool status;
  String message;
  Data data;

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
    code: json["code"],
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "status": status,
    "message": message,
    "data": data.toJson()
  };
}

class Data {
  String phoneNumber;
  String name;
  String email;
  String position;
  String company;
  String localImage;
  String image;
  String unit;
  String guid;
  String appType;
  String role;

  Data({
    this.phoneNumber,
    this.name,
    this.email,
    this.position,
    this.company,
    this.localImage,
    this.image,
    this.unit,
    this.guid,
    this.appType,
    this.role
});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    phoneNumber: json["PHONE_NUMBER"],
    name: json["NAME"],
    email: json["EMAIl"],
    position: json["COMPANY"],
    localImage: json["LOCAL_IMAGE"],
    image: json["IMAGE"],
    unit: json["UNIT"],
    guid: json["GUID"],
    appType: json["APP_TYPE"],
    role: json["ROLE"]
  );

  Map<String, dynamic> toJson() => {
    "PHONE_NUMBER": phoneNumber,
    "NAME": name,
    "EMAIL": email,
    "POSITION": position,
    "COMPANY": company,
    "LOCAL_IMAGE": localImage,
    "IMAGE": image,
    "UNIT": unit,
    "GUID": guid,
    "APP_TYPE": appType,
    "ROLE": role
  };
}