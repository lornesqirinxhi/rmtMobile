import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rtm_template_one/constants/colors.dart';
import 'package:rtm_template_one/constants/strings.dart';
import 'package:rtm_template_one/constants/style.dart';
import 'package:rtm_template_one/logic_layer/authentication/authentication_bloc.dart';
import 'package:rtm_template_one/presentation_layer/config.dart';
import 'package:rtm_template_one/presentation_layer/screens/login/login.dart';
import 'package:rtm_template_one/presentation_layer/screens/main/mainpage.dart';
import 'package:rtm_template_one/presentation_layer/screens/shifts/staff.dart';
import 'package:rtm_template_one/presentation_layer/widget/staff_member.dart';

class AuthenticatePresence extends StatefulWidget {
  static const authPresenceId = 'authPresence';
  @override
  _AuthenticatePresenceState createState() => _AuthenticatePresenceState();
}

class _AuthenticatePresenceState extends State<AuthenticatePresence> {
  var _pinController;
  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final AuthenticationBloc authenticationBloc =
        BlocProvider.of<AuthenticationBloc>(context);
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
      if (state is AuthenticationNotAuthenticated) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      }
    }, builder: (context, state) {
      return Scaffold(
        appBar: AppBar( actions: [
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
                  activeThumbImage: AssetImage("assets/images/switch_moon.png"),
                ),
              ),
              Material(
                  elevation: 2,
                  child: IconButton(
                      icon: Icon(Icons.notifications), onPressed: () => {})),
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
                  logMember,
                  style: kBigTextStyle,
                ),
              ),
            ),
            StaffMember(
              status: true,
              name: "Lornes Qirinxhi",
              initials: "LQ",
              onTap: () {},
            ),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 500,),
              child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(30.0),
                child: TextField(
                  controller: _pinController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'PIN',
                      prefixIcon: Icon(Icons.dialpad)),
                ),
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 500,
              ),
              child: Material(
                elevation: 5.0,
                color: kMainYellow,
                borderRadius: BorderRadius.circular(30.0),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Staff.staffId);
                  },
                  minWidth: 400.0,
                  height: 42.0,
                  child: Text(
                    authenticate,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
