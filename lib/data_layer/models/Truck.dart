import 'package:flutter/foundation.dart';

import 'dart:convert';
List<Truck> truckFromJson(String str) =>
    List<Truck>.from(json.decode(str).map((x) => Truck.fromMap(x)));

String truckToJson(List<Truck> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));
class Truck {
  final int id;
  final String truckName;
  final String truckNumber;
  final String driver;
  final String status;
  final String truckType;

  Truck(
      {this.id,
      this.truckName,
      this.truckNumber,
      this.driver,
      this.status,
      this.truckType});

  factory Truck.fromMap(Map<String, dynamic> map) {
    return new Truck(
      id: map['id'] as int,
      truckName: map['truckName'] as String,
      truckNumber: map['truckNumber'] as String,
      driver: map['driver'] as String,
      status: map['status'] as String,
      truckType: map['truckType'] as String,
    );
  }
  factory Truck.fromJson(Map<String, dynamic> json) {
    return Truck(
      id: json['id'] as int,
      truckName: json['truckName'] as String,
      truckNumber: json['truckNumber'] as String,
      driver: json['driver'] as String,
      status: json['status'] as String,
      truckType: json['truckType'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'id': this.id,
      'truckName': this.truckName,
      'truckNumber': this.truckNumber,
      'driver': this.driver,
      'status': this.status,
      'truckType': this.truckType,
    } as Map<String, dynamic>;
  }
}