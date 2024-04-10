import 'package:flutter/widgets.dart';

/// Base page section class.
abstract class PageSection {
  /// Builds the widget for this section.
  Widget buildWidget(BuildContext context);

  double? _bottom;
  double? get bottom => _bottom;
  set bottom(double? value){
    if(value!=null) {
      value=value>=0?value:0;
    }
    _bottom = value;
  }
}

