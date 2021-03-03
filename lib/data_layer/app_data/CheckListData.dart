import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:rtm_template_one/constants/strings.dart';

class CheckListData extends ChangeNotifier {
  List<CheckItem> list = [
    CheckItem(
        name: fireExtinguisher,
        iconData: Icons.fire_extinguisher,
        status: false),
    CheckItem(name: flag, iconData: Icons.flag, status: false),
    CheckItem(name: panelPVM, iconData: Icons.tv, status: false),
    CheckItem(
        name: fireExtinguisher,
        iconData: Icons.fire_extinguisher,
        status: false),
    CheckItem(name: flag, iconData: Icons.flag, status: false),
    CheckItem(name: panelPVM, iconData: Icons.tv, status: false),
  ];

  UnmodifiableListView<CheckItem> get checkItems => UnmodifiableListView(list);
  int get checkItemCount => list.length;

  void updateItemStatus(CheckItem checkItem, bool status) {
    checkItem.status = status;
    notifyListeners();
  }
}

class CheckItem {
  String name;
  IconData iconData;
  bool status;

  CheckItem({this.name, this.iconData, this.status});

  void toggleStatus() {
    status = !status;
  }
}
