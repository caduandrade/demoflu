import 'package:demoflu/demoflu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:syntax_highlight/syntax_highlight.dart';

/// DemoFlu model.
@internal
class DemoFluModel extends ChangeNotifier {
  DemoFluModel({required this.title, required this.rootMenus}) {
    List<DemoMenuItem> menuItems = fetchMenuItems();
    int firstMenuItemIndex = menuItems.indexWhere((item) => item.page != null);
    if (firstMenuItemIndex != -1) {
      _selectedMenuItem = menuItems[firstMenuItemIndex];
    }
  }

  final String title;

  /// List with root menus.
  final List<DemoMenuItem> rootMenus;

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
