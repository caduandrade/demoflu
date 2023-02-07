import 'package:flutter/widgets.dart';

/// Notifier to rebuilds the UI.
class RebuildNotifier extends ChangeNotifier {
  /// Notifies that there has been a change in the structure of the tree.
  void treeStructChange() {
    notifyListeners();
  }
}
