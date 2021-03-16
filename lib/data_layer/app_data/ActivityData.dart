import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:rtm_template_one/constants/strings.dart';

class ActivityData extends ChangeNotifier {
  List<ActivityItem> activityList = [
    ActivityItem(title: 'Activity Title', desc: 'Activity Desc 1 bla bla bla', priority: 'Important', status: 'In progress', type: Icons.timer),
    ActivityItem(title: 'Activity Title 2', desc: 'Activity Desc bla bla bla', priority: 'Regular', status: 'To Do', type: Icons.timer),
    ActivityItem(title: 'Activity Title 3', desc: 'Activity Desc bla bla bla', priority: 'Important', status: 'Done', type: Icons.calendar_today_outlined),
    ActivityItem(title: 'Activity Title 4', desc: 'Activity Desc bla bla bla', priority: 'Regular', status: 'Done', type: Icons.timer),
    ActivityItem(title: 'Activity Title 5', desc: 'Activity Desc bla bla bla', priority: 'Important', status: 'Done', type: Icons.calendar_today_outlined),
  ];

  UnmodifiableListView<ActivityItem> get activityItems => UnmodifiableListView(activityList);
  int get activityItemCount => activityList.length;

  void updateItemStatus(ActivityItem activityItem, String status) {
    activityItem.status = status;
    notifyListeners();
  }
}

class ActivityItem {
  final String title;
  final String desc;
  final IconData type;
  final String priority;
  String status;

  ActivityItem(
      {this.title,
      this.desc,
      this.type,
      this.priority,
      this.status});

}
