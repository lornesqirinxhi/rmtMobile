import 'package:flutter/material.dart';
import 'package:rtm_template_one/constants/colors.dart';
import 'package:rtm_template_one/constants/strings.dart';
class PinLogin extends StatefulWidget {
  @override
  _PinLoginState createState() => _PinLoginState();
}

class _PinLoginState extends State<PinLogin> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 500,),
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(30.0),
            child: TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'PIN',
                  prefixIcon: Icon(Icons.dialpad)),
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 500,),
          child: Material(
            elevation: 5.0,
            color: kMainYellow,
            borderRadius: BorderRadius.circular(30.0),
            child: MaterialButton(
              onPressed: () {},
              minWidth: 500.0,
              height: 42.0,
              child: Text(
                login,
              ),
            ),
          ),
        ),

      ],
    );
  }
}
