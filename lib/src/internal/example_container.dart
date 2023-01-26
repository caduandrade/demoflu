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
      final Example example = widget.settings.example!;

      Widget? column;
      if (widget.settings.extraWidgetsVisible) {
        List<Widget> children = [];
        ExtraWidgetsMixin mixin = example as ExtraWidgetsMixin;
        for (String name in widget.settings.extraWidgetsNames) {
          Widget? w = mixin.buildExtraWidget(context, name);
          if (w != null) {
            children.add(Container(
                child: Text(name, style: TextStyle(color: Colors.white)),
                color: Colors.blueGrey[800],
                padding: EdgeInsets.all(8)));
            children.add(w);
          }
        }
        if (children.isNotEmpty) {
          column = Container(
              child: SingleChildScrollView(
                  child: Column(
                      children: children,
                      crossAxisAlignment: CrossAxisAlignment.stretch)),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border:
                      Border(left: BorderSide(color: Colors.blueGrey[900]!))));
          column = ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 200, minWidth: 200),
              child: column);
        }
      }

      List<Widget> children = [];

      Widget exampleWidget =
          Expanded(child: ResizableExampleWidget(settings: widget.settings));
      if (column != null) {
        children.add(Expanded(
            child: Row(
                children: [exampleWidget, column],
                crossAxisAlignment: CrossAxisAlignment.stretch)));
      } else {
        children.add(exampleWidget);
      }

      if (constraints.maxHeight > 150) {
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
