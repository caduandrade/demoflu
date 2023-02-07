import 'package:demoflu/src/example.dart';
import 'package:flutter/material.dart';

/// Represents a menu item in the app menu.
class DemoMenuItem extends ChangeNotifier {
  DemoMenuItem(this.name,
      {this.example, List<DemoMenuItem> children = const []}) {
    for (DemoMenuItem child in children) {
      _children.add(child);
      child._parent = this;
    }
  }

  /// The menu name.
  final String name;

  /// Optional example
  final AbstractExample? example;

  /// Sub menus
  final List<DemoMenuItem> _children = [];

  int get childrenLength => _children.length;

  bool get isChildrenEmpty => _children.isEmpty;

  DemoMenuItem childAt(int index) => _children[index];

  void add(DemoMenuItem menuItem) {
    _children.add(menuItem);
    menuItem._parent = this;
  }

  /// Parent menu. It will be [NULL] if it is root.
  DemoMenuItem? _parent;

  /// The indentation value according to the level in the tree hierarchy.
  int get indent {
    int value = 0;
    DemoMenuItem? p = _parent;
    while (p != null) {
      p = p._parent;
      value++;
    }
    return value;
  }

  bool _expanded = true;

  /// Identifies whether it is expanded to display submenus.
  bool get expanded => _expanded;

  set expanded(bool value) {
    if (_expanded != value) {
      _expanded = value;
      notifyListeners();
    }
  }
}
