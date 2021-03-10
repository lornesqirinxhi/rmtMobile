import 'package:http/http.dart' as http;

import '../../data_layer/models/User.dart';

abstract class AuthRepo {
  Future<User> getUser();
}

class UserService implements AuthRepo {
  static const _baseUrl = 'jsonplaceholder.typicode.com';
  static const String _GET_USER = '/users';
  @override
  Future<User> getUser() async {
    Uri uri = Uri.https(_baseUrl, _GET_USER);
    http.Response response = await http.get(uri);
    User user = userFromJson(response.body).first;
    return user;
  }
}
