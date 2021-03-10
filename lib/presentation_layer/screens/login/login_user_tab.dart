import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rtm_template_one/constants/colors.dart';
import 'package:rtm_template_one/constants/strings.dart';
import 'package:rtm_template_one/logic_layer/login/login_bloc.dart';

import '../map/maps.dart';

class UserLogin extends StatefulWidget {
  @override
  _UserLoginState createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(listener: (context, state) {
      if (state is LoginSuccess) {
        Navigator.of(context).pop();
        Navigator.pushNamed(context, MapDisplay.mapId);
        print('Success');
      }
    }, builder: (context, state) {
      if (state is LoginLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else {
        //ADD TEXTFIELDFORM TO VALIDATE

        return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 500,
                ),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(30.0),
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Username',
                        prefixIcon: Icon(Icons.person)),
                  ),
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
                  borderRadius: BorderRadius.circular(30.0),
                  child: TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        fillColor: Colors.white,
                        hintText: 'Password',
                        prefixIcon: Icon(Icons.lock)),
                  ),
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
                    onPressed: () {
                      setState(() {});
                      BlocProvider.of<LoginBloc>(context).add(
                          LoginInWithEmailButtonPressed(
                              email: _emailController.text,
                              password: _passwordController.text));
                    },
                    minWidth: 500.0,
                    height: 42.0,
                    child: Text(
                      login,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    });
  }
}
