import 'package:flutter/widgets.dart';

/// Base page section class.
abstract class PageSection {
  /// Builds the widget for this section.
  Widget buildWidget(BuildContext context);
}
