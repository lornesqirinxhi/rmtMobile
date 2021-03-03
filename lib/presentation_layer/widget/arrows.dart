import 'package:flutter/material.dart';
import 'package:rtm_template_one/constants/colors.dart';
class Arrows extends StatelessWidget {
  final IconData arrow;
  final Function previousCheck;

  Arrows({this.arrow, this.previousCheck});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: previousCheck,
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Container(
          width: 50,
          child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.transparent,
              child: Icon(
                arrow,
                color: kMainYellow,
              )),
          decoration: new BoxDecoration(
            shape: BoxShape.circle,
            border: new Border.all(
              color: kMainYellow,
              width: 2.0,
            ),
          ),
        ),
      ),
    );
  }
}
