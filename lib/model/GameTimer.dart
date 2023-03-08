import 'dart:async';

class GameTimer {
  int _secondsRemaining = 60;
  bool _isActive = false;
  Timer? _timer;

  void startTimer(Function onTimerUpdate) {
    if (!_isActive) {
      _isActive = true;
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
          onTimerUpdate(_secondsRemaining);
        } else {
          stopTimer();
        }
      });
    }
  }

  void stopTimer() {
    _isActive = false;
    _timer?.cancel();
  }

  void resetTimer() {
    _isActive = false;
    _timer?.cancel();
    _secondsRemaining = 60;
  }

  bool get isActive => _isActive;
  int get secondsRemaining => _secondsRemaining;
}
