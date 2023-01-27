import 'package:demoflu/src/internal/code_widget.dart';
import 'package:demoflu/src/internal/demoflu_settings.dart';
import 'package:demoflu/src/internal/example_container.dart';
import 'package:demoflu/src/internal/switch_view/switch_view_toggle_buttons.dart';
import 'package:demoflu/src/internal/switch_view/switch_view_type.dart';
import 'package:flutter/material.dart';

class SwitchView extends StatefulWidget {
  const SwitchView({Key? key, required this.settings}) : super(key: key);

  final DemoFluSettings settings;

  @override
  State<StatefulWidget> createState() => SwitchViewState();
}

class SwitchViewState extends State<SwitchView> {
  SwitchViewType _selectedType = SwitchViewType.example;

  @override
  Widget build(BuildContext context) {
    ExampleContainer exampleWidget =
        ExampleContainer(settings: widget.settings);
    CodeWidget? codeWidget = widget.settings.code != null
        ? CodeWidget(code: widget.settings.code!)
        : null;
    List<Widget> barExtraWidgets =
        widget.settings.example!.buildBarWidgets(context);

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
        child: Wrap(children: children, spacing: 8),
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
