import 'package:demoflu/src/internal/view.dart';
import 'package:flutter/widgets.dart';

class DemoFluSettings extends ChangeNotifier {
  DemoFluSettings(
      {required Color exampleBackground,
      required double widthWeight,
      required double heightWeight,
      required this.resizable,
      required this.maxSize})
      : this._exampleBackground = exampleBackground,
        this._widthWeight = widthWeight,
        this._heightWeight = heightWeight;

  final bool resizable;

  final Size? maxSize;

  bool _resizeEnabled = true;

  bool get resizeEnabled => _resizeEnabled;

  set resizeEnabled(bool value) {
    if (_resizeEnabled != value) {
      _resizeEnabled = value;
      notifyListeners();
    }
  }

  DemofluView _view = DemofluView.example;
  DemofluView get view => _view;
  set view(DemofluView value) {
    if (_view != value) {
      _view = value;
      notifyListeners();
    }
  }

  Color _exampleBackground;

  Color get exampleBackground => _exampleBackground;

  set exampleBackground(Color color) {
    if (_exampleBackground != color) {
      _exampleBackground = color;
      notifyListeners();
    }
  }

  double _widthWeight;

  double get widthWeight => _widthWeight;

  set widthWeight(double value) {
    _widthWeight = value;
    notifyListeners();
  }

  double _heightWeight;

  double get heightWeight => _heightWeight;

  set heightWeight(double value) {
    _heightWeight = value;
    notifyListeners();
  }
}
