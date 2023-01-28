import 'package:demoflu/src/internal/demoflu_settings.dart';
import 'package:demoflu/src/internal/view.dart';
import 'package:flutter/material.dart';

class SwitchViewToggleButtons extends StatelessWidget {
  const SwitchViewToggleButtons({Key? key, required this.settings})
      : super(key: key);

  final DemoFluSettings settings;

  static const List<Widget> views = <Widget>[
    Text('Code'),
    Text('Example'),
    Text('Both')
  ];

  List<bool> get _selectedViews {
    List<bool> list;
    if (settings.view == DemofluView.code) {
      list = [true, false, false];
    } else if (settings.view == DemofluView.example) {
      list = [false, true, false];
    } else {
      list = [false, false, true];
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      direction: Axis.horizontal,
      onPressed: _onPressed,
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      borderColor: Colors.blueGrey[200],
      selectedBorderColor: Colors.blueGrey[200],
      selectedColor: Colors.white,
      fillColor: Colors.blueGrey[600],
      color: Colors.blueGrey[400],
      constraints: const BoxConstraints(
        minHeight: 25,
        minWidth: 80,
      ),
      isSelected: _selectedViews,
      children: views,
    );
  }

  void _onPressed(int index) {
    if (index == 0) {
      settings.view = DemofluView.code;
    } else if (index == 1) {
      settings.view = DemofluView.example;
    } else if (index == 2) {
      settings.view = DemofluView.both;
    }
  }
}
