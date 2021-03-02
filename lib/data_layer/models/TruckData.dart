import 'package:rtm_template_one/data_layer/models/Truck.dart';

class TruckData{
  List<Truck> lstTruck = [
    new Truck(
        id: 1,
        truckName: 'Truck 1',
        truckNumber: 'HF22321',
        driver: 'D.Dishnica',
        status: 'Free',
        truckType: 'Big'),
    new Truck(
        id: 2,
        truckName: 'Truck 1231',
        truckNumber: 'HF22321',
        driver: 'L.Qirinxhi',
        status: 'Free',
        truckType: 'Big'),
    new Truck(
        id: 3,
        truckName: 'Truck 412',
        truckNumber: 'HF222321',
        driver: 'Xh.Mecollari',
        status: 'Busy',
        truckType: 'Small')
  ];
}