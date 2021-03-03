import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:rtm_template_one/constants/colors.dart';
import 'package:rtm_template_one/data_layer/app_data/MapData.dart';
import 'package:rtm_template_one/data_layer/local_database/database.dart';
import 'package:rtm_template_one/data_layer/models/Truck.dart';
import 'package:rtm_template_one/data_layer/models/TruckData.dart';
import 'package:rtm_template_one/data_layer/repository/TruckRepo.dart';
import 'package:rtm_template_one/logic_layer/trucks/saveOfflineTruck.dart';
import 'package:rtm_template_one/presentation_layer/InternetConnectionCheck.dart';
import 'package:rtm_template_one/presentation_layer/config.dart';
import 'package:rtm_template_one/presentation_layer/screens/shifts/check_truck.dart';
import 'package:rtm_template_one/presentation_layer/screens/map/maps.dart';
import 'package:rtm_template_one/presentation_layer/screens/main/events.dart';
import 'package:rtm_template_one/presentation_layer/widget/truck_listTile.dart';

class TruckList extends StatefulWidget {


  @override
  _TruckListState createState() => _TruckListState();
}

class _TruckListState extends State<TruckList> with AutomaticKeepAliveClientMixin {
  List<Truck> lstTruck;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     lstTruck = TruckData().lstTruck;
  }


  @override
  Widget build(BuildContext context) {
     super.build(context);
     return StreamBuilder<String>(
       stream: InternetConnectionCheck().checkInternet(),
       initialData: 'Connected',
       builder: (context, snapshot) {
         if(snapshot.data == 'Connected'){
           DatabaseHelper databaseHelper = databaseHelperConfig;
           OfflineTruck offlineTruck = new OfflineTruck(databaseHelper:databaseHelper, truckRepo:RepositoryProvider. of<TruckRepo>(context));
           offlineTruck.checkData();
           return Scaffold(
             body: Column(children: [
               Row(
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
                             icon: Icon(Icons.qr_code_scanner),
                             onPressed: () => {})),
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
                   Expanded(
                     child: Material(
                       elevation: 2,
                       child: IconButton(
                         icon: Icon(
                           Icons.map,
                         ),
                         onPressed: () {
                           Navigator.push(context,
                               MaterialPageRoute(builder: (context) => ChangeNotifierProvider(create:(context) => MapData(),child: MapSample())));
                         },
                       ),
                     ),
                   ),
                 ],
               ),
               Expanded(
                   child: ListView.builder(
                       padding: const EdgeInsets.all(8),
                       itemCount: lstTruck.length,
                       itemBuilder: (BuildContext context, int index) {
                         return TruckListTile(
                           iconData: lstTruck[index].truckType == 'Big'
                               ? Icons.drive_eta
                               : Icons.local_car_wash,
                           truckName: lstTruck[index].truckName,
                           truckNumber: lstTruck[index].truckNumber,
                           status: lstTruck[index].status,
                           driver: lstTruck[index].driver,
                           onTap: lstTruck[index].status == 'Free' ? (){ Navigator.push(context, MaterialPageRoute(builder: (context) => CheckDevice()));} : (){print('S');},
                         );
                       })),
             ]),
             floatingActionButton: FloatingActionButton(
                 child: Icon(Icons.add),
                 backgroundColor: kMainYellow,
                 onPressed: () {
                   Navigator.push(
                       context, MaterialPageRoute(builder: (context) => Events()));
                 }),
           );
         }
         else {
           return AlertDialog(title: Text('No Internet'),);
         }

       }
     );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
