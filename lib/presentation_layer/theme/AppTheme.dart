import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppTheme extends ChangeNotifier {
  static bool _isDark = true;

   ThemeMode currentTheme(){
     return _isDark == true ? ThemeMode.dark : ThemeMode.light;
  }
  bool getTheme(){
    return _isDark ;
  }
   void changeTheme(){
     _isDark = !_isDark;
     notifyListeners();
   }
}