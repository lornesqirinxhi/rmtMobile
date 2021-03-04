import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rtm_template_one/constants/colors.dart';
import 'package:rtm_template_one/constants/strings.dart';
import 'package:rtm_template_one/constants/style.dart';
import 'package:rtm_template_one/logic_layer/authentication/authentication_bloc.dart';
import 'package:rtm_template_one/presentation_layer/config.dart';
import 'package:rtm_template_one/presentation_layer/screens/login/login.dart';
import 'package:rtm_template_one/presentation_layer/screens/main/mainpage.dart';
import 'package:rtm_template_one/presentation_layer/screens/shifts/notes.dart';

class CheckNotes extends StatefulWidget {
  static const checkNotesId = 'viewNotes';
  @override
  _CheckNotesState createState() => _CheckNotesState();
}

class _CheckNotesState extends State<CheckNotes> {
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
                  previousNotes,
                  style: kBigTextStyle,
                ),
              ),
            ),
            Center(
              child: GestureDetector(
                onTap: (){Navigator.pushNamed(context, Notes.notesId);},
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    height: 200,
                    width: 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Stack(
                          children: [
                            Icon(
                              Icons.insert_drive_file,
                              color: kMainYellow,
                              size: 90,
                            ), //Container
                            Positioned(
                              left: 5,
                              top: 5,
                              child: Icon(
                                Icons.insert_drive_file,
                                color: Colors.yellow,
                                size: 90,
                              ),
                            ), //Container
                            Positioned(
                              left: 10,
                              top: 10,
                              child: Icon(
                                Icons.insert_drive_file,
                                color: Color(0xFFdbd69a),
                                size: 90,
                              ),
                            ), //Container
                          ],
                        ),
                        Text(
                          viewNotes,
                          style: kMediumTextStyle,
                        )
                      ],
                    ),
                  ),
                ),
              ),
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
                    Navigator.pushNamed(context, MainPage.mainId);
                  },
                  minWidth: 400.0,
                  height: 42.0,
                  child: Text(
                    startWork,
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
