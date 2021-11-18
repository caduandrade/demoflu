import 'package:demoflu/src/console_widget.dart';
import 'package:demoflu/src/menu_item.dart';
import 'package:flutter/widgets.dart';
import 'package:multi_split_view/multi_split_view.dart';
import 'package:flutter/services.dart' show rootBundle;

class DemoFluSettings extends ChangeNotifier {
  DemoFluSettings(
      {required Color widgetBackground,
      required double? widthWeight,
      required double? heightWeight,
        required bool defaultConsoleEnabled,
        required bool defaultResizable,
        required  Size? defaultMaxSize})
      : this._defaultConsoleEnabled=defaultConsoleEnabled,
  this._defaultResizable=defaultResizable,
  this._defaultMaxSize=defaultMaxSize,
        this._widgetBackground = widgetBackground,
        this._widthWeight = widthWeight ?? 1,
        this._heightWeight = heightWeight ?? 1;

  final bool _defaultConsoleEnabled;
      final bool _defaultResizable;
  final   Size? _defaultMaxSize;

  Color _widgetBackground;
  Color get widgetBackground => _widgetBackground;
  set widgetBackground(Color color) {
    _widgetBackground = color;
    notifyListeners();
  }

  bool _widgetVisible = true;

  /// Indicates whether widget view is visible.
  bool get widgetVisible => _widgetVisible;
  set widgetVisible(bool visible) {
    _widgetVisible = visible;
    if (!visible) {
      _consoleVisible = false;
    }
    notifyListeners();
  }

  bool _consoleVisible = false;

  /// Indicates whether console view is visible.
  bool get consoleVisible => _consoleVisible;
  set consoleVisible(bool visible) {
    _consoleVisible = visible;
    notifyListeners();
  }

  bool _codeVisible = false;

  /// Indicates whether code view is visible.
  bool get codeVisible => _codeVisible;
  set codeVisible(bool visible) {
    _codeVisible = visible;
    notifyListeners();
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
  void updateCurrentExample(MenuItem menuItem) async {
    _widget=null;
    notifyListeners();

    String? code;
    if (menuItem.codeFile != null) {
      code = await rootBundle.loadString(menuItem.codeFile!);
    }
    _currentMenuItem = menuItem;
    _resizable= menuItem.resizable ?? _defaultResizable;
    _consoleEnabled = menuItem.consoleEnabled ?? _defaultConsoleEnabled;
    _maxSize=menuItem.maxSize ?? _defaultMaxSize;
    _code=code;
    if (_consoleEnabled) {
      _consoleVisible = false;
    }
    _widget=menuItem.builder!(this);
    _consoleNotifier = ConsoleNotifier();
    notifyListeners();
  }

  ConsoleNotifier _consoleNotifier = ConsoleNotifier();
  ConsoleNotifier get consoleNotifier => _consoleNotifier;

  String? _code;
  String? get code => _code;

  Size? _maxSize;
  Size? get maxSize =>_maxSize;

  /// Indicates whether example is resizable.
  bool _resizable = false;
  bool get resizable => _resizable;
  
  bool _consoleEnabled = false;
  bool get consoleEnabled => _consoleEnabled;

  final MultiSplitViewController verticalDividerController =
  MultiSplitViewController(weights: [.9, .1]);
  final MultiSplitViewController horizontalDividerController =
  MultiSplitViewController(weights: [.5, .5]);

  Widget? _widget;
  Widget? get widget => _widget;

  Map<String, Widget> _map =Map<String, Widget>();

  void setExtraWidget(Map<String, Widget> map){
    _map.clear();
    _map.addAll(map);
    notifyListeners();
  }

  MenuItem? _currentMenuItem;
  /// Gets the current selected example.
  MenuItem? get currentMenuItem => _currentMenuItem;

}
