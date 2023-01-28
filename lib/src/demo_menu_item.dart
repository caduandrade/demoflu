import 'package:demoflu/src/example.dart';

/// Represents a menu item in the app menu.
class DemoMenuItem {
  DemoMenuItem({required this.name, this.example, this.children = const []}) {
    for (DemoMenuItem child in children) {
      child._parent = this;
    }
  }

  final String name;
  final AbstractExample? example;
  final List<DemoMenuItem> children;

  DemoMenuItem? _parent;

  int get indentation => _parent == null ? 1 : _parent!.indentation + 1;

  DemoMenuItem? _findFirstExample() {
    if (example != null) {
      return this;
    }
    for (DemoMenuItem child in children) {
      DemoMenuItem? item = child._findFirstExample();
      if (item != null) {
        return item;
      }
    }
    return null;
  }

  void _recursiveFetch(List<DemoMenuItem> list) {
    list.add(this);
    for (DemoMenuItem child in children) {
      child._recursiveFetch(list);
    }
  }

  static List<DemoMenuItem> recursiveFetch(List<DemoMenuItem> roots) {
    List<DemoMenuItem> list = [];
    for (DemoMenuItem root in roots) {
      root._recursiveFetch(list);
    }
    return list;
  }

  static DemoMenuItem? findFirstExample(List<DemoMenuItem> list) {
    for (DemoMenuItem listItem in list) {
      DemoMenuItem? item = listItem._findFirstExample();
      if (item != null) {
        return item;
      }
    }
    return null;
  }
}
