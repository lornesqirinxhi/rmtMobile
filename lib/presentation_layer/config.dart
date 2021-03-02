import 'package:flutter/material.dart';
import 'package:rtm_template_one/data_layer/local_database/database.dart';
import 'package:rtm_template_one/presentation_layer/theme/AppTheme.dart';

AppTheme myTheme = AppTheme();
DatabaseHelper databaseHelperConfig =  DatabaseHelper.instance;

String mapKey = 'AIzaSyB4JnSEqdvpOI2RxH1iRho-QnBL2XkT1gg';

GlobalKey<NavigatorState>  pageNavigatorKey = new GlobalKey<NavigatorState>();