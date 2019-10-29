// To parse this JSON data, do
//
//     final createUserResponse = createUserResponseFromJson(jsonString);

import 'dart:convert';

CommonResponse commonResponseFromJson(String str) =>
    CommonResponse.fromJson(json.decode(str));

String commonResponseToJson(CommonResponse data) => json.encode(data.toJson());

class CommonResponse {
  String message;
  Data data;
  bool status;
  int code;

  CommonResponse({
    this.message,
    this.data,
    this.status,
    this.code,
  });

  factory CommonResponse.fromJson(Map<String, dynamic> json) => CommonResponse(
        message: json["message"],
        data: Data.fromJson(json["data"]),
        status: json["status"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
        "status": status,
        "code": code,
      };
      
  @override
  String toString() {
    return commonResponseToJson(this);
  }
}

class Data {
  String token;

  Data({
    this.token,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
      };
}
