import 'package:flutter/material.dart';

typedef OnResize = void Function(bool expanded);

@deprecated
class TitleContainer extends StatelessWidget {
  const TitleContainer(
      {Key? key,
      required this.title,
      required this.onResize,
      this.extraButton,
      this.child})
      : super(key: key);

  final String title;
  final Widget? child;
  final OnResize onResize;
  final IconButton? extraButton;

  @override
  Widget build(BuildContext context) {
    Widget headerWidget = _HeaderWidget(
        title: title,
        onResize: onResize,
        expanded: child != null,
        extraButton: extraButton);

    if (child != null) {
      return Column(
          children: [headerWidget, Expanded(child: child!)],
          crossAxisAlignment: CrossAxisAlignment.stretch);
    }
    return headerWidget;
  }
}

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget(
      {Key? key,
      required this.title,
      required this.extraButton,
      required this.onResize,
      required this.expanded})
      : super(key: key);

  final String title;
  final OnResize onResize;
  final IconButton? extraButton;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    children.add(
        Expanded(child: Text(title, style: TextStyle(color: Colors.white))));
    if (extraButton != null) {
      children.add(extraButton!);
    }
    children.add(IconButton(
        onPressed: _onResizeButtonPressed,
        icon: Icon(_resizeIcon, color: Colors.white)));
    return Container(
        decoration: BoxDecoration(
            color: Colors.blueGrey[800],
            border: Border(
                top: BorderSide(color: Colors.blueGrey[900]!),
                bottom: BorderSide(color: Colors.blueGrey[900]!))),
        padding: EdgeInsets.all(8),
        child: Row(children: children));
  }

  IconData get _resizeIcon => expanded ? Icons.expand_less : Icons.expand_more;

  void _onResizeButtonPressed() {
    onResize(!expanded);
  }
}
