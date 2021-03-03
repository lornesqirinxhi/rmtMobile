import 'package:flutter/material.dart';
import 'package:rtm_template_one/constants/colors.dart';
import 'package:rtm_template_one/presentation_layer/config.dart';
class StaffMember extends StatelessWidget {
  final String name;
  final String initials;
  final bool status;
  final Function onTap;
  StaffMember({this.name, this.initials, this.status, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
          child: Container(
            height: 60,
            width: 220,
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
                border: Border.all(color: kMainYellow),
                borderRadius: BorderRadius.circular(30.0)
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: status ? Colors.green : Colors.red,
                    child: Text(initials, style: TextStyle(fontSize: 18, color: myTheme.currentTheme() ==  ThemeMode.dark ? Colors.white : Colors.black54  ),),
                  ),
                ),
                Text(name, style: TextStyle(fontSize: 18, color: kMainYellow),)
              ],
            ),
          )),
    );
  }
}
