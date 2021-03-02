import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rtm_template_one/data_layer/models/AdrLocation.dart';


class MapServices  {

  Future<dynamic> getAddressByPosition(String url) async {
    http.Response response = await http.get(url);
    try {
      if (response.statusCode == 200) {
        var  address = jsonDecode(response.body);
        return address;
      } else {
        return 'Failed';
      }
    } catch (e) {
      return 'Failed';
    }
  }
}
