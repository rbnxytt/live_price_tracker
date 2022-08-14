import 'package:flutter/cupertino.dart';

class AppController with ChangeNotifier {
  double _height = 300.0;

  double get height => _height;

  void updateHeight() {
    _height == 300.0 ? _height == 0 : _height == 300.0;
    notifyListeners();
  }
}
