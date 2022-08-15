import 'package:flutter/cupertino.dart';

class AppController with ChangeNotifier {
  double _height = 300.0;
  bool _isClicked = false;

  double _maxX = 11;

  double get maxX => _maxX;

  void updateMaxX() {}

  double get height => _height;
  bool get isClicked => _isClicked;

  void hideCalendar() {
    _height = 0;
    _isClicked = !_isClicked;
    notifyListeners();
  }

  void showCalendar() {
    _height = 300;
    _isClicked = !_isClicked;
    notifyListeners();
  }
}
