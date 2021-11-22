import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

abstract class Example {
  _Notifier _mainWidgetNotifier = _Notifier();

  Widget buildMainWidget(BuildContext context);

  void addMainWidgetListener(VoidCallback listener) {
    _mainWidgetNotifier.addListener(listener);
  }

  void removeMainWidgetListener(VoidCallback listener) {
    _mainWidgetNotifier.removeListener(listener);
  }

  void notifyMainWidgetListeners() {
    _mainWidgetNotifier.notify();
  }
}

mixin ExtraWidgetsMixin {
  Widget? buildExtraWidget(BuildContext context, String name);

  List<String> extraWidgetNames();
}

class _Notifier extends ChangeNotifier {
  void notify() {
    notifyListeners();
  }
}
