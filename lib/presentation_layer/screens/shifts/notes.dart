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
import 'package:rtm_template_one/presentation_layer/screens/shifts/view_note.dart';
import 'package:rtm_template_one/presentation_layer/widget/add_note_alert_dialog.dart';
import 'package:rtm_template_one/presentation_layer/widget/note_list_item.dart';

class Notes extends StatefulWidget {
  static const notesId = 'notes';
  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
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
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, position) {
                  return NoteListItem(
                    noteId: position.toString(),
                    user: 'Lornes Qirinxhi $position',
                    title: 'Title $position',
                    description: 'Description $position',
                    date: '03/03/2021 12:3$position',
                    onTap: (){Navigator.pushNamed(context, ViewNote.viewNoteId);},
                  );
                },
              ),
            ),
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, MainPage.mainId);
                  },
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      height: 200,
                      width: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(
                            Icons.play_arrow_rounded,
                            size: 90,
                          ),
                          Text(
                            startWork,
                            style: kMediumTextStyle,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AddNoteAlertDialog(),
                    );
                  },
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
                            addNote,
                            style: kMediumTextStyle,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )),
          ],
        ),
      );
    });
  }
}


