import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rtm_template_one/constants/style.dart';
import 'package:rtm_template_one/data_layer/app_data/MapData.dart';
import 'package:rtm_template_one/logic_layer/maps/maps_logic.dart';
import 'package:rtm_template_one/presentation_layer/routes/application.dart';
import 'package:rtm_template_one/presentation_layer/routes/routes.dart';

import '../../../logic_layer/authentication/authentication_bloc.dart';
import '../../config.dart';

class MapDisplay extends StatefulWidget {
  @override
  State<MapDisplay> createState() => MapDisplayState();
}

class MapDisplayState extends State<MapDisplay> {
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController newGoogleMapController;
  Position currentPosition;
  Polyline polyline;
  void getCurrentPosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    currentPosition = position;
    LatLng latLng = LatLng(position.latitude, position.longitude);
    CameraPosition myCameraPosition =
        new CameraPosition(target: latLng, zoom: 14);
    newGoogleMapController
        .animateCamera(CameraUpdate.newCameraPosition(myCameraPosition));
    await getAddressByPosition(currentPosition);
  }

  Future<String> getAddressByPosition(Position position) async {
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
    final AuthenticationBloc authenticationBloc =
        BlocProvider.of<AuthenticationBloc>(context);
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationNotAuthenticated) {
          Application.router.navigateTo(context, Routes.login, replace: true);
        }
      },
      builder: (context, state) {
        if (state is AuthenticationAuthenticated) {
          return new Scaffold(
            appBar: AppBar(leading: Container(), actions: [
              Row(
                children: <Widget>[
                  Material(
                    elevation: 2,
                    child: Switch(
                      value: myTheme.getTheme(),
                      onChanged: (newValue) {
                        setState(() {});
                        myTheme.changeTheme();
                      },
                      inactiveThumbImage:
                          AssetImage("assets/images/switch_sun.png"),
                      activeThumbImage:
                          AssetImage("assets/images/switch_moon.png"),
                    ),
                  ),
                  Material(
                      elevation: 2,
                      child: IconButton(
                          icon: Icon(Icons.notifications),
                          onPressed: () => {})),
                  Material(
                      elevation: 2,
                      child: IconButton(
                          icon: Icon(Icons.logout),
                          onPressed: () {
                            authenticationBloc.add(UserLoggedOut());
                          }))
                ],
              ),
            ]),
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
                    child: Container(
                      height: 100,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          Provider.of<MapData>(context).adrLocation == null
                              ? 'NO ADDRESS'
                              : Provider.of<MapData>(context)
                                  .adrLocation
                                  .placeFormattedAddress,
                          style: kMediumTextStyle,
                        ),
                      ),
                    ))
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
