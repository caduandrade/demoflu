import 'package:flutter/material.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget(
      {super.key,
      required this.background,
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
