import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:rtm_template_one/constants/colors.dart';
import 'package:rtm_template_one/data_layer/local_database/database.dart';
import 'package:rtm_template_one/data_layer/repository/AuthRepo.dart';
import 'package:rtm_template_one/data_layer/repository/TruckRepo.dart';
import 'package:rtm_template_one/logic_layer/authentication/authentication_bloc.dart';
import 'package:rtm_template_one/logic_layer/internet/internet_cubit.dart';
import 'package:rtm_template_one/logic_layer/trucks/trucks_cubit.dart';
import 'package:rtm_template_one/presentation_layer/config.dart';
import 'package:rtm_template_one/presentation_layer/screens/shifts/auth_presence.dart';
import 'package:rtm_template_one/presentation_layer/screens/shifts/check_truck.dart';
import 'package:rtm_template_one/presentation_layer/screens/main/events.dart';
import 'package:rtm_template_one/presentation_layer/screens/main/mainpage.dart';
import 'package:rtm_template_one/presentation_layer/screens/shifts/chosen_truck.dart';
import 'package:rtm_template_one/presentation_layer/screens/shifts/staff.dart';
import 'file:///C:/Users/User/AndroidStudioProjects/rtm_template_one/lib/presentation_layer/screens/login/login.dart';
import 'package:rtm_template_one/presentation_layer/theme/AppTheme.dart';
import 'package:flutter/services.dart';
import 'package:rtm_template_one/presentation_layer/route/routes.dart';
void main() {
  Connectivity connectivity;
  DatabaseHelper databaseHelper = databaseHelperConfig;
  runApp(MultiRepositoryProvider(
    providers: ([
      RepositoryProvider<AuthRepo>(create: (context) {
        return UserService();
      }),
      RepositoryProvider<TruckRepo>(create: (context) {
        return TruckService();
      }),
    ]),
    child: MultiBlocProvider(providers: [
      BlocProvider<InternetCubit>(
        create: (BuildContext context) =>
            InternetCubit(connectivity: connectivity),
      ),
      BlocProvider<TrucksCubit>(
        create: (BuildContext context) => TrucksCubit(databaseHelper),
      ),
      BlocProvider<AuthenticationBloc>(
        create: (BuildContext context) {
          final authService = RepositoryProvider.of<AuthRepo>(context);
          return AuthenticationBloc(authService, databaseHelper)
            ..add(AppLoaded());
        },
      ),
    ], child: MyApp()),
  ));
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.


  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
   
    return MaterialApp(
      title: 'RMT',
      theme: myTheme.currentTheme() == ThemeMode.dark
          ? ThemeData(
              primaryColor: kMainBlack,
              brightness: Brightness.dark,
              textTheme: ThemeData.dark().textTheme.apply(
                    bodyColor: Colors.grey,
                    displayColor: Colors.grey,
                  ))
          : ThemeData(
              backgroundColor: Colors.white,
              brightness: Brightness.light,
              primaryColor: Colors.white),
      initialRoute: Login.loginId,
      routes: {
        Login.loginId : (context) => Login(),
        MainPage.mainId : (context) => MainPage(),
        ChooseTruck.chooseTruckId: (context) => ChooseTruck(),
        CheckDevice.CheckDeviceId : (context) => CheckDevice(),
        Events.EventsId : (context) => Events(),
        Staff.staffId : (context) => Staff(),
        AuthenticatePresence.authPresenceId : (context) => AuthenticatePresence()
      },

      home: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is AuthenticationAuthenticated) {
            return ChooseTruck();
          } else if (state is AuthenticationLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is AuthenticationNotAuthenticated) {
            return Login();
          } else {
            return Center(
            child: CircularProgressIndicator(),
          );}

        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    myTheme.addListener(() {
      setState(() {});
    });
  }
}
