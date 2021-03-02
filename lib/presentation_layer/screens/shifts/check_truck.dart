import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rtm_template_one/constants/colors.dart';
import 'package:rtm_template_one/constants/strings.dart';
import 'package:rtm_template_one/constants/style.dart';
import 'package:rtm_template_one/logic_layer/authentication/authentication_bloc.dart';
import 'package:rtm_template_one/presentation_layer/screens/main/mainpage.dart';

import '../../config.dart';

class CheckDevice extends StatefulWidget {
  static const CheckDeviceId = 'check';
  final String deviceId;

  CheckDevice({this.deviceId});

  @override
  _CheckDeviceState createState() => _CheckDeviceState();
}

class _CheckDeviceState extends State<CheckDevice> {

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final AuthenticationBloc authenticationBloc =
    BlocProvider.of<AuthenticationBloc>(context);
    return Scaffold(
      appBar: AppBar(actions: [
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
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              flex: 2,
              child: Material(
                elevation: 10,
                child: Column(
                  children: [
                    Expanded(
                        flex: 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: Icon(
                                Icons.drive_eta,
                                size: 60,
                                color: kMainYellow,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: Text(
                                "Truck Nr.1",
                                style: TextStyle(
                                    fontWeight: FontWeight.w900, fontSize: 25),
                              ),
                            ),
                            Text(
                              "98-665-IT",
                              style: TextStyle(
                                  fontWeight: FontWeight.w900, fontSize: 15),
                            )
                          ],
                        )),
                    Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "0/6",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              "Checked",
                              style: TextStyle(
                                  fontWeight: FontWeight.w900, fontSize: 20),
                            )
                          ],
                        ))
                  ],
                ),
              )),
          Expanded(
              flex: 6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(25),
                        child: Container(
                          width: 50,
                          child: CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.transparent,
                              child: Icon(
                                Icons.arrow_back,
                                color: kMainYellow,
                              )),
                          decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            border: new Border.all(
                              color: kMainYellow,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                      Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(25.0),
                        child: Container(
                          height: 400,
                          width: 300,
                          decoration: new BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Spacer(flex: 2),
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: Icon(
                                  Icons.fire_extinguisher,
                                  size: 60,
                                  color: kMainYellow,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(maxWidth: 100),
                                  child: Text(
                                    "Fire Extinguisher Check",
                                    style: TextStyle(
                                      fontSize: 30,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              Spacer(
                                flex: 3,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: Container(
                                          height: 70,
                                          child: FlatButton(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(25)),
                                            ),
                                            onPressed: () {},
                                            child: Icon(
                                              Icons.check,
                                              size: 40,
                                            ),
                                            color: Colors.green,
                                          ))),
                                  Expanded(
                                      child: Container(
                                          height: 70,
                                          child: FlatButton(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                    bottomRight:
                                                        Radius.circular(25))),
                                            onPressed: () {},
                                            child: Icon(
                                              Icons.close,
                                              size: 40,
                                            ),
                                            color: Colors.red,
                                          )))
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(25),
                        child: Container(
                          width: 50,
                          child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: 50,
                              child: Icon(
                                Icons.arrow_forward,
                                color: kMainYellow,
                              )),
                          decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            border: new Border.all(
                              color: kMainYellow,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  Material(
                    elevation: 5.0,
                    color: kMainYellow,
                    borderRadius: BorderRadius.circular(30.0),
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.pushNamed(context, MainPage.mainId);
                      },
                      minWidth: 300.0,
                      height: 42.0,
                      child: Text(
                        startWork,
                      ),
                    ),
                  ),
                ],
              )),
          Expanded(
              flex: 1,
              child: Container(
                color: Colors.grey,
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Material(
                        elevation: 2,
                        borderRadius: BorderRadius.circular(15.0),
                        child: Container(
                          height: 150,
                          width: 130,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.fire_extinguisher,
                                size: 30,
                                color: kMainYellow,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(maxWidth: 100),
                                  child: Text(
                                    "Fire Extinguisher Check",
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
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Material(
                        elevation: 2,
                        borderRadius: BorderRadius.circular(15.0),
                        child: Container(
                          height: 150,
                          width: 130,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.fire_extinguisher,
                                size: 30,
                                color: kMainYellow,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(maxWidth: 100),
                                  child: Text(
                                    "Fire Extinguisher Check",
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
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Material(
                        elevation: 2,
                        borderRadius: BorderRadius.circular(15.0),
                        child: Container(
                          height: 150,
                          width: 130,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.fire_extinguisher,
                                size: 30,
                                color: kMainYellow,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(maxWidth: 100),
                                  child: Text(
                                    "Fire Extinguisher Check",
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
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Material(
                        elevation: 2,
                        borderRadius: BorderRadius.circular(15.0),
                        child: Container(
                          height: 150,
                          width: 130,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.fire_extinguisher,
                                size: 30,
                                color: kMainYellow,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(maxWidth: 100),
                                  child: Text(
                                    "Fire Extinguisher Check",
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
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
