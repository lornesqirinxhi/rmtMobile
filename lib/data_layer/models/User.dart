import 'package:flutter/foundation.dart';

import 'dart:convert';
List<User> userFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  final String name;
  final String email;

  User({@required this.name, @required this.email});

  @override
  String toString() => 'User { name: $name, email: $email}';

  factory User.fromJson(Map<String, dynamic> map) {
    return new User(
      name: map['name'] as String,
      email: map['email'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    // ignore: unnecessary_cast
    return {
      'username': this.name,
      'email': this.email,
    } as Map<String, dynamic>;
  }

}