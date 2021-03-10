import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:rtm_template_one/data_layer/app_data/MapData.dart';
import 'package:rtm_template_one/data_layer/models/AdrLocation.dart';
import 'package:rtm_template_one/data_layer/repository/MapRepo.dart';
import 'package:rtm_template_one/presentation_layer/config.dart';

class MapsLogic {
  Future<dynamic> gAddressByPosition(
      Position position, BuildContext context) async {
    var baseUrl = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=';
    String url =
        '$baseUrl${position.latitude},${position.longitude}&key=$mapKey';
    var response = await MapServices().getAddressByPosition(url);
    if (response != 'Failed') {
      AdrLocation adrLocation = new AdrLocation();
      adrLocation.longitude = position.longitude;
      adrLocation.latitude = position.latitude;
      adrLocation.placeFormattedAddress =
          response['results'][0]['formatted_address'];
      adrLocation.placeName = response['results'][0]['formatted_address'];
      adrLocation.placeId = response['results'][0]['place_id'];

      Provider.of<MapData>(context, listen: false)
          .updatePickupLocation(adrLocation);
      return adrLocation;
    } else {
      return 'Failed';
    }
  }
}
