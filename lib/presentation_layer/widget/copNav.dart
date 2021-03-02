import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rtm_template_one/constants/colors.dart';
import 'package:rtm_template_one/presentation_layer/screens/shifts/check_truck.dart';
import 'package:rtm_template_one/presentation_layer/screens/main/truck_list.dart';
class CupertinoStoreHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        activeColor: kMainYellow,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.directions_car,
                size: 40,
              ),
              label: 'wheel'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                size: 40,
              ),
              label: 'setting'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.calendar_today_outlined,
                size: 40,
              ),
              label: 'calendar'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.directions_car,
                size: 40,
              ),
              label: 'FACE'),
        ],
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: TruckList(),
              );
            });
          case 1:
            return CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: CheckDevice(),
              );
            });
          case 2:
            return CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: TruckList(),
              );
            });
          default: return CupertinoTabView(builder: (context) {
            return CupertinoPageScaffold(
              child: TruckList(),
            );
          });
        }
      },
    );
  }
}