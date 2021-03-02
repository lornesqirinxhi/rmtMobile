import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:rtm_template_one/data_layer/models/User.dart';
import 'package:rtm_template_one/data_layer/repository/AuthRepo.dart';
import 'package:rtm_template_one/logic_layer/authentication/authentication_bloc.dart';
import 'package:rtm_template_one/logic_layer/internet/internet_cubit.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final InternetCubit internetCubit;
  final AuthRepo authRepo;
  final AuthenticationBloc authenticationBloc;
  StreamSubscription internetStreamSubscription;
  LoginBloc(this.internetCubit, this.authRepo, this.authenticationBloc)
      : super(LoginInitial()) {
    internetStreamSubscription = internetCubit.listen((InternetState state) {
      //WORKS
      //if(state is InternetConnected){
      //  add(LoginInWithEmailButtonPressed(email: '', password: 'null'));
      // }
    });
  }

  @override
  Future<void> close() {
    internetStreamSubscription.cancel();
    return super.close();
  }

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginInWithEmailButtonPressed) {
      yield LoginLoading();
      User user = await authRepo.getUser();
      //User user = new User (name: 'name', email: 'd');
      if (user != null) {
        authenticationBloc.add(UserLoggedIn(user: user));
        yield LoginSuccess();
        yield LoginInitial();
      } else {
        yield LoginFailure(error: 'Error');
      }
    }
  }
}
