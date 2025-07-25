import 'dart:io';
import 'package:in_time/Classes/observer.dart';
import 'package:in_time/Classes/subject.dart';

class Timer implements Subject {
  final Stopwatch sw = Stopwatch();
  final int time;
  double _percentage = 0;
  double _elapsedTime = 0;

  double get elapsedTime => _elapsedTime;

  double get percentage => _percentage;

  bool _isComplete = false;

  bool get isComplete => _isComplete;

  Timer({required this.time});

  void _work() {
    int end = 0;
    int targetTime = time * 1000 * 60;
    while (end <= targetTime) {
      sleep(Duration(milliseconds: 100));
      end = sw.elapsedMilliseconds;
      _elapsedTime = end / 1000 / 60;
      _percentage = 100 / targetTime * end;
    }
    _isComplete = true;
    notifyObserver();
    stop();
  }

  void start() {
    sw.start();
    _work();
  }

  void stop() {
    sw.stop();
  }

  @override
  void addObserver(Observer observer) async {
    observers.add(observer);
  }

  @override
  void notifyObserver() async {
    for (Observer o in observers) {
      o.update(this);
    }
  }

  @override
  void removeObserver(Observer observer) {
    observers.remove(observer);
  }

  @override
  List<Observer> observers = [];
}
