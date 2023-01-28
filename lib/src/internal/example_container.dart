import 'package:demoflu/src/example.dart';
import 'package:demoflu/src/internal/console_controller.dart';
import 'package:demoflu/src/internal/console_widget.dart';
import 'package:demoflu/src/internal/demoflu_settings.dart';
import 'package:demoflu/src/internal/resizable_example_widget.dart';
import 'package:demoflu/src/internal/title_container.dart';
import 'package:flutter/material.dart';

class ExampleContainer extends StatefulWidget {
  ExampleContainer(
      {required Key key,
      required this.settings,
      required this.resizable,
      required this.example,
      required this.console})
      : super(key: key);

  final DemoFluSettings settings;
  final bool resizable;
  final AbstractExample example;
  final ConsoleController console;

  @override
  State<StatefulWidget> createState() => ExampleContainerState();
}

class ExampleContainerState extends State<ExampleContainer> {
  bool _consoleExpanded = true;

  @override
  void initState() {
    super.initState();
    widget.example.addListener(_rebuild);
  }

  @override
  void dispose() {
    widget.example.removeListener(_rebuild);
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant ExampleContainer oldWidget) {
    oldWidget.example.removeListener(_rebuild);
    widget.example.addListener(_rebuild);
    super.didUpdateWidget(oldWidget);
  }

  void _rebuild() {
    setState(() {
      // rebuilds
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      List<Widget> children = [];

      Widget exampleWidget = Expanded(
          child: widget.resizable
              ? ResizableExampleWidget(
                  settings: widget.settings, example: widget.example)
              : Container(
                  color: widget.settings.exampleBackground,
                  child: widget.example.buildWidget(context)));

      children.add(exampleWidget);

      if (widget.example.consoleEnabled && constraints.maxHeight > 150) {
        children.add(ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 150, minHeight: 0),
            child: TitleContainer(
                title: 'Console',
                onResize: _onConsoleResize,
                extraButton: IconButton(
                    onPressed: () => widget.console.clear(),
                    icon: Icon(Icons.delete, color: Colors.white)),
                child: _consoleExpanded
                    ? ConsoleWidget(console: widget.console)
                    : null)));
      }
      return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, children: children);
    });
  }

  void _onConsoleResize(bool collapsed) {
    setState(() {
      _consoleExpanded = collapsed;
    });
  }
}
