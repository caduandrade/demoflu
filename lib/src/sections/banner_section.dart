import 'package:demoflu/src/internal/sections/banner_section_ui.dart';
import 'package:demoflu/src/sections/page_section.dart';
import 'package:flutter/material.dart';

/// Session to display a banner.
class BannerSection extends PageSection {
  BannerSection(
      {required String text,
      required this.background,
      required this.border,
      required this.icon})
      : _text = text;

  Color background;
  Color border;
  IconData? icon;

  String _text;
  String get text => _text;

  void add(String value) {
    _text += value;
  }

  @override
  Widget buildWidget(BuildContext context) {
    return BannerSectionUI(
        text: TextSpan(text: text),
        background: background,
        border: border,
        icon: icon);
  }
}
