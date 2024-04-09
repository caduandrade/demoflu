import 'package:demoflu/src/sections/bullets_section.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

/// Widget for bullets session.
@internal
class BulletsSectionUI extends StatelessWidget {
  const BulletsSectionUI({super.key, required this.bullets});

  final List<Bullet> bullets;

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    for (int i = 0; i < bullets.length; i++) {
      Bullet bullet = bullets[i];
      children.add(Padding(
          padding: EdgeInsets.fromLTRB(16.0 * bullet.indent, 0, 0, 0),
          child: Row(children: [
            Icon(_iconData(bullet.indent), size: 9),
            SizedBox(width: 8),
            Expanded(child: SelectableText(bullet.text))
          ], crossAxisAlignment: CrossAxisAlignment.center)));
      if (i < bullets.length - 1) {
        children.add(SizedBox(height: 8));
      }
    }
    return Column(
        children: children, crossAxisAlignment: CrossAxisAlignment.stretch);
  }

  IconData _iconData(int indent) {
    switch (indent) {
      case 0:
        return Icons.circle_sharp;
      case 1:
        return Icons.circle_outlined;
      case 2:
        return Icons.square_sharp;
      case 3:
        return Icons.square_outlined;
      default:
        throw ArgumentError.value(indent, 'Unknown', 'indent');
    }
  }
}
