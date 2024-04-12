import 'package:demoflu/src/page/page_section.dart';
import 'package:flutter/material.dart';

/// Section to display a banner.
class BannerSection extends PageSection {
  BannerSection(
      {required super.marginLeft,
      required super.marginBottom,
      required super.maxWidth,
      required String text,
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
  Widget buildContent(BuildContext context) {
    return _BannerSectionWidget(
        text: TextSpan(text: text),
        background: background,
        border: border,
        icon: icon);
  }
}

/// Widget for banner section.
class _BannerSectionWidget extends StatelessWidget {
  const _BannerSectionWidget(
      {required this.background,
      required this.border,
      required this.text,
      required this.icon});

  final Color background;
  final Color border;
  final TextSpan text;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    Widget widget = _textWidget();
    if (icon != null) {
      widget = Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Icon(icon!, color: border), SizedBox(width: 8),
        Flexible(child: widget) //Expanded(child: widget)
      ]);
    }
    return Align(alignment: Alignment.centerLeft, child: widget);
  }

  Widget _textWidget() {
    return Container(
        decoration: BoxDecoration(
            color: background,
            border: Border(left: BorderSide(color: border, width: 8))),
        child: Padding(
            padding: EdgeInsets.all(8), child: SelectableText.rich(text)));
  }
}
