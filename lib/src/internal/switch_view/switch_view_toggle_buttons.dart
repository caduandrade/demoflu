import 'package:demoflu/src/internal/switch_view/switch_view_type.dart';
import 'package:flutter/material.dart';

typedef OnSwitchViewChange = void Function(SwitchViewType viewType);

class SwitchViewToggleButtons extends StatelessWidget {
  const SwitchViewToggleButtons(
      {Key? key, required this.onChange, required this.selected})
      : super(key: key);

  final OnSwitchViewChange onChange;
  final SwitchViewType selected;

  static const List<Widget> views = <Widget>[Text('Code'), Text('Example')];

  List<bool> get _selectedViews {
    List<bool> list = [];
    for (SwitchViewType type in SwitchViewType.values) {
      list.add(selected == type);
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      direction: Axis.horizontal,
      onPressed: (int index) => onChange(SwitchViewType.values[index]),
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
}
