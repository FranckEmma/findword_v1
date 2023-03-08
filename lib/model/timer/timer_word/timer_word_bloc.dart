import 'dart:async';

import 'package:bloc/bloc.dart';

import 'timer_word_event.dart';
import 'timer_word_state.dart';

class TimerWordBloc extends Bloc<Timer_wordEvent, TimerWordState> {
  Timer? _timer;

  TimerWordBloc() : super(const TimerWordState().init()) {
    on<InitEvent>(_init);
    on<StartTimer>(_startTimer);
  }

  void _init(InitEvent event, Emitter<TimerWordState> emit) async {
    emit(state.clone());
  }

  Future<void> _startTimer(StartTimer event, Emitter<TimerWordState> emit) async {
    event.timer.startTimer(event.onTimerUpdate);

  }
  _onTimerUpdate(secondsRemaining){
    emit(state.getTimer(secondsRemaining));
  }
}
/*
= Timer.periodic(const Duration(seconds: 1), (timer) async* {
var sd = state.secondsRemaining;
if (sd > 0) {
sd--;
yield  state.getTimer(sd);
} else {
_timer?.cancel();
}
})*/
