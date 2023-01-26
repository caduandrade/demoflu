import 'package:demoflu/src/internal/demoflu_settings.dart';
import 'package:demoflu/src/internal/code_widget.dart';
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
    if (widget.settings.code == null) {
      // no code available
      return exampleWidget;
    }
    CodeWidget codeWidget = CodeWidget(code: widget.settings.code!);

    List<Widget> children = [];
    if (_selectedType == SwitchViewType.example) {
      children = [codeWidget, exampleWidget];
    } else {
      children = [exampleWidget, codeWidget];
    }

    return Column(children: [
      SwitchViewToggleButtons(onChange: _onViewChange, selected: _selectedType),
      Expanded(child: Stack(children: children, fit: StackFit.expand))
    ], crossAxisAlignment: CrossAxisAlignment.stretch);
  }

  void _onViewChange(SwitchViewType type) {
    setState(() {
      _selectedType = type;
    });
  }
}
