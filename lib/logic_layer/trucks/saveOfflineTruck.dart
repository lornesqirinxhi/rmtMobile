import 'package:rtm_template_one/data_layer/local_database/database.dart';
import 'package:rtm_template_one/data_layer/models/Truck.dart';
import 'package:rtm_template_one/data_layer/models/TruckData.dart';
import 'package:rtm_template_one/data_layer/repository/TruckRepo.dart';

class OfflineTruck {
  final DatabaseHelper databaseHelper;
  final TruckRepo truckRepo;
  OfflineTruck({this.databaseHelper, this.truckRepo});

  Future<bool> checkData() async {
    List<Truck> lst = await databaseHelper.trucks();
    //List<Truck> lst = TruckData().lstTruck;
    if (lst.isNotEmpty) {
      try {
        await saveOnline(lst);
        print('Internet Connected and Data Ready to upload');
        return true;
      } catch (e) {
        print(e);
        return false;
      }
    } else {
      return false;
    }
  }

  Future<String> saveOnline(List<Truck> list) async {
    for (var i = 0; i <= list.length - 1; i++) {
      try {
        //databaseHelper.insertTruck(list[i]);
        // truckRepo.postTruck(list[i]);
      } catch (e) {}
    }
    String response = '';

    return response;
  }

  Future<String> saveOffline() async {
    String response = '';

    return response;
  }
}
