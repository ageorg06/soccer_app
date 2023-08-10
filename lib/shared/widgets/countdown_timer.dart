import 'package:flutter/material.dart';
import 'dart:async';

class CountdownTimer extends StatefulWidget {
  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  Timer? _timer;
  int _count = 0;
  final int _maxCount = 90 * 60 ; // minutes * seconds

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(() {
        if (_count < _maxCount) {
          _count++;
        } else {
          timer.cancel();
        }
      }),
    );
  }

  void resetCount() {
    setState(() {
      _count = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Time: $_count'), // Display the current count
        Container(
          height: 10,
          child: Stack(
            children: <Widget>[
              LinearProgressIndicator(
                value: _count / _maxCount.toDouble(),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width / 2,
                top: 0,
                bottom: 0,
                child: Container(
                  width: 1,
                  height: 10,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
