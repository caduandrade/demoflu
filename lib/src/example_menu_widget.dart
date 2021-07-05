import 'package:demoflu/src/demoflu_app.dart';
import 'package:demoflu/src/example.dart';
import 'package:demoflu/src/menu_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class ExampleMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DemoFluAppState state = DemoFluAppState.of(context)!;

    DFExample example = state.currentExample!;

    List<LayoutConf> children = [];

    int row = 1;
    if (example.codeFile != null) {
      children.add(
          LayoutConf(conf: Conf(row: row, widget: false), child: Text('code')));
      children.add(LayoutConf(
          conf: Conf(row: row, widget: true),
          child: Switch(
              value: state.codeVisible,
              onChanged: (value) => state.codeVisible = value)));
      row++;
    }

    children.add(
        LayoutConf(conf: Conf(row: row, widget: false), child: Text('widget')));
    children.add(LayoutConf(
        conf: Conf(row: row, widget: true),
        child: Switch(
            value: state.widgetVisible,
            onChanged: (value) => state.widgetVisible = value)));
    row++;

    if (state.isConsoleEnabled(example)) {
      children.add(LayoutConf(
          conf: Conf(row: row, widget: false), child: Text('console')));
      children.add(LayoutConf(
          conf: Conf(row: row, widget: true),
          child: Switch(
              value: state.consoleVisible,
              onChanged: (value) => state.consoleVisible = value)));
      row++;
    }

    if (state.widgetVisible && state.isResizable(example)) {
      children.add(LayoutConf(
          conf: Conf(row: row, widget: false), child: Text('width')));
      children.add(LayoutConf(
          conf: Conf(row: row, widget: true),
          child: ConstrainedBox(
              child: Slider(
                value: state.widthWeight,
                min: 0,
                max: 1,
                label: state.widthWeight.round().toString(),
                onChanged: (double value) => state.widthWeight = value,
              ),
              constraints: BoxConstraints.tightFor(width: 100))));
      row++;

      children.add(LayoutConf(
          conf: Conf(row: row, widget: false), child: Text('height')));
      children.add(LayoutConf(
          conf: Conf(row: row, widget: true),
          child: ConstrainedBox(
              child: Slider(
                value: state.heightWeight,
                min: 0,
                max: 1,
                label: state.heightWeight.round().toString(),
                onChanged: (double value) => state.heightWeight = value,
              ),
              constraints: BoxConstraints.tightFor(width: 100))));
      row++;
    }

    int index = 0;
    example.buttons?.forEach((buttonName) {
      final i = index;
      children.add(LayoutConf(
          conf: Conf(row: row, widget: true, span: true),
          child: Padding(
              child: ElevatedButton(
                child: Text(buttonName),
                onPressed: () {
                  DemoFlu.notifyMenuButtonClick(context, i);
                },
              ),
              padding: EdgeInsets.only(bottom: 8))));
      row++;
      index++;
    });

    return Container(
        child: SingleChildScrollView(
            child: Padding(
                child: SliderTheme(
                    child: MenuLayout(children: children),
                    data: SliderThemeData(
                        thumbShape:
                            RoundSliderThumbShape(enabledThumbRadius: 8))),
                padding: EdgeInsets.all(8))),
        decoration: BoxDecoration(
            color: Colors.blueGrey[100],
            border: Border(
                right: BorderSide(width: 1, color: Colors.blueGrey[700]!))));
  }
}
