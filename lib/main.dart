import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:rtm_template_one/constants/colors.dart';
import 'package:rtm_template_one/data_layer/local_database/database.dart';
import 'package:rtm_template_one/data_layer/repository/AuthRepo.dart';
import 'package:rtm_template_one/logic_layer/authentication/authentication_bloc.dart';
import 'package:rtm_template_one/logic_layer/internet/internet_cubit.dart';
import 'package:rtm_template_one/presentation_layer/config.dart';
import './presentation_layer/screens/login/login.dart';
import 'package:flutter/services.dart';
import 'package:fluro/fluro.dart';

import 'data_layer/app_data/MapData.dart';
import 'presentation_layer/screens/map/maps.dart';
import './presentation_layer/routes/application.dart';
import './presentation_layer/routes/routes.dart';

void main() {
  Connectivity connectivity;
  DatabaseHelper databaseHelper = databaseHelperConfig;
  runApp(MultiRepositoryProvider(
    providers: ([
      RepositoryProvider<AuthRepo>(create: (context) {
        return UserService();
      }),
    ]),
    child: MultiBlocProvider(providers: [
      BlocProvider<InternetCubit>(
        create: (BuildContext context) =>
            InternetCubit(connectivity: connectivity),
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
  _MyAppState() {
    final router = FluroRouter();
    Routes.configureRoutes(router);
    Application.router = router;
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    return ChangeNotifierProvider<MapData>(
      create: (context) => MapData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
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
        initialRoute: Routes.login,
        onGenerateRoute: Application.router.generator,
        home: BlocConsumer<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is AuthenticationAuthenticated) {
              return MapDisplay();
            } else if (state is AuthenticationLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is AuthenticationNotAuthenticated) {
              return Login();
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
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
