import 'package:flutter/material.dart';

import '../data_layer/local_database/database.dart';
import '../presentation_layer/theme/AppTheme.dart';

AppTheme myTheme = AppTheme();
DatabaseHelper databaseHelperConfig = DatabaseHelper.instance;

String mapKey = 'AIzaSyB4JnSEqdvpOI2RxH1iRho-QnBL2XkT1gg';

GlobalKey<NavigatorState> pageNavigatorKey = new GlobalKey<NavigatorState>();
