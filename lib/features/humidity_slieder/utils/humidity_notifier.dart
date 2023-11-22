import 'package:flutter/widgets.dart';

class HumidityNotifier with ChangeNotifier {
  HumidityNotifier() {
    _transitionalValue = _defaultValue.toDouble();
    _finalValue = _defaultValue;
  }

  final int _defaultValue = 30;

  double? _transitionalValue;
  double? get transitionalValue => _transitionalValue;

  int? _finalValue;
  int? get finalValue => _finalValue;

  void updateTrasitionalValue(double newValue) {
    _transitionalValue = newValue;
    notifyListeners();
  }

  void updateFinalValue() {
    _finalValue = _transitionalValue!.round();
    notifyListeners();
  }
}
