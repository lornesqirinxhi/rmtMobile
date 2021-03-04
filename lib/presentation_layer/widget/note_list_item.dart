import 'package:flutter/material.dart';
import 'package:rtm_template_one/constants/colors.dart';
class NoteListItem extends StatelessWidget {
  final  String user;
  final String title;
  final String date;
  final String description;
  final String noteId;
  final Function onTap;

  NoteListItem({this.user, this.title, this.date, this.description, this.noteId, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: Icon(Icons.insert_drive_file, color: kMainYellow,),
            ),
            Expanded(
              flex: 3,
              child: ListTile(
                title: Text(title, style: TextStyle( fontWeight: FontWeight.bold),),
                subtitle: Text(date),
              ),
            ),
            Expanded(
              flex: 6,
              child: ListTile(
                title: Text(description , style: TextStyle( fontWeight: FontWeight.w700),),

              ),
            ),
            Expanded(
              flex: 3,
              child: ListTile(
                title: Row(children : [Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Icon(Icons.person, color:kMainYellow),
                ) ,Text(user , style: TextStyle( fontWeight: FontWeight.w700),)] ),


              ),
            ),
            Expanded(
              flex: 1,
              child: GestureDetector(
                  onTap: onTap,
                  child: Icon(Icons.arrow_forward_ios)),
            ),
          ],

        ),
      ),
    );
  }
}