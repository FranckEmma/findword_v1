import 'package:equatable/equatable.dart';

import '../../GameTimer.dart';

class TimerWordState extends Equatable {
 final int secondsRemaining ;

  const TimerWordState({
     this.secondsRemaining = 60,
  });

  @override
  List<Object?> get props => [secondsRemaining];

  TimerWordState init() {
    return TimerWordState();
  }
  TimerWordState getTimer( int newTimer){
    return TimerWordState(secondsRemaining: newTimer);
  }
  TimerWordState clone() {
    return TimerWordState();
  }
}
