import 'package:flutter/material.dart';
import 'package:rtm_template_one/constants/colors.dart';
class CheckListViewItem extends StatelessWidget {
  final String name;
  final IconData iconData;
  final Color colors;
  final Color bckColor;

  CheckListViewItem({this.name, this.iconData, this.colors, this.bckColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bckColor,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Material(
          elevation: 2,
          borderRadius: BorderRadius.circular(15.0),
          color: colors,
          child: Container(
            height: 150,
            width: 130,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  iconData,
                  size: 30,
                  color: kMainYellow,
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 100),
                    child: Text(
                      name,
                      style: TextStyle(
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
