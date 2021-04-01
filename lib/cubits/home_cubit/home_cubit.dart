import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  Timer _timer;
  int counter = 0;
  Duration timeStep = Duration(milliseconds: 300);

  Future<void> onInit() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    if (sp != null) {
      String strStartDate = sp.getString("exitTime");
      counter = sp.getInt("currentCount")?? 0;
      if(strStartDate != null){
        DateTime startDate = DateTime.parse(strStartDate);
        totalCountedBackground(exitTime: startDate);
      }
    }
  }


  void startTimer() {
    _timer = new Timer.periodic(timeStep, (Timer timer) {
      counter++;
      emit(Counted());
    });
  }

  Future<void> resetCounter() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    if (sp != null) {
      sp.remove("exitTime");
      sp.remove("currentCount");
    }
    counter = 0;
    emit(SaveDone());
  }

  Future<void> saveStartDate({DateTime date}) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    if (sp != null) {
      sp.setString("exitTime", date.toString());
      sp.setInt("currentCount", counter);
    }
    emit(SaveDone());
  }

  void totalCountedBackground({DateTime exitTime}) {
    int totalMill = DateTime.now().difference(exitTime).inMilliseconds;
    counter+= totalMill ~/ timeStep.inMilliseconds;
  }

  void dispose() {
    _timer.cancel();
  }
}
