import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rtm_template_one/constants/strings.dart';
import 'package:rtm_template_one/presentation_layer/config.dart';


class AddNoteAlertDialog extends StatefulWidget {
  @override
  _AddNoteAlertDialogState createState() => _AddNoteAlertDialogState();
}

class _AddNoteAlertDialogState extends State<AddNoteAlertDialog> {
  File _image;
  final picker = ImagePicker();
  bool _retryVisible = false;
  GlobalKey _deleteKey = GlobalKey();
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _retryVisible = true;
      } else {
        print('No image selected.');
      }
    });
  }

  void deleteImage() {
    setState(() {
      _image = null;
      _retryVisible = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      contentPadding: EdgeInsets.all(0.0),
      content: SingleChildScrollView(
        child: Container(
          height: 350,
          width: 600,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: myTheme.currentTheme() == ThemeMode.dark
                ? ThemeData.dark().primaryColor
                : Colors.white,
            borderRadius: new BorderRadius.all(new Radius.circular(15.0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 2,
                  child: Container(
                    height: 240,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        minLines: 1, //Normal textInputField will be displayed
                        maxLines: 5,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: writeNote,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    height: 60,
                    width: 70,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            topRight: Radius.circular(15)),
                      ),
                      onPressed: () {},
                      child: Icon(
                        Icons.check,
                        size: 40,
                      ),
                      color: Colors.green,
                    ),
                  ),
                  FlatButton(
                      onPressed: getImage,
                      child: Icon(
                        Icons.camera_alt,
                        size: 40,
                        color: _image == null ? Colors.white : Colors.green,
                      )),
                  if (_retryVisible) FlatButton(
                      key: _deleteKey,
                      onPressed: deleteImage,
                      child: Icon(
                        Icons.autorenew,
                        size: 40,
                      )),
                  Container(
                    height: 60,
                    width: 70,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(15),
                              topLeft: Radius.circular(15))),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.close,
                        size: 40,
                      ),
                      color: Colors.red,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
