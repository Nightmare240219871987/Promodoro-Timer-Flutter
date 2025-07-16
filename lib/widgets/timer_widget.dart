import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:in_time/Classes/observer.dart';
import 'package:in_time/Classes/timer.dart';

// ignore: must_be_immutable
class TimerWidget extends StatefulWidget {
  String task;
  final int timeTarget;

  TimerWidget({super.key, required this.timeTarget, required this.task});

  @override
  State<TimerWidget> createState() => _TimerState();
}

class _TimerState extends State<TimerWidget> implements Observer {
  double value = 0.0;
  double elapsedTime = 0.0;
  double percentage = 0.0;
  bool isComplete = false;

  @override
  Widget build(BuildContext context) {
    Isolate.run(() {
      Timer timer = Timer(time: widget.timeTarget);
      timer.addObserver(this);
      timer.start();
    });
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("Aufgabe : Hallo Welt "),
            Text("Timer : $elapsedTime Min / ${widget.timeTarget} Min"),
            LinearProgressIndicator(value: percentage),
            ElevatedButton(
              onPressed: onPressedNotFinished,
              child: Text("not finished"),
            ),
            ElevatedButton(
              onPressed: onPressedFinished,
              child: Text("finished"),
            ),
          ],
        ),
      ),
    );
  }

  void onPressedNotFinished() {}

  void onPressedFinished() {}

  @override
  void update(dynamic object) {
    Timer timer = object as Timer;
    setState(() {
      elapsedTime = timer.elapsedTime;
      value = timer.percentage;
      isComplete = timer.isComplete;
      percentage = timer.percentage;
    });
  }
}
