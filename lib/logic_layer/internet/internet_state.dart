part of 'internet_cubit.dart';

@immutable
abstract class InternetState {}

class InternetLoading extends InternetState {}

class InternetConnected extends InternetState {
  final ConnectivityType connectivityType;
  final bool hasConnection;
  InternetConnected(this.connectivityType,this.hasConnection);
}
class InternetDisconnected extends InternetState {

}
class NoInternet extends InternetState {

}
