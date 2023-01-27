import 'package:demoflu/src/internal/demoflu_settings.dart';
import 'package:demoflu/src/example.dart';
import 'package:demoflu/src/internal/console_widget.dart';
import 'package:demoflu/src/internal/resizable_example_widget.dart';
import 'package:demoflu/src/internal/title_container.dart';
import 'package:flutter/material.dart';

class ExampleContainer extends StatefulWidget {
  const ExampleContainer({required this.settings});

  final DemoFluSettings settings;

  @override
  State<StatefulWidget> createState() => ExampleContainerState();
}

class ExampleContainerState extends State<ExampleContainer> {
  bool _consoleExpanded = true;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final AbstractExample example = widget.settings.example!;


      List<Widget> children = [];

      Widget exampleWidget =
          Expanded(child: ResizableExampleWidget(settings: widget.settings));

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
