import 'package:demoflu/src/example.dart';
import 'package:demoflu/src/example/bar/abstract_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NameBar extends AbstractBar {

  @override
  Widget buildContent(BuildContext context, String? sectionName, DFExample example) {
    String name = example.name;
    if (sectionName != null) {
      name = '$sectionName > $name';
    }
    return Text(name);
  }
}
