import 'package:flutter/material.dart';

class CountDownTimer extends StatefulWidget {
  final DateTime timeLimit;

  const CountDownTimer({Key key, this.timeLimit}) : super(key: key);

  @override
  State createState() => _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer>
    with TickerProviderStateMixin {
  int secondsRemaining;
  AnimationController _controller;
  Duration duration;

  String get timerDisplayString {
    final Duration duration = _controller.duration * _controller.value;
    return formatHHMMSS(duration.inSeconds);
  }

  String formatHHMMSS(int seconds) {
    final int hours = (seconds / 3600).truncate();
    seconds = (seconds % 3600).truncate();
    final int minutes = (seconds / 60).truncate();

    final String hoursStr = (hours).toString().padLeft(2, '0');
    final String minutesStr = (minutes).toString().padLeft(2, '0');
    final String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    if (hours == 0) {
      return "$minutesStr:$secondsStr";
    }

    return "$hoursStr:$minutesStr:$secondsStr";
  }

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();

    secondsRemaining = widget.timeLimit.difference(now).inSeconds;
    duration = Duration(seconds: secondsRemaining);
    _controller = AnimationController(
      vsync: this,
      duration: duration,
    );
    _controller.reverse(from: secondsRemaining.toDouble());
  }

  @override
  void didUpdateWidget(CountDownTimer oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (secondsRemaining != secondsRemaining) {
      setState(() {
        duration = Duration(seconds: secondsRemaining);
        _controller.dispose();
        _controller = AnimationController(
          vsync: this,
          duration: duration,
        );
        _controller.reverse(from: secondsRemaining.toDouble());
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
          animation: _controller,
          builder: (_, Widget child) {
            return Text(
              timerDisplayString,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            );
          }),
    );
  }
}
