import 'package:demoflu/src/example.dart';
import 'package:demoflu/src/internal/console_widget.dart';
import 'package:demoflu/src/internal/demoflu_settings.dart';
import 'package:demoflu/src/internal/resizable_example_widget.dart';
import 'package:demoflu/src/internal/title_container.dart';
import 'package:flutter/material.dart';

class ExampleContainer extends StatefulWidget {
  const ExampleContainer({required this.settings, required this.resizable});

  final DemoFluSettings settings;
  final bool resizable;

  @override
  State<StatefulWidget> createState() => ExampleContainerState();
}

class ExampleContainerState extends State<ExampleContainer> {
  bool _consoleExpanded = true;

  @override
  void initState() {
    super.initState();
    widget.settings.example?.addListener(_rebuild);
  }

  @override
  void dispose() {
    widget.settings.example?.removeListener(_rebuild);
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant ExampleContainer oldWidget) {
    oldWidget.settings.example?.removeListener(_rebuild);
    widget.settings.example?.addListener(_rebuild);
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
      final AbstractExample example = widget.settings.example!;

      List<Widget> children = [];

      Widget exampleWidget = Expanded(
          child: widget.resizable
              ? ResizableExampleWidget(settings: widget.settings)
              : Container(
                  color: widget.settings.exampleBackground,
                  child: widget.settings.example!.buildWidget(context)));

      children.add(exampleWidget);

      if (example.consoleEnabled && constraints.maxHeight > 150) {
        children.add(ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 150, minHeight: 0),
            child: TitleContainer(
                title: 'Console',
                onResize: _onConsoleResize,
                extraButton: IconButton(
                    onPressed: () => widget.settings.console.clear(),
                    icon: Icon(Icons.delete, color: Colors.white)),
                child: _consoleExpanded
                    ? ConsoleWidget(settings: widget.settings)
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
