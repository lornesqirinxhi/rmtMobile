import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:rtm_template_one/constants/style.dart';
import 'package:rtm_template_one/constants/app_constants.dart';
import 'package:rtm_template_one/constants/languages.dart';
import 'package:rtm_template_one/data_layer/repository/AuthRepo.dart';
import 'package:rtm_template_one/logic_layer/authentication/authentication_bloc.dart';
import 'package:rtm_template_one/logic_layer/internet/internet_cubit.dart';
import 'package:rtm_template_one/logic_layer/login/login_bloc.dart';
import 'package:rtm_template_one/presentation_layer/config.dart';
import 'package:rtm_template_one/presentation_layer/screens/login/login_face_tab.dart';
import 'package:rtm_template_one/presentation_layer/screens/login/login_pin_tab.dart';
import 'package:rtm_template_one/presentation_layer/screens/login/login_user_tab.dart';
import 'package:rtm_template_one/presentation_layer/widget/LoginBottomNav.dart';

import '../../../data_layer/app_data/MapData.dart';
import '../map/maps.dart';

class Login extends StatefulWidget {
  static const loginId = 'login';
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  int _selectedIndex = 0;
  bool showSpinner = false;
  static List<Widget> _widgetOptions = <Widget>[
    UserLogin(),
    PinLogin(),
    FaceLogin(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    InternetCubit intBloc = BlocProvider.of<InternetCubit>(context);
    AuthRepo authRepo = RepositoryProvider.of<AuthRepo>(context);
    // ignore: close_sinks
    AuthenticationBloc _authBloc = BlocProvider.of<AuthenticationBloc>(context);
    return BlocProvider<LoginBloc>(
      create: (BuildContext context) => LoginBloc(intBloc, authRepo, _authBloc),
      child: WillPopScope(
          onWillPop: _onBackPressed,
          child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              if (state is AuthenticationAuthenticated) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChangeNotifierProvider<MapData>(
                            create: (context) => MapData(),
                            child: MapDisplay())));
              }
            },
            builder: (context, state) {
              if (state is AuthenticationNotAuthenticated) {
                return Scaffold(
                    body: SafeArea(
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.asset(
                          'assets/images/rmt_logo.png',
                          scale: 5,
                        ),
                      ],
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 20, bottom: 20, right: 20),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(bottom: 1),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        (Languages().localizedValues[language])[
                                            'welcome'],
                                        style: kBigTextStyle),
                                    Switch(
                                      value: myTheme.getTheme(),
                                      onChanged: (newValue) {
                                        setState(() {});
                                        myTheme.changeTheme();
                                      },
                                      inactiveThumbImage: AssetImage(
                                          "assets/images/switch_sun.png"),
                                      activeThumbImage: AssetImage(
                                          "assets/images/switch_moon.png"),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                  child:
                                      _widgetOptions.elementAt(_selectedIndex)),
                              SizedBox(
                                height: 25,
                              ),
                              BlocConsumer<InternetCubit, InternetState>(
                                listener: (context, state) {
                                  if (state is InternetConnected) {
                                    final snackBar = SnackBar(
                                      content: Text('Internet Available'),
                                      duration: Duration(seconds: 3),
                                      behavior: SnackBarBehavior.floating,
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  } else {
                                    final snackBar = SnackBar(
                                      content:
                                          Text('Check Internet Connection!'),
                                      duration: Duration(seconds: 3),
                                      behavior: SnackBarBehavior.floating,
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  }
                                },
                                builder: (context, state) {
                                  if (state is InternetConnected) {
                                    return Text('');
                                  } else {
                                    return Text('');
                                  }
                                },
                              ),
                              Divider(
                                height: 1,
                                thickness: 1,
                              ),
                            ]),
                      ),
                    ),
                    LoginBottomNav(
                      selectedIndex: _selectedIndex,
                      onTap: _onItemTapped,
                    )
                  ]),
                ));
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          )),
    );
  }

  Future<bool> _onBackPressed() {
    SystemNavigator.pop();
    return Future.value(true);
  }
}
