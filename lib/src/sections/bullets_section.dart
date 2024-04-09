import 'dart:collection';

import 'package:demoflu/src/internal/sections/bullets_widget.dart';
import 'package:demoflu/src/sections/page_section.dart';
import 'package:flutter/src/widgets/framework.dart';

/// Session to display bullets.
class BulletsSection extends PageSection {
  BulletsSection() {
    bullets = UnmodifiableListView(_bullets);
  }

  List<Bullet> _bullets = [];
  late List<Bullet> bullets;

  Bullet create({int indent = 0, String? text}) {
    indent = indent < 0 ? 0 : indent;
    indent = indent > 3 ? 3 : indent;
    Bullet bullet = Bullet(indent: indent, text: text ?? '');
    _bullets.add(bullet);
    return bullet;
  }

  @override
  Widget buildWidget(BuildContext context) {
    return BulletsWidget(bullets: bullets);
  }
}

class Bullet {
  Bullet({required this.indent, required String text}) : _text = text;

  final int indent;
  String _text;
  String get text => _text;

  void add(String value) {
    _text += value;
  }
}
