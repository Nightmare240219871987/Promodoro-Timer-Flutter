import 'package:in_time/Classes/observer.dart';

abstract class Subject {
  List<Observer> observers = [];

  void addObserver(Observer observer);
  void removeObserver(Observer observer);
  void notifyObserver();
}
