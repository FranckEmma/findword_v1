import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'GameTimer.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  GameTimer _timer = GameTimer();

  late int _secondsRemaining;

  @override
  void initState() {
    super.initState();
    _timer.resetTimer();
    _timer.startTimer(_onTimerUpdate);
  }

  @override
  void dispose() {
    _timer.stopTimer();
    super.dispose();
  }

  void _onTimerUpdate(int secondsRemaining) {
    setState(() {
      _secondsRemaining = secondsRemaining;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Game'),
      ),
      body: Center(
        child: Text('Time Remaining: $_secondsRemaining'),
      ),
    );
  }
}
