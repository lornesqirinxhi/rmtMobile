import 'package:flutter/material.dart';
import 'package:rtm_template_one/constants/style.dart';

class ActivityListItem extends StatelessWidget {
  final String title;
  final String desc;
  final IconData typeIcon;
  final String priority;
  final String status;

  ActivityListItem(
      {this.title, this.desc, this.typeIcon, this.priority, this.status});

  @override
  Widget build(BuildContext context) {
    Color color;
    switch (status) {
      case 'Done':
        color = Color(0xFF5A8873);
        break;
      case 'In progress':
        color = Colors.yellow;
        break;
      case 'To Do':
        color = Colors.redAccent;
        break;
      default:
        color = Colors.grey;
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Icon(
                  priority == 'Important'
                      ? Icons.double_arrow_rounded
                      : Icons.arrow_forward_ios_rounded,
                  size: 70,
                ),
              )),
          Expanded(
            flex: 3,
            child: ListTile(
              title: Text(
                title,
                style: kMediumTextStyle20,
              ),
              subtitle: Text(
                desc,
                style: kSmallTextStyleGrey15,
              ),
            ),
          ),
          Expanded(
              flex: 1,
              child: Icon(
                typeIcon,
                size: 30,
              )),
          Expanded(
            flex: 1,
            child: Container(
              width: 60,
              decoration: BoxDecoration(
                  color: color, borderRadius: BorderRadius.circular(15)),
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  status,
                ),
              )),
            ),
          )
        ],
      ),
    );
  }
}
