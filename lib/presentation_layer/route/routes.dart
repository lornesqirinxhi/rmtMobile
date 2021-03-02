import 'package:flutter/material.dart';
import 'package:rtm_template_one/presentation_layer/screens/shifts/check_truck.dart';
import 'package:rtm_template_one/presentation_layer/screens/login/login.dart';
import 'package:rtm_template_one/presentation_layer/screens/main/events.dart';
import 'package:rtm_template_one/presentation_layer/screens/main/mainpage.dart';

class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainPage.mainId:
        return MaterialPageRoute(builder: (_) => MainPage());
      case Login.loginId:
        return MaterialPageRoute(builder: (_) => Login());
      case CheckDevice.CheckDeviceId:
        return MaterialPageRoute(builder: (_) => CheckDevice());
      case Events.EventsId:
        return MaterialPageRoute(builder: (_) => Events());
      default:
        return MaterialPageRoute(builder: (_) => Login());
    }
  }
}