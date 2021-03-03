import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rtm_template_one/constants/colors.dart';
import 'package:rtm_template_one/constants/strings.dart';
import 'package:rtm_template_one/constants/style.dart';
import 'package:rtm_template_one/data_layer/app_data/CheckListData.dart';
import 'package:rtm_template_one/logic_layer/authentication/authentication_bloc.dart';
import 'package:rtm_template_one/presentation_layer/screens/main/mainpage.dart';
import 'package:rtm_template_one/presentation_layer/widget/arrows.dart';
import 'package:rtm_template_one/presentation_layer/widget/check_listview_item.dart';
import 'package:rtm_template_one/presentation_layer/widget/current_checkItem.dart';

import '../../config.dart';

class CheckDevice extends StatefulWidget {
  static const CheckDeviceId = 'check';
  final String deviceId;

  CheckDevice({this.deviceId});

  @override
  _CheckDeviceState createState() => _CheckDeviceState();
}

class _CheckDeviceState extends State<CheckDevice> {
  int _currentItem = 0;
  bool _isButtonDisabled;
  int _checkCounter = 0;
  int _total = 0;
  bool checkAll = false;
  ScrollController controller = new ScrollController();
  List<CheckItem> list = CheckListData().checkItems;

  @override
  void initState() {
    super.initState();
    _total = CheckListData().checkItemCount;
    _isButtonDisabled = true;
  }
  _animateToIndex() => controller.animateTo((120 * _currentItem).toDouble(), duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);

  void loopList() {
    for (CheckItem result in list) {
      if (result.status == false) {
        setState(() {
          _isButtonDisabled = true;
        });
        break;
      } else {
        setState(() {
          _isButtonDisabled = false;
        });
      }
    }
  }

  void _nextCheck() {
    if (_currentItem < _total - 1) {
      setState(() {
        _currentItem++;
      });
      _animateToIndex();
    }
  }

  void _previousCheck() {
    if (_currentItem > 0) {
      setState(() {
        _currentItem--;
      });
      _animateToIndex();
    }
  }

  Widget checkButtons() {
    if (checkAll && _isButtonDisabled == true) {
      return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Material(
          elevation: 5.0,
          color: kMainYellow,
          borderRadius: BorderRadius.circular(30.0),
          child: MaterialButton(
            onPressed: () {
              Navigator.pushNamed(context, MainPage.mainId);
            },
            minWidth: 300.0,
            height: 42.0,
            child: Text(
              "Leave Vehicle",
            ),
          ),
        ),
        Material(
          elevation: 5.0,
          color: kMainYellow,
          borderRadius: BorderRadius.circular(30.0),
          child: MaterialButton(
            onPressed: () {
              Navigator.pushNamed(context, MainPage.mainId);
            },
            minWidth: 300.0,
            height: 42.0,
            child: Text(
              "Maintenance",
            ),
          ),
        ),
      ]);
    } else {
      return Material(
        elevation: 5.0,
        color: kMainYellow,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: _isButtonDisabled
              ? null
              : () {
                  Navigator.pushNamed(context, MainPage.mainId);
                },
          minWidth: 300.0,
          height: 42.0,
          child: Text(
            startWork,
          ),
        ),
      );
    }
  }

  void itemCheck(bool status) {
    CheckListData().updateItemStatus(list[_currentItem], status);

    if (_currentItem < _total - 1) {
      setState(() {
        _currentItem++;
      });
      _animateToIndex();
    }
    if (_checkCounter < _total) {
      setState(() {
        _checkCounter++;
      });
    }
    if (_checkCounter == _total) {
      checkAll = true;
      loopList();
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final AuthenticationBloc authenticationBloc =
        BlocProvider.of<AuthenticationBloc>(context);
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
                inactiveThumbImage: AssetImage("assets/images/switch_sun.png"),
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
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              flex: 2,
              child: Material(
                elevation: 10,
                child: Column(
                  children: [
                    Expanded(
                        flex: 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: Icon(
                                Icons.drive_eta,
                                size: 60,
                                color: kMainYellow,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: Text(
                                "Truck Nr.1",
                                style: TextStyle(
                                    fontWeight: FontWeight.w900, fontSize: 25),
                              ),
                            ),
                            Text(
                              "98-665-IT",
                              style: TextStyle(
                                  fontWeight: FontWeight.w900, fontSize: 15),
                            )
                          ],
                        )),
                    Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              _checkCounter.toString() +
                                  '/' +
                                  _total.toString(),
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              "Checked",
                              style: TextStyle(
                                  fontWeight: FontWeight.w900, fontSize: 20),
                            )
                          ],
                        ))
                  ],
                ),
              )),
          Expanded(
              flex: 6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Arrows(
                        previousCheck: _previousCheck,
                        arrow: Icons.arrow_back,
                      ),
                      CurrentCheckItem(
                        iconData: list[_currentItem].iconData,
                        itemName: list[_currentItem].name,
                        okCheck: itemCheck,
                        badCheck: itemCheck,
                      ),
                      Arrows(
                        previousCheck: _nextCheck,
                        arrow: Icons.arrow_forward,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 70,
                  ),
                   checkButtons()
                ],
              )),
          Expanded(
              flex: 1,
              child: Container(
                color: Colors.grey,
                child: ListView.builder(
                    itemCount: _total,
                    controller: controller,
                    itemBuilder: (BuildContext context, int index) {
                      return CheckListViewItem(
                        name: list[index].name,
                        iconData: list[index].iconData,
                        colors: list[index].status
                            ? Color(0xFF5A8873)
                            : Color(0xFF884851),
                        bckColor: _currentItem == index ? kMainYellow : null,
                      );

                    }),
              ))
        ],
      ),
    );
  }
}
