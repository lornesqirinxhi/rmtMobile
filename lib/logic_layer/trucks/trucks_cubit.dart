import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rtm_template_one/data_layer/local_database/database.dart';
import 'package:rtm_template_one/data_layer/models/User.dart';
import 'package:rtm_template_one/logic_layer/internet/internet_cubit.dart';

part 'trucks_state.dart';

class TrucksCubit extends Cubit<TrucksState> {
  DatabaseHelper databaseHelper;
  TrucksCubit(this.databaseHelper) : super(TrucksInitial()){
    //internetStreamSubscription = _internetCubit.listen((InternetState state) {
      //WORKS
   //    if(state is InternetConnected){
    //     saveOnline();
   //    }
   //    else {
   //      saveOffline();
   //    }
  //  });

  }
  Future<bool> checkData() async{
    List<User> lst = await databaseHelper.users();
    if (lst.isNotEmpty){
      try {
        emit(TrucksSaved());
        print('Internet Connected and Data Ready to upload');
        return true;
      }
      catch (e){
        print(e);
        return false;
      }

    }
    else {
      return false;
    }
  }
  Future <String> saveOnline () async{
     emit(TrucksSaved());
    String response = '';

    return response;
  }

  Future <String> saveOffline () async{
    emit(TrucksSaveFailed());
    String response = '';

    return response;
  }
  @override
  Future<void> close(){

    return super.close();
  }
}
