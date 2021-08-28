import 'package:demoflu/demoflu.dart';
import 'package:demoflu/src/demoflu_app.dart';
import 'package:demoflu/src/menu_item.dart';
import 'package:demoflu/src/menu/example_menu_layout.dart';
import 'package:demoflu/src/menu/example_menu_widgets.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class ExampleMenu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ExampleMenuState();
}

class _ExampleMenuState extends State<ExampleMenu> {
  Color dialogColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    DemoFluAppState state = DemoFluAppState.of(context)!;

    MenuItem menuItem = state.currentMenuItem!;

    List<LayoutConf> children = [];

    int row = 1;
    if (menuItem.codeFile != null) {
      children.add(
          LayoutConf(conf: Conf(row: row, widget: false), child: Text('code')));
      children.add(LayoutConf(
          conf: Conf(row: row, widget: true),
          child: Checkbox(
              value: state.codeVisible,
              onChanged: (value) => state.codeVisible = value!)));
      row++;

      children.add(LayoutConf(
          conf: Conf(row: row, widget: false), child: Text('widget')));
      children.add(LayoutConf(
          conf: Conf(row: row, widget: true),
          child: Checkbox(
              value: state.widgetVisible,
              onChanged: (value) => state.widgetVisible = value!)));
      row++;
    }

    if (state.isConsoleEnabled(menuItem)) {
      children.add(LayoutConf(
          conf: Conf(row: row, widget: false), child: Text('console')));
      children.add(LayoutConf(
          conf: Conf(row: row, widget: true),
          child: Checkbox(
              value: state.consoleVisible,
              onChanged: (value) => state.consoleVisible = value!)));
      row++;
    }

    if (state.widgetVisible && state.isResizable(menuItem)) {
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

    Widget colorIndicator = Padding(
        child: ColorIndicator(
          width: 28,
          height: 28,
          borderRadius: 4,
          hasBorder: true,
          borderColor: Colors.grey[700],
          color: state.widgetBackground,
          onSelectFocus: false,
          onSelect: () async {
            dialogColor = state.widgetBackground;
            if (await colorPickerDialog(context)) {
              state.widgetBackground = dialogColor;
            }
          },
        ),
        padding: EdgeInsets.all(6));

    children.add(LayoutConf(
        conf: Conf(row: row, widget: false), child: Text('background')));
    children.add(
        LayoutConf(conf: Conf(row: row, widget: true), child: colorIndicator));
    row++;

    if (menuItem.example is ExampleStateful) {
      ExampleStateful exampleStateful = menuItem.example as ExampleStateful;
      exampleStateful.menuWidgets().forEach((menuWidget) {
        if (menuWidget is MenuButton) {
          MenuButton menuButton = menuWidget;
          children.add(LayoutConf(
              conf: Conf(row: row, widget: true, span: true),
              child: Padding(
                  child: ElevatedButton(
                    child: Text(menuButton.name),
                    onPressed: () {
                      DemoFlu.notifyMenuButtonClick(context, menuButton);
                    },
                  ),
                  padding: EdgeInsets.only(bottom: 8))));
        }
        row++;
      });
    }

    if (children.isEmpty) {
      return SizedBox(width: 0);
    }
    Widget menu = MenuLayout(children: children);

    menu = SliderTheme(
        child: menu,
        data: SliderThemeData(
            overlayShape: RoundSliderOverlayShape(overlayRadius: 14),
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8)));

    menu =
        CheckboxTheme(child: menu, data: CheckboxThemeData(splashRadius: 14));

    return Container(
        child: SingleChildScrollView(
            child: Padding(child: menu, padding: EdgeInsets.all(8))),
        decoration: BoxDecoration(
            color: Colors.blueGrey[100],
            border: Border(
                right: BorderSide(width: 1, color: Colors.blueGrey[700]!))));
  }

  Future<bool> colorPickerDialog(BuildContext context) async {
    return ColorPicker(
      // Use the dialogPickerColor as start color.
      color: dialogColor,
      // Update the dialogPickerColor using the callback.
      onColorChanged: (Color color) => setState(() => dialogColor = color),
      width: 40,
      height: 40,
      borderRadius: 4,
      spacing: 5,
      runSpacing: 5,
      wheelDiameter: 155,
      heading: Text(
        'Select color',
        style: Theme.of(context).textTheme.subtitle1,
      ),
      subheading: Text(
        'Select color shade',
        style: Theme.of(context).textTheme.subtitle1,
      ),
      wheelSubheading: Text(
        'Selected color and its shades',
        style: Theme.of(context).textTheme.subtitle1,
      ),
      showMaterialName: true,
      showColorName: true,
      showColorCode: true,
      materialNameTextStyle: Theme.of(context).textTheme.caption,
      colorNameTextStyle: Theme.of(context).textTheme.caption,
      colorCodeTextStyle: Theme.of(context).textTheme.caption,
      pickersEnabled: const <ColorPickerType, bool>{
        ColorPickerType.both: false,
        ColorPickerType.primary: true,
        ColorPickerType.accent: false,
        ColorPickerType.bw: true,
        ColorPickerType.custom: false,
        ColorPickerType.wheel: false,
      },
      // customColorSwatchesAndNames: colorsNameMap,
    ).showPickerDialog(
      context,
      constraints:
          const BoxConstraints(minHeight: 460, minWidth: 300, maxWidth: 320),
    );
  }
}
