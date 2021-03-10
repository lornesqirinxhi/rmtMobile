import 'package:flutter/material.dart';

import '../../data_layer/models/AdrLocation.dart';

class MapData extends ChangeNotifier {
  AdrLocation adrLocation;
  AdrLocation destinationLocation;

  void updatePickupLocation(AdrLocation newAdrLocation) {
    adrLocation = newAdrLocation;
    destinationLocation = newAdrLocation;
    notifyListeners();
  }
}
