import 'package:flutter/cupertino.dart';
import 'package:rtm_template_one/data_layer/models/AdrLocation.dart';

class MapData extends ChangeNotifier{
  AdrLocation adrLocation;
  AdrLocation destinationLocation;

  void updatePickupLocation(AdrLocation newAdrLocation){
    adrLocation = newAdrLocation;
    destinationLocation = newAdrLocation;
    notifyListeners();
  }
}