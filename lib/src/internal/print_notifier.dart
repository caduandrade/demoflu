import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

/// Notifier for console output.
@internal
class PrintNotifier extends ChangeNotifier {
  int _count = 0;
  final List<String> _values = [];
  late UnmodifiableListView<String> values =
      UnmodifiableListView<String>(_values);

  update(String text) {
    _count++;
    _values.insert(0, '[$_count]  $text');
    notifyListeners();
  }

  clear({required bool notify}) {
    _count = 0;
    _values.clear();
    if (notify) {
      notifyListeners();
    }
  }
}
