import 'package:demoflu/src/demo_menu_item.dart';
import 'package:demoflu/src/example.dart';
import 'package:demoflu/src/internal/console_controller.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/widgets.dart';

class DemoFluSettings extends ChangeNotifier {
  DemoFluSettings(
      {required Color exampleBackground,
      required double? widthWeight,
      required double? heightWeight,
      required bool defaultConsoleEnabled,
      required bool defaultResizable,
      required Size? defaultMaxSize})
      : this._defaultConsoleEnabled = defaultConsoleEnabled,
        this._defaultResizable = defaultResizable,
        this._defaultMaxSize = defaultMaxSize,
        this._exampleBackground = exampleBackground,
        this._widthWeight = widthWeight ?? 1,
        this._heightWeight = heightWeight ?? 1;

  final bool _defaultConsoleEnabled;
  final bool _defaultResizable;
  final Size? _defaultMaxSize;

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
      _resizable = newExample.resizable ?? _defaultResizable;
      _consoleEnabled = newExample.consoleEnabled ?? _defaultConsoleEnabled;
      _maxSize = newExample.maxSize ?? _defaultMaxSize;
      _code = code;

      _example = newExample;

      notifyListeners();
    }
  }

  final ConsoleController console = ConsoleController();

  String? _code;

  String? get code => _code;

  Size? _maxSize;

  Size? get maxSize => _maxSize;

  /// Indicates whether example is resizable.
  bool _resizable = false;

  bool get resizable => _resizable;

  bool _consoleEnabled = false;

  bool get consoleEnabled => _consoleEnabled;

  AbstractExample? _example;

  AbstractExample? get example => _example;

  DemoMenuItem? _currentMenuItem;

  /// Gets the current selected example.
  DemoMenuItem? get currentMenuItem => _currentMenuItem;
}
