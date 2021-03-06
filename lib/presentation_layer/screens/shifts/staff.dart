import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:rtm_template_one/constants/colors.dart';
import 'package:rtm_template_one/constants/strings.dart';
import 'package:rtm_template_one/constants/style.dart';
import 'package:rtm_template_one/data_layer/models/User.dart';
import 'package:rtm_template_one/logic_layer/authentication/authentication_bloc.dart';
import 'package:rtm_template_one/presentation_layer/config.dart';
import 'package:rtm_template_one/presentation_layer/screens/login/login.dart';
import 'package:rtm_template_one/presentation_layer/screens/main/mainpage.dart';
import 'package:rtm_template_one/presentation_layer/screens/shifts/auth_presence.dart';
import 'package:rtm_template_one/presentation_layer/screens/shifts/check_truck.dart';
import 'package:rtm_template_one/presentation_layer/screens/shifts/check_notes.dart';
import 'package:rtm_template_one/presentation_layer/widget/staff_member.dart';

class Staff extends StatefulWidget {
  static const staffId = 'staff';
  @override
  _StaffState createState() => _StaffState();
}

class _StaffState extends State<Staff> {
  List<User> lstUser = UserData().users;

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
                  squadMembers,
                  style: kBigTextStyle,
                ),
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 700, maxHeight: 300),
              child: Center(
                  child: GridView.count(
                crossAxisCount: 3,
                childAspectRatio: 1.5,
                children: List.generate(lstUser.length, (index) {
                  return StaffMember(
                    status: lstUser[index].auth,
                    name: lstUser[index].name,
                    initials: lstUser[index].initials,
                    onTap: () {
                      Navigator.pushNamed(
                              context, AuthenticatePresence.authPresenceId,
                              arguments: lstUser[index])
                          .then((value) => setState(() {}));
                    },
                  );
                }),
              )),
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              height: 1,
              indent: 200,
              endIndent: 200,
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
                    Navigator.pushNamed(context, CheckNotes.checkNotesId);
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
    });
  }
}
