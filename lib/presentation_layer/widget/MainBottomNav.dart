import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart.';
import 'package:rtm_template_one/constants/colors.dart';
class MainBottomNav extends StatelessWidget {
  final int selectedIndex;
  final Function onTap;

  MainBottomNav({this.selectedIndex, this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
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
      currentIndex: selectedIndex,
      showUnselectedLabels: false,
      showSelectedLabels: false,
      elevation: 0,
      selectedItemColor: kMainYellow,
      onTap: onTap,
    );
  }
}
