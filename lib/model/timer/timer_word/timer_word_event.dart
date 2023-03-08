import '../../GameTimer.dart';

abstract class Timer_wordEvent {}

class InitEvent extends Timer_wordEvent {}

class StartTimer extends Timer_wordEvent {
  late final GameTimer timer;
  var onTimerUpdate;
   StartTimer( this.timer, onTimerUpdate);
}