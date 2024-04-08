import 'package:demoflu/demoflu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:syntax_highlight/syntax_highlight.dart';

/// DemoFlu model.
@internal
class DemoFluModel extends ChangeNotifier {
  DemoFluModel(
      {required this.title,
      required this.rootMenus,
      required this.resizable,
      required Color exampleBackground})
      : _exampleBackground = exampleBackground {
    if (heightWeight < 0 || heightWeight > 1) {
      throw ArgumentError.value(
          heightWeight, 'Must be a value between 0 and 1', 'heightWeight');
    }
    if (widthWeight < 0 || widthWeight > 1) {
      throw ArgumentError.value(
          widthWeight, 'Must be a value between 0 and 1', 'widthWeight');
    }

    List<DemoMenuItem> menuItems = fetchMenuItems();
    int firstMenuItemIndex = menuItems.indexWhere((item) => item.page != null);
    if (firstMenuItemIndex != -1) {
      _selectedMenuItem = menuItems[firstMenuItemIndex];
    }
  }

  final String title;

  /// List with root menus.
  final List<DemoMenuItem> rootMenus;

  /// Defines the default widget background for all examples.
  Color _exampleBackground;
  Color get exampleBackground => _exampleBackground;
  set exampleBackground(Color color) {
    if (_exampleBackground != color) {
      _exampleBackground = color;
    }
  }

  final Size? maxSize = null;
  final bool resizable;

  double _widthWeight = 1;

  double get widthWeight => _widthWeight;

  set widthWeight(double value) {
    _widthWeight = value;
    notifyListeners();
  }

  double _heightWeight = 1;

  double get heightWeight => _heightWeight;

  set heightWeight(double value) {
    _heightWeight = value;
    notifyListeners();
  }

  Highlighter? _highlighter;

  Highlighter get highlighter {
    if (_highlighter == null) {
      throw StateError('highlighter must be initialized.');
    }
    return _highlighter!;
  }

  DemoMenuItem _selectedMenuItem = noSelectedMenuItem;
  DemoMenuItem get selectedMenuItem => _selectedMenuItem;
  set selectedMenuItem(DemoMenuItem value) {
    if (_selectedMenuItem != value) {
      _selectedMenuItem = value;
      notifyListeners();
    }
  }

  bool get hasValidSelectedMenuItem => _selectedMenuItem != noSelectedMenuItem;

  bool _settingsVisible = false;
  bool get settingsVisible => _settingsVisible;
  set settingsVisible(bool value) {
    if (_settingsVisible != value) {
      _settingsVisible = value;
      notifyListeners();
    }
  }

  List<DemoMenuItem> fetchMenuItems() {
    List<DemoMenuItem> children = [];
    for (DemoMenuItem root in rootMenus) {
      _recursiveFetchMenuItems(root, children);
    }
    return children;
  }

  /// Recursive fetch considering only the expanded ones.
  void _recursiveFetchMenuItems(
      DemoMenuItem parent, List<DemoMenuItem> children) {
    children.add(parent);
    if (parent.expanded) {
      for (int index = 0; index < parent.childrenLength; index++) {
        DemoMenuItem child = parent.childAt(index);
        _recursiveFetchMenuItems(child, children);
      }
    }
  }

  Future<void> initializeHighlighter() async {
    if (_highlighter == null) {
      await Highlighter.initialize(['dart']);
      HighlighterTheme theme = await HighlighterTheme.loadLightTheme();
      _highlighter = Highlighter(
        language: 'dart',
        theme: theme,
      );
    }
  }
}

final DemoMenuItem noSelectedMenuItem = DemoMenuItem('');
