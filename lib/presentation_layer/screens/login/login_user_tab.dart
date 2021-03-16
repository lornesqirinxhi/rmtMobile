import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rtm_template_one/constants/colors.dart';
import 'package:rtm_template_one/constants/strings.dart';
import 'package:rtm_template_one/logic_layer/login/login_bloc.dart';
import 'package:rtm_template_one/presentation_layer/screens/main/mainpage.dart';
import 'package:rtm_template_one/presentation_layer/screens/shifts/check_truck.dart';
import 'package:rtm_template_one/presentation_layer/screens/shifts/chosen_truck.dart';

class UserLogin extends StatefulWidget {
  @override
  _UserLoginState createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(listener: (context, state) {
      if (state is LoginSuccess) {
        Navigator.of(context).pop();
        Navigator.pushNamed(context, ChooseTruck.chooseTruckId);
        // print('Success');
      }
    }, builder: (context, state) {
      if (state is LoginLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else {
        //ADD TEXTFIELDFORM TO VALIDATE
        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 500,
                ),
                child: Material(
                  elevation: 2.0,
                  borderRadius: BorderRadius.circular(30.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return null;
                      }
                      return null;
                    },
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
                  elevation: 2.0,
                  borderRadius: BorderRadius.circular(30.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return '';
                      }
                      return null;
                    },
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
                  elevation: 2.0,
                  color: kMainYellow,
                  borderRadius: BorderRadius.circular(30.0),
                  child: MaterialButton(
                    onPressed: () {
                      final FormState form = _formKey.currentState;
                      if (form.validate()) {
                        BlocProvider.of<LoginBloc>(context).add(
                            LoginInWithEmailButtonPressed(
                                email: _emailController.text,
                                password: _passwordController.text));
                        print('Form is valid');
                      } else {
                        print('Form is invalid');
                      }
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
