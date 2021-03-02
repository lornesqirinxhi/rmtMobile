import 'package:flutter/material.dart';
import 'package:rtm_template_one/constants/colors.dart';
class LoginBottomNav extends StatelessWidget {
  final int selectedIndex;
  final Function onTap;

  LoginBottomNav({this.selectedIndex, this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              size: 40,
            ),
            label: 'USER'),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.dialpad,
              size: 40,
            ),
            label: 'PIN'),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.remove_red_eye,
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
