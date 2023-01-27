import 'package:demoflu/src/demo_menu_item.dart';
import 'package:demoflu/src/example.dart';
import 'package:demoflu/src/internal/console_controller.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/widgets.dart';

class DemoFluSettings extends ChangeNotifier {
  DemoFluSettings(
      {required Color exampleBackground,
      required double widthWeight,
      required double heightWeight,
      required bool resizable,
      required Size? maxSize})
      : this._resizable=resizable,
        this._maxSize = maxSize,
        this._exampleBackground = exampleBackground,
        this._widthWeight = widthWeight,
        this._heightWeight = heightWeight;

  final bool _resizable;
  bool get resizable => _example?.resizable??_resizable;

  bool _resizeEnabled = true;
  bool get resizeEnabled => _resizeEnabled;
   set resizeEnabled(bool value) {
    if(_resizeEnabled!=value){
      _resizeEnabled=value;
      notifyListeners();
    }
  }

  final Size? _maxSize;

  Size? get maxSize => _example?.maxSize??_maxSize;

  bool _settingsVisible = false;

  bool get settingsVisible => _settingsVisible;

  set settingsVisible(bool value) {
    if (_settingsVisible != value) {
      _settingsVisible = value;
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

  /// Updates the current example.
  void updateCurrentExample(DemoMenuItem menuItem) async {
    _example = null;
    notifyListeners();

    if (menuItem.example != null) {
      final AbstractExample newExample = menuItem.example!;
      String? code;
      if (newExample.codeFile != null) {
        code = await rootBundle.loadString(newExample.codeFile!);
      }
      _currentMenuItem = menuItem;
      _code = code;

      console.clear();

      _example = newExample;

      notifyListeners();
    }
  }

  final ConsoleController console = ConsoleController();

  String? _code;

  String? get code => _code;





  AbstractExample? _example;

  AbstractExample? get example => _example;

  DemoMenuItem? _currentMenuItem;

  /// Gets the current selected example.
  DemoMenuItem? get currentMenuItem => _currentMenuItem;
}
