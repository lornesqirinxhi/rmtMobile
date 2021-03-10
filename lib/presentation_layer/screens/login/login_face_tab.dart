import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../constants/strings.dart';

class FaceLogin extends StatefulWidget {
  @override
  _FaceLoginState createState() => _FaceLoginState();
}

class _FaceLoginState extends State<FaceLogin> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Material(
          elevation: 1.0,
          borderRadius: BorderRadius.circular(30.0),
          child: Image.asset(
            'assets/images/face_id.png',
            height: 150,
            width: 150,
          ),
        ),
        SizedBox(
          height: 15,
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
              onPressed: () {},
              minWidth: 500.0,
              height: 42.0,
              child: Text(
                faceId,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
