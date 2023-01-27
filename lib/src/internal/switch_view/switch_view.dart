import 'package:demoflu/src/example.dart';
import 'package:demoflu/src/internal/code_widget.dart';
import 'package:demoflu/src/internal/console_controller.dart';
import 'package:demoflu/src/internal/demoflu_settings.dart';
import 'package:demoflu/src/internal/example_container.dart';
import 'package:demoflu/src/internal/switch_view/switch_view_toggle_buttons.dart';
import 'package:demoflu/src/internal/switch_view/switch_view_type.dart';
import 'package:flutter/material.dart';

class SwitchView extends StatefulWidget {
  const SwitchView(
      {Key? key,
      required this.settings,
      required this.example,
      required this.console})
      : super(key: key);

  final DemoFluSettings settings;
  final AbstractExample example;
  final ConsoleController console;

  @override
  State<StatefulWidget> createState() => SwitchViewState();
}

class SwitchViewState extends State<SwitchView> {
  SwitchViewType _selectedType = SwitchViewType.example;

  @override
  Widget build(BuildContext context) {
    List<Widget> barExtraWidgets = widget.example.buildBarWidgets(context);

    final bool resizable =
        widget.example.resizable ?? widget.settings.resizable;

    if (resizable) {
      barExtraWidgets.insert(
          0,
          _CheckWidget(
              value: widget.settings.resizeEnabled,
              title: 'resizable',
              onChanged: (value) => widget.settings.resizeEnabled =
                  !widget.settings.resizeEnabled));
    }

    ExampleContainer exampleWidget = ExampleContainer(
        settings: widget.settings,
        console: widget.console,
        resizable: resizable ? widget.settings.resizeEnabled : false,
        example: widget.example);
    CodeWidget? codeWidget = widget.example.codeFile != null
        ? CodeWidget(codeFile: widget.example.codeFile!)
        : null;

    if (codeWidget == null && barExtraWidgets.isEmpty) {
      // only example widget
      return exampleWidget;
    }

    List<Widget> barWidgetChildren = [];
    List<Widget> stackChildren = [exampleWidget];
    if (codeWidget != null) {
      barWidgetChildren.add(SwitchViewToggleButtons(
          onChange: _onViewChange, selected: _selectedType));
      if (_selectedType == SwitchViewType.example) {
        stackChildren.insert(0, codeWidget);
      } else {
        stackChildren.add(codeWidget);
      }
    }
    barWidgetChildren.addAll(barExtraWidgets);

    return Column(children: [
      _BarWidget(children: barWidgetChildren),
      Expanded(child: Stack(children: stackChildren, fit: StackFit.expand))
    ], crossAxisAlignment: CrossAxisAlignment.stretch);
  }

  void _onViewChange(SwitchViewType type) {
    setState(() {
      _selectedType = type;
    });
  }
}

class _BarWidget extends StatelessWidget {
  const _BarWidget({Key? key, required this.children}) : super(key: key);

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Wrap(
            children: children,
            spacing: 16,
            crossAxisAlignment: WrapCrossAlignment.center),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 3,
                offset: Offset(0, 0), // changes position of shadow
              ),
            ],
            color: Colors.blueGrey[50],
            border: Border(bottom: BorderSide(color: Colors.blueGrey[700]!))));
  }
}

class _CheckWidget extends StatelessWidget {
  const _CheckWidget(
      {Key? key,
      required this.title,
      required this.value,
      required this.onChanged})
      : super(key: key);

  final String title;
  final bool value;
  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
        children: [Text(title), Checkbox(value: value, onChanged: onChanged)],
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center);
  }
}
