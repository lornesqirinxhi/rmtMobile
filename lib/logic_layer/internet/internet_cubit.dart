import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:meta/meta.dart';
import 'package:rtm_template_one/constants/enums.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  final Connectivity connectivity;
  StreamSubscription streamSubscription;
  var isDeviceConnected = false;

   InternetCubit({@required this.connectivity}) : super(InternetLoading()) {
    streamSubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async{

      if (result == ConnectivityResult.mobile) {
        // I am connected to a mobile network, make sure there is actually a net connection.
        if (await DataConnectionChecker().hasConnection) {
          final checkStatus = await InternetAddress.lookup('google.com');
          if (checkStatus.isNotEmpty && checkStatus[0].rawAddress.isNotEmpty) {
            isDeviceConnected = true;
            emit(InternetConnected(ConnectivityType.Mobile, isDeviceConnected));
          }
          else {
            isDeviceConnected = false;
            emit(NoInternet());
          }
          // Mobile data detected & internet connection confirmed.
        }
      } else if (result == ConnectivityResult.wifi) {
        final checkStatus = await InternetAddress.lookup('google.com');
        // I am connected to a WIFI network, make sure there is actually a net connection.
        if (checkStatus.isNotEmpty && checkStatus[0].rawAddress.isNotEmpty) {
          isDeviceConnected = true;
          emit(InternetConnected(ConnectivityType.Wifi, isDeviceConnected));
        }
        else {
          isDeviceConnected = false;
          emit(NoInternet());
        }
      } else {
        isDeviceConnected = false;
        emit(InternetDisconnected());
      }
    });
  }

  @override
  Future<Function> close() {
    streamSubscription.cancel();
    return super.close();

  }
}
