import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:rtm_template_one/data_layer/local_database/database.dart';
import 'package:rtm_template_one/data_layer/models/User.dart';
import 'package:rtm_template_one/data_layer/repository/AuthRepo.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthRepo authRepo;
  final DatabaseHelper databaseHelper;
  AuthenticationBloc(this.authRepo, this.databaseHelper)
      : super(AuthenticationInitial());

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AppLoaded) {
      yield* mapEventToAppLoaded(event);
    }
    if (event is UserLoggedIn) {
      yield* mapEventToUserLoggedIn(event);
    }
    if (event is UserLoggedOut) {
      yield* mapEventToUserLoggedOut(event);
    }
  }

  Stream<AuthenticationState> mapEventToAppLoaded(AppLoaded event) async* {
    yield AuthenticationLoading();
    try {
      List<User> list = await databaseHelper.users();
      if (list.isNotEmpty) {
        yield AuthenticationAuthenticated(user: list.first);
      } else {
        yield AuthenticationNotAuthenticated();
      }
    } catch (e) {
      yield AuthenticationFailure(message: 'Error');
    }
  }

  Stream<AuthenticationState> mapEventToUserLoggedIn(
      UserLoggedIn event) async* {
    bool checkInsert = false;
    try {
      checkInsert = await databaseHelper.insertUser(event.user);
      yield AuthenticationAuthenticated(user: event.user);
    } catch (e) {
      print(e);
    }
  }

  Stream<AuthenticationState> mapEventToUserLoggedOut(
      UserLoggedOut event) async* {
    List<User> listBefore = await databaseHelper.users();
    await databaseHelper.deleteAllUsers();
    List<User> list = await databaseHelper.users();
    yield AuthenticationNotAuthenticated();
  }
}
