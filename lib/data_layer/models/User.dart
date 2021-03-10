import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'dart:convert';

List<User> userFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  final String name;
  final String email;
  bool auth;
  final String initials;

  User({@required this.name, @required this.email, this.auth, this.initials});

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

class UserData extends ChangeNotifier {
  List<User> list = [
    User(name: 'Lornes Qirinxhi', initials: 'LQ', auth: false),
    User(name: 'Daniel Dishnica', initials: 'DD', auth: false),
    User(name: 'Ermand Hoxha', initials: 'EH', auth: false),
    User(name: 'Nikolina Kote', initials: 'NK', auth: false),
    User(name: 'Ardit Musaku', initials: 'AM', auth: false),
    User(name: 'Tea Mileti', initials: 'TM', auth: false),
  ];

  UnmodifiableListView<User> get users => UnmodifiableListView(list);
  int get userCount => list.length;

  void updateItemStatus(User user, bool status) {
    user.auth = status;
    notifyListeners();
  }
}
