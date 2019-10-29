// To parse this JSON data, do
//
//     final order = orderFromJson(jsonString);

import 'dart:convert';

List<Order> orderFromJson(String str) =>
    List<Order>.from(json.decode(str).map((x) => Order.fromJson(x)));

String orderToJson(List<Order> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Order {
  int ordType;
  DateTime ordDate;
  String ordNum;
  String devId;
  String devModel;
  String devSerialNum;
  int region;
  String city;
  String address;
  String location;
  String employer;
  bool isBoss;
  String phone;
  String contactInfo;
  String contactPhone;
  String shipmentAdress;
  String shipmentLocation;
  DateTime syncTime;
  String ordId;
  List<dynamic> employees;
  List<Job> jobs;
  String remoteStatus;

  Order({
    this.ordType,
    this.ordDate,
    this.ordNum,
    this.devId,
    this.devModel,
    this.devSerialNum,
    this.region,
    this.city,
    this.address,
    this.location,
    this.employer,
    this.isBoss,
    this.phone,
    this.contactInfo,
    this.contactPhone,
    this.shipmentAdress,
    this.shipmentLocation,
    this.syncTime,
    this.ordId,
    this.employees,
    this.jobs,
    this.remoteStatus = "0",
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        ordType: json["ordType"],
        ordDate: DateTime.parse(json["ordDate"]),
        ordNum: json["ordNum"],
        devId: json["devID"],
        devModel: json["devModel"],
        devSerialNum: json["devSerialNum"],
        region: json["region"],
        city: json["city"],
        address: json["address"],
        location: json["location"],
        employer: json["employer"],
        isBoss: json["isBoss"],
        phone: json["phone"],
        contactInfo: json["contactInfo"],
        contactPhone: json["contactPhone"],
        shipmentAdress: json["shipmentAdress"],
        shipmentLocation: json["shipmentLocation"],
        syncTime: DateTime.parse(json["syncTime"]),
        ordId: json["ordID"],
        employees: List<dynamic>.from(json["employees"].map((x) => x)),
        jobs: List<Job>.from(json["jobs"].map((x) => Job.fromJson(x))),
        remoteStatus: json["remoteStatus"] == null ? "0" : json["remoteStatus"],
      );

  Map<String, dynamic> toJson() => {
        "ordType": ordType,
        "ordDate": ordDate.toIso8601String(),
        "ordNum": ordNum,
        "devID": devId,
        "devModel": devModel,
        "devSerialNum": devSerialNum,
        "region": region,
        "city": city,
        "address": address,
        "location": location,
        "employer": employer,
        "isBoss": isBoss,
        "phone": phone,
        "contactInfo": contactInfo,
        "contactPhone": contactPhone,
        "shipmentAdress": shipmentAdress,
        "shipmentLocation": shipmentLocation,
        "syncTime": syncTime.toIso8601String(),
        "ordID": ordId,
        "employees": List<dynamic>.from(employees.map((x) => x)),
        "jobs": List<dynamic>.from(jobs.map((x) => x.toJson())),
        "remoteStatus": ordId ?? 0,
      };
}

class Job {
  String jobId;
  String jobName;

  Job({
    this.jobId,
    this.jobName,
  });

  factory Job.fromJson(Map<String, dynamic> json) => Job(
        jobId: json["jobID"],
        jobName: json["jobName"],
      );

  Map<String, dynamic> toJson() => {
        "jobID": jobId,
        "jobName": jobName,
      };
}
