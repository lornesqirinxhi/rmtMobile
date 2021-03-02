import 'package:flutter/material.dart';
import 'package:rtm_template_one/constants/colors.dart';
class TruckListTile extends StatelessWidget {
  final IconData iconData;
  final String truckName;
  final String truckNumber;
  final String status;
  final String driver;
  final Function onTap;
  TruckListTile(
      {this.iconData,
      this.truckName,
      this.truckNumber,
      this.status,
      this.driver, this.onTap});

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
              child: Icon(iconData, color: kMainYellow,),
            ),
            Expanded(
              flex: 4,
              child: ListTile(
                title: Text(truckName, style: TextStyle( fontWeight: FontWeight.bold),),
                subtitle: Text(truckNumber),
              ),
            ),
            Expanded(
              flex: 6,
              child: ListTile(
                enabled: status == 'Free' ? true : false,
                  title: Text(status , style: TextStyle(color: status == 'Free' ? Colors.green : Colors.red, fontWeight: FontWeight.w700),),
                  subtitle: status == 'Free' ? Text('') : Row(mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.person, size: 20,), Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(driver),
                      )],),
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
