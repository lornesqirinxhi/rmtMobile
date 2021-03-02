import 'dart:convert';


import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:rtm_template_one/data_layer/models/Truck.dart';
abstract class TruckRepo {
  postTruck(Truck truck);
  getTruck();
}
class TruckService extends TruckRepo {
  static const _baseUrl = 'jsonplaceholder.typicode.com';
  static const String _POST_TRUCK = '/posts';
  static const String _GET_TRUCK = '/posts';

  @override
  Future<Truck> postTruck(Truck truck) async {
    final response = await http.post(
      Uri.https(_baseUrl, _POST_TRUCK),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(truck.toMap()),
    );
    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return Truck.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to load trucks');
    }
  }
  @override
  Future<List<Truck>> getTruck() async {
    Uri uri = Uri.https(_baseUrl, _GET_TRUCK);
    Response response = await http.get(uri);
    List<Truck> trucks = truckFromJson(response.body);
    return trucks;
  }
}