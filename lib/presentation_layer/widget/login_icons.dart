import 'package:flutter/material.dart';

class LoginIcons extends StatelessWidget {
  final IconData iconData;

  LoginIcons({this.iconData});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {},
        child: Icon(
          iconData,
          size: 40,
        ));
  }
}
