import 'package:flutter/material.dart';
import 'package:rtm_template_one/constants/strings.dart';
import 'package:rtm_template_one/presentation_layer/widget/event_card.dart';

class Events extends StatefulWidget {
  static const EventsId = 'events';
  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              EventCard(iconData: Icons.local_car_wash, title: accidentEvent, onEventPress: (){},),
              EventCard(iconData: Icons.traffic, title: trafficEvent, onEventPress: (){},),
              EventCard(iconData: Icons.taxi_alert, title: dangerEvent, onEventPress: (){},),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              EventCard(iconData: Icons.add_alert_rounded, title: sosEvent, onEventPress: (){},),
              EventCard(iconData: Icons.construction, title: constructionEvent, onEventPress: (){},),
            ],
          )
        ],
      ),
    );
  }
}
