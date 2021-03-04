import 'package:flutter/cupertino.dart';
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

class ViewNote extends StatefulWidget {
  static const viewNoteId = 'viewNote';
  @override
  _ViewNoteState createState() => _ViewNoteState();
}

class _ViewNoteState extends State<ViewNote> {
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
            Expanded(
              flex: 1,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment
                      .spaceEvenly, //Center Row contents horizontally,
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 28.0),
                        child: Text(
                          '04/03/2021 11:12',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    Center(
                      child:  Row(children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Icon(
                              Icons.insert_drive_file,
                              color: kMainYellow,
                              size: 50,
                            ),
                          ),
                          Text(
                            'Note Title',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 18),
                          )
                        ]),
                      ),
                    Center(
                      child: Row(children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Icon(
                              Icons.person,
                              color: kMainYellow,
                              size: 50,
                            ),
                          ),
                          Text(
                            'Lornes Qirinxhi',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 18),
                          )
                        ]),
                      ),
                  ],
                ),
              ),
            ),
            Divider(
              height: 1,
              indent: 200,
              endIndent: 200,
            ),
            Expanded(
                flex: 4,
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(50),
                    child: Text(
                      'These are short, famous texts in English from classic sources like the Bible or Shakespeare. Some texts have word definitions and explanations to help you. Some of these texts are written in an old style of English. Try to understand them, because the English that we speak today is based on what our great, great, great, great grandparents spoke before! Of course, not all these texts were originally written in English. The Bible, for example, is a translation. But they are all well known in English today, and many of them express beautiful thoughts.',
                      style: TextStyle(
                          fontSize: 18, letterSpacing: 1, height: 1.5),
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
            Expanded(
                flex: 1,
                child: Icon(
                  Icons.photo,
                  size: 100,
                  color: kMainYellow,
                ))
          ],
        ),
      );
    });
  }
}
