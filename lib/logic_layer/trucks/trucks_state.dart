part of 'trucks_cubit.dart';

@immutable
abstract class TrucksState {}

class TrucksInitial extends TrucksState {}

class TrucksLoading extends TrucksState {}

class TrucksSaved extends TrucksState {

}
class TrucksSaveFailed extends TrucksState {

}