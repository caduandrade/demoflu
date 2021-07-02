import 'package:demoflu/src/demoflu_app.dart';
import 'package:demoflu/src/example.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ExampleBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DemoFluAppState state = DemoFluAppState.of(context)!;
    String? sectionName = state.currentMenuItem!.sectionName;
    DFExample example = state.currentMenuItem!.example;

    String name = example.name;
    if (sectionName != null) {
      name = '$sectionName > $name';
    }
    List<Widget> children = [
      Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(width: 32)
    ];

    if (example.resizable) {
      children.add(Text('width:'));
      children.add(LimitedBox(
          child: Slider(
            value: state.widthWeight,
            min: 0,
            max: 1,
            label: state.widthWeight.round().toString(),
            onChanged: (double value) => state.widthWeight = value,
          ),
          maxWidth: 100));
      children.add(SizedBox(width: 32));
      children.add(Text('height:'));
      children.add(LimitedBox(
          child: Slider(
            value: state.heightWeight,
            min: 0,
            max: 1,
            label: state.heightWeight.round().toString(),
            onChanged: (double value) => state.heightWeight = value,
          ),
          maxWidth: 100));
      children.add(SizedBox(width: 32));
    }

    return Container(
        child: SliderTheme(
            child: Row(children: children),
            data: SliderThemeData(
                overlayShape: SliderComponentShape.noOverlay,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8))),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.blueGrey[100],
            border: Border(
                bottom: BorderSide(width: 1, color: Colors.blueGrey[500]!))));
  }
}
