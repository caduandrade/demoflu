import 'package:demoflu/src/example.dart';
import 'package:demoflu/src/example/bar/abstract_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SizeBar extends AbstractBar {

  @override
  Widget buildContent(BuildContext context, String? sectionName, DFExample example) {
    return Text('max width: ' + example.maxSize!.width.toString() + ' / max height: ' + example.maxSize!.height.toString());
  }
}
