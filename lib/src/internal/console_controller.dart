import 'dart:collection';

import 'package:flutter/widgets.dart';

class ConsoleController extends ChangeNotifier {
  int _count = 0;
  final List<String> _values = [];
  late UnmodifiableListView<String> values =
      UnmodifiableListView<String>(_values);

  update(String text) {
    _count++;
    _values.insert(0, '[$_count]  $text');
    notifyListeners();
  }

  clear() {
    _count = 0;
    _values.clear();
    notifyListeners();
  }
}
