import 'package:demoflu/src/internal/demoflu_settings.dart';
import 'package:demoflu/src/internal/ratio.dart';
import 'package:flutter/material.dart';

class RatioToggleButtons extends StatelessWidget {
  const RatioToggleButtons({Key? key, required this.settings})
      : super(key: key);

  final DemoFluSettings settings;

  static const List<Widget> ratios = <Widget>[
    Text('1:1'),
    Text('1:2'),
    Text('2:1')
  ];

  List<bool> get _selectedRatios {
    List<bool> list;
    if (settings.ratio == DemofluRatio.ratio1_1) {
      list = [true, false, false];
    } else if (settings.ratio == DemofluRatio.ratio1_2) {
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
        minWidth: 50,
      ),
      isSelected: _selectedRatios,
      children: ratios,
    );
  }

  void _onPressed(int index) {
    if (index == 0) {
      settings.ratio = DemofluRatio.ratio1_1;
    } else if (index == 1) {
      settings.ratio = DemofluRatio.ratio1_2;
    } else if (index == 2) {
      settings.ratio = DemofluRatio.ratio_2_1;
    }
  }
}
