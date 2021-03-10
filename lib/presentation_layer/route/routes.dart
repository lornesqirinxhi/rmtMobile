import 'package:flutter/material.dart';
import 'package:rtm_template_one/presentation_layer/screens/login/login.dart';

import '../screens/map/maps.dart';

class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Login.loginId:
        return MaterialPageRoute(builder: (_) => Login());
      case MapDisplay.mapId:
        return MaterialPageRoute(builder: (_) => MapDisplay());
      default:
        return MaterialPageRoute(builder: (_) => Login());
    }
  }
}
