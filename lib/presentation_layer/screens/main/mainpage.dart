import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rtm_template_one/data_layer/local_database/database.dart';
import 'package:rtm_template_one/logic_layer/authentication/authentication_bloc.dart';
import 'package:rtm_template_one/logic_layer/internet/internet_cubit.dart';
import 'package:rtm_template_one/presentation_layer/InternetConnectionCheck.dart';
import 'package:rtm_template_one/presentation_layer/screens/main/activity_list.dart';
import 'package:rtm_template_one/presentation_layer/screens/main/truck_list.dart';
import 'package:rtm_template_one/presentation_layer/screens/login/login.dart';
import 'package:rtm_template_one/presentation_layer/screens/main/events.dart';
import 'package:rtm_template_one/presentation_layer/screens/shifts/chosen_truck.dart';
import 'package:rtm_template_one/presentation_layer/widget/MainBottomNav.dart';
import '../../config.dart';

class MainPage extends StatefulWidget {
  static const mainId = 'main';
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[ActivityList(), TruckList(), TruckList(), TruckList()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    DatabaseHelper databaseHelper = databaseHelperConfig;
    InternetConnectionCheck().checkInternet().listen((value) {
      if (value == 'Connected') {
      //  OfflineTruck offlineTruck = new OfflineTruck(
       //     databaseHelper: databaseHelper,
       //     truckRepo: RepositoryProvider.of<TruckRepo>(context));
        //offlineTruck.checkData();
        print(value);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final AuthenticationBloc authenticationBloc =
        BlocProvider.of<AuthenticationBloc>(context);
    //DatabaseHelper databaseHelper = databaseHelperConfig;
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
      if (state is AuthenticationNotAuthenticated) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()),);
      }
    }, builder: (context, state) {
      if (state is AuthenticationAuthenticated) {
        return BlocListener<InternetCubit, InternetState>(
          listenWhen: (previous, current) {
            if (previous == current) {
              return false;
            } else {
              return true;
            }
          },
          listener: (context, state) async {
            if (state is InternetConnected) {
              // OfflineTruck offlineTruck = new OfflineTruck(databaseHelper:databaseHelper, truckRepo:RepositoryProvider. of<TruckRepo>(context));
              // await offlineTruck.checkData();

            }
          },
          child: WillPopScope(
            onWillPop: _onBackPressed,
            child: Scaffold(

              appBar: AppBar(leading: Container() ,actions: [
                Row(
                  children: <Widget>[
                    Material(
                      elevation: 2,
                      child: Switch(
                        value: myTheme.getTheme(),
                        onChanged: (newValue) {
                          setState(() {});
                          myTheme.changeTheme();
                        },
                        inactiveThumbImage:
                            AssetImage("assets/images/switch_sun.png"),
                        activeThumbImage:
                            AssetImage("assets/images/switch_moon.png"),
                      ),
                    ),
                    Material(
                        elevation: 2,
                        child: IconButton(
                            icon: Icon(Icons.notifications),
                            onPressed: () => {})),
                    Material(
                        elevation: 2,
                        child: IconButton(
                            icon: Icon(Icons.logout),
                            onPressed: () {
                              authenticationBloc.add(UserLoggedOut());
                            }))
                  ],
                ),
              ]),
              body:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: _widgetOptions.elementAt(_selectedIndex),
                    ),
                  ],
                ),

              bottomNavigationBar: MainBottomNav(selectedIndex: _selectedIndex, onTap: _onItemTapped),
            ),
          ),
        );
      } else {
        return Login();
      }
    });
  }

  Future<bool> _onBackPressed() {
    SystemNavigator.pop();
    return Future.value(true);
  }
}
