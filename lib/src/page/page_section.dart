import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// Page section.
abstract class PageSection {
  PageSection(
      {required double? marginLeft,
      required double? marginBottom,
      required this.maxWidth}) {
    this.marginLeft = marginLeft;
    this.marginBottom = marginBottom;
  }

  double? _marginLeft;
  double? get marginLeft => _marginLeft;
  set marginLeft(double? value) {
    if (value != null) {
      value = value >= 0 ? value : 0;
    }
    _marginLeft = value;
  }

  double? _marginBottom;
  double? get marginBottom => _marginBottom;
  set marginBottom(double? value) {
    if (value != null) {
      value = value >= 0 ? value : 0;
    }
    _marginBottom = value;
  }

  double get minHeight => 0;
  double get maxHeight => double.infinity;
  double maxWidth;

  /// Runs a macro.
  void runMacro({required dynamic id, required BuildContext context});

  /// Builds the widget for this section content.
  Widget buildContent(BuildContext context);
}
