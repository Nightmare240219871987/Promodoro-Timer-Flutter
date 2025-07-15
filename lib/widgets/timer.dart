import 'dart:io';
import 'dart:isolate';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Timer extends StatefulWidget {
  String task;
  int timeTarget;

  Timer({super.key, required this.timeTarget, required this.task});

  @override
  State<Timer> createState() => _TimerState();
}

class _TimerState extends State<Timer> {
  double value = 0.0;
  Stopwatch sw = Stopwatch();
  @override
  void initState() {
    Isolate.run(() {
      sw.start();
      int end = 0;
      double timeTargetMs = widget.timeTarget / 1000 / 60;
      while (end >= timeTargetMs) {
        sleep(Duration(milliseconds: 100));
        end = sw.elapsedMilliseconds;
        double percentage = timeTargetMs / 100 * end;
        setState(() {
          value = percentage / 100;
        });
      }
      sw.stop();
    });
    super.initState();
  }

  double time = 0;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("Aufgabe : ${widget.task}"),
            Text("Timer : $time Min / 25 Min"),
            LinearProgressIndicator(value: 0.1),
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
}
