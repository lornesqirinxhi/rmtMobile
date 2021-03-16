import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rtm_template_one/constants/colors.dart';
import 'package:rtm_template_one/data_layer/app_data/ActivityData.dart';
import 'package:rtm_template_one/data_layer/app_data/MapData.dart';
import 'package:rtm_template_one/presentation_layer/screens/main/events.dart';
import 'package:rtm_template_one/presentation_layer/screens/map/maps.dart';
import 'package:rtm_template_one/presentation_layer/widget/activity_list_item.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rtm_template_one/constants/style.dart';
import 'package:rtm_template_one/data_layer/models/AdrLocation.dart';
import 'package:rtm_template_one/logic_layer/maps/maps_logic.dart';
import '../../InternetConnectionCheck.dart';

class ActivityList extends StatefulWidget {
  @override
  _ActivityListState createState() => _ActivityListState();
}

class _ActivityListState extends State<ActivityList> {
  //TODO Add ActivityList to AppData
  List<ActivityItem> lstActivity;
  bool _mapVisibility = false;
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
  void initState() {
    // TODO: implement initState
    super.initState();
    lstActivity = ActivityData().activityList;
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
        stream: InternetConnectionCheck().checkInternet(),
        initialData: 'Connected',
        builder: (context, snapshot) {
          if (snapshot.data == 'Connected') {
            return Scaffold(
              body: Column(children: [
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Material(
                            elevation: 2,
                            child: IconButton(
                                icon: Icon(Icons.search), onPressed: () => {})),
                      ),
                      Expanded(
                        child: Material(
                          elevation: 2,
                          child: IconButton(
                            icon: Icon(
                              Icons.swap_vert,
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 9,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                            flex: 1,
                            child: ListView.builder(
                                padding: const EdgeInsets.all(8),
                                itemCount: lstActivity.length,
                                itemBuilder: (BuildContext context, int index) {
                                  //TODO Add parameters to ActivityListItem
                                  return ActivityListItem(
                                    title: lstActivity[index].title,
                                    desc: lstActivity[index].desc,
                                    priority: lstActivity[index].priority,
                                    typeIcon:  lstActivity[index].type,
                                    status: lstActivity[index].status,
                                  );
                                })),
                        Visibility(
                          visible: _mapVisibility,
                          child: Expanded(
                              flex: 1,
                              child: Stack(
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
                              )),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _mapVisibility = !_mapVisibility;
                            });
                          },
                          child: Container(
                            width: 40,
                            color: Colors.grey,
                            child: Center(
                              child: Icon(
                                Icons.map,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        )
                      ]),
                ),
              ]),
              floatingActionButton: FloatingActionButton(
                  child: Icon(Icons.add),
                  backgroundColor: kMainYellow,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Events()));
                  }),
            );
          } else {
            return AlertDialog(
              title: Text('No Internet'),
            );
          }
        });
  }
}


