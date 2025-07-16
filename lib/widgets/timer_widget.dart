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
  late Timer timer;
  double value = 0.0;
  double elapsedTime = 0.0;
  double percentage = 0.0;
  bool isComplete = false;

  @override
  void initState() {
    timer = Timer(time: widget.timeTarget);
    timer.addObserver(this);
    timer.start();
    super.initState();
  }

  @override
  void dispose() {
    timer.removeObserver(this);
    timer.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("Aufgabe : ${widget.task} "),
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
  void update() {
    setState(() {
      elapsedTime = timer.elapsedTime;
      value = timer.percentage;
      isComplete = timer.isComplete;
      percentage = timer.percentage;
    });
  }
}
