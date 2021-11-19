import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

abstract class Example extends ChangeNotifier {
  Widget buildMainWidget(BuildContext context);
}

mixin ExtraWidgetsMixin {
  Widget? buildExtraWidget(BuildContext context, String name);

  List<String> extraWidgetNames();
}
