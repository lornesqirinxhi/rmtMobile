import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rtm_template_one/constants/colors.dart';
import 'package:rtm_template_one/constants/strings.dart';
import 'package:rtm_template_one/constants/style.dart';
import 'package:rtm_template_one/logic_layer/authentication/authentication_bloc.dart';
import 'package:rtm_template_one/presentation_layer/config.dart';
import 'package:rtm_template_one/presentation_layer/screens/login/login.dart';
import 'package:rtm_template_one/presentation_layer/screens/shifts/check_truck.dart';

class ChooseTruck extends StatefulWidget {
  static const chooseTruckId = 'chooseTruck';
  @override
  _ChooseTruckState createState() => _ChooseTruckState();
}

class _ChooseTruckState extends State<ChooseTruck> {
  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final AuthenticationBloc authenticationBloc =
        BlocProvider.of<AuthenticationBloc>(context);
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationNotAuthenticated) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()),);
        }
      },
      builder: (context, state){
        return Scaffold(
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
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 200),
                  child: Text(
                    "Veicolo Scelto",
                    style: kBigTextStyle,
                  ),
                ),
              ),
              Center(
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(25.0),
                    child: Padding(
                      padding: const EdgeInsets.all(50),
                      child: Column(

                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.directions_car,
                            color: kMainYellow,
                            size: 80,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Truck Nr. 1",
                            style: kMediumTextStyle,
                          ),
                          SizedBox(
                            height: 15,
                          ),

                          Text(
                            "2423423 - IT",
                            style: kSmallTextStyle,
                          ),
                        ],
                      ),
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              Divider(
                height: 1,
                indent: 200,
                endIndent: 200,


              ),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 500,),
                child: Material(
                  elevation: 5.0,
                  color: kMainYellow,
                  borderRadius: BorderRadius.circular(30.0),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pushNamed(context, CheckDevice.CheckDeviceId);

                    },
                    minWidth: 400.0,
                    height: 42.0,
                    child: Text(
                      continueWork,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}
