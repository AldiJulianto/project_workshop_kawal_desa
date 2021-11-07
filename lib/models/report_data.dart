import 'dart:convert';
ReportData reportDataFromJson(String str) => ReportData.fromJson(json.decode(str));

String reportDataToJson(ReportData data) => json.encode(data.toJson());

class ReportData {
  int code;
  bool status;
  String message;
  List<Datum> data;

  ReportData({
    this.code,
    this.status,
    this.message,
    this.data
  });

  factory ReportData.fromJson(Map<String, dynamic> json) => ReportData(
      code: json['code'],
      status: json['status'],
      message: json['message'],
      //Membutuhkan class Datum
      data: List<Datum>.from(json['data'].map((x) => Datum.fromJson(x)))
  );
  Map<String, dynamic> toJson()=> {
    "code": code,
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson()))
  };
}

class Datum {
  String id;
  String name;
  String long;
  String lat;
  String address;
  String localImage;
  int timestamp;
  String image;
  String description;
  String type;

  Datum({
    this.id,
    this.name,
    this.long,
    this.lat,
    this.address,
    this.localImage,
    this.timestamp,
    this.image,
    this.description,
    this.type
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
      id: json['_id'],
      name: json['NAME'],
      long: json['LONG'],
      lat: json['LAT'],
      address: json['ADDRESS'],
      localImage: json['LOCAl_IMAGE'],
      timestamp: json['TIMESTAMP'],
      image: json['IMAGE'],
      description: json['DESCRIPTION'],
      type: json['TYPE']
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "NAME": name,
    "LONG": long,
    "LAT": lat,
    "ADDRESS": address,
    "LOCAL_IMAGE": localImage,
    "TIMESTAMP": timestamp,
    "IMAGE": image,
    "DESCRIPTION": description,
    "TYPE": type
  };
}
