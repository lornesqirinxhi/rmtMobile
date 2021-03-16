import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rtm_template_one/constants/style.dart';
import 'package:rtm_template_one/data_layer/app_data/MapData.dart';
import 'package:rtm_template_one/data_layer/models/AdrLocation.dart';
import 'package:rtm_template_one/logic_layer/maps/maps_logic.dart';
class MapSample extends StatefulWidget {
@override
State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController newGoogleMapController;
  Position currentPosition;
  Polyline polyline;
  void getCurrentPosition() async{
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
    currentPosition = position;
    LatLng latLng = LatLng(position.latitude, position.longitude);
    CameraPosition myCameraPosition = new CameraPosition(
        target: latLng,
        zoom: 14);
    newGoogleMapController.animateCamera(CameraUpdate.newCameraPosition(myCameraPosition));
    await getAddressByPosition(currentPosition);
  }
  void getDirection() async{
    AdrLocation adrLocation = Provider.of<MapData>(context).adrLocation;
    AdrLocation desLocation = Provider.of<MapData>(context).destinationLocation;
    LatLng latLng = LatLng(adrLocation.latitude, adrLocation.longitude);
    LatLng latLng2 = LatLng(desLocation.latitude, desLocation.longitude);

    var direction = await MapsLogic().obtainAddressDirection(latLng, latLng2);
    print(direction.encodedPoints);

  }

  Future<String> getAddressByPosition(Position position) async{
    var address;
    address = await MapsLogic().gAddressByPosition(position, context);
    return address;
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(41.3274055, 19.8213277),
    zoom: 14.4746,
  );



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Stack(
        children: [
        Container(
          child: GoogleMap(
            mapType: MapType.hybrid,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            zoomControlsEnabled: true,
            zoomGesturesEnabled: true,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              newGoogleMapController = controller;
              getCurrentPosition();
            },
          ),
        ),
          Positioned(
            left: 0,
              right: 0,
              bottom: 0,
              child: Container(height:100,
                  child: Align(alignment: Alignment.center,
                      child: Text(Provider.of<MapData>(context).adrLocation == null ? 'NO ADDRESS': Provider.of<MapData>(context).adrLocation.placeFormattedAddress, style: kMediumTextStyle,),
                  ),
              )
          )
        ] ,
      ),
    );
  }
}