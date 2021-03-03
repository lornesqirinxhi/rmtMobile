import 'package:flutter/material.dart';
import 'package:rtm_template_one/constants/colors.dart';
class CurrentCheckItem extends StatelessWidget {
  final IconData iconData;
  final String itemName;
  final Function(bool) okCheck;
  final Function(bool) badCheck;


  CurrentCheckItem({this.iconData, this.itemName, this.okCheck, this.badCheck});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(25.0),
      child: Container(
        height: 400,
        width: 300,
        decoration: new BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Spacer(flex: 2),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Icon(
                iconData,
                size: 60,
                color: kMainYellow,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 100),
                child: Text(
                  itemName,
                  style: TextStyle(
                    fontSize: 30,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Spacer(
              flex: 3,
            ),
            Row(
              children: [
                Expanded(
                    child: Container(
                        height: 70,
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomLeft:
                                Radius.circular(25)),
                          ),
                          onPressed: () => okCheck(true),
                          child: Icon(
                            Icons.check,
                            size: 40,
                          ),
                          color: Colors.green,
                        ))),
                Expanded(
                    child: Container(
                        height: 70,
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  bottomRight:
                                  Radius.circular(25))),
                          onPressed: () => okCheck(false),
                          child: Icon(
                            Icons.close,
                            size: 40,
                          ),
                          color: Colors.red,
                        )))
              ],
            )
          ],
        ),
      ),
    );
  }
}
