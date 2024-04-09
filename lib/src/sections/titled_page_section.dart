import 'package:demoflu/src/sections/page_section.dart';
import 'package:flutter/widgets.dart';

/// Base class of sessions that can have a title.
abstract class TitledPageSection extends PageSection {
  TitledPageSection(
      {required this.title,
      required this.minWidth,
      required this.maxWidth,
      required this.minHeight,
      required this.maxHeight,
      required this.bordered,
      required this.background,
      required this.padding});
  String? title;
  EdgeInsetsGeometry? padding;
  double minWidth;
  double maxWidth;
  double minHeight;
  double maxHeight;
  double? aspectRatio;
  bool bordered;
  Color? background;
}
