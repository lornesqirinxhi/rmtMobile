import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import '../screens/login/login.dart';
import '../screens/map/maps.dart';

var rootHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return Login();
});

var loginHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
        Login());
var mapHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
        MapDisplay());
