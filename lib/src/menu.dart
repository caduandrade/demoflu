import 'package:demoflu/demoflu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DemoFluMenuItem extends StatelessWidget {
  const DemoFluMenuItem(
      {required this.text,
      required this.builder,
      this.resizableContent = false});

  final String text;
  final WidgetBuilder builder;
  final bool resizableContent;

  @override
  Widget build(BuildContext context) {
    DemoFluAppState state = DemoFluAppState.of(context)!;
    return InkWell(child: Text(text), onTap: () => state.updateFor(this));
  }
}

class DemoFluMenuSection extends StatelessWidget {
  final String? text;
  final List<DemoFluMenuItem> menuItems;

  const DemoFluMenuSection({this.text, required this.menuItems});

  @override
  Widget build(BuildContext context) {
    return Column(children: menuItems);
  }
}

class DemoFluMenu extends StatelessWidget {
  const DemoFluMenu({required this.sections});

  final List<DemoFluMenuSection> sections;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return SingleChildScrollView(
        child: Container(
            child: Column(children: sections), color: theme.accentColor));
  }
}
