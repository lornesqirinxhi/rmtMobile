import 'package:flutter/material.dart';
import 'package:rtm_template_one/constants/colors.dart';
import 'package:rtm_template_one/constants/style.dart';
class EventCard extends StatelessWidget {
  final IconData iconData;
  final String title;
  final Function onEventPress;

  EventCard({this.iconData, this.title, this.onEventPress});

  @override
  Widget build(BuildContext context) {

    return  GestureDetector(
      onTap: onEventPress,
      child: SizedBox(
        width: 130.0,
        height: 100.0,
        child: Card(
           elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Icon(iconData, size: 30, color: kMainYellow,),
                SizedBox(height: 10,),
                Text(title, style: kSmallTextStyle,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
