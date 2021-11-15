import 'dart:math' as math;

import 'package:demoflu/src/console_widget.dart';
import 'package:demoflu/src/demoflu_app.dart';
import 'package:demoflu/src/menu_item.dart';
import 'package:demoflu/src/slider.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/github.dart';
import 'package:multi_split_view/multi_split_view.dart';

class TempWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TempState();
}

class TempState extends State<TempWidget> {
  Color dialogColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    DemoFluAppState state = DemoFluAppState.of(context)!;

    List<LayoutId> children = [];
    if (state.currentMenuItem != null) {
      MenuItem menuItem = state.currentMenuItem!;
      children.add(LayoutId(id: _Id.exampleArea, child: _buildExampleArea(state)));
      if (state.widgetVisible && state.isResizable(menuItem)) {
        children.add(LayoutId(
            id: _Id.width,
            child: Padding(
                child: DemofluSlider(
                    barColor: Colors.blueGrey[200]!,
                    activeBarColor: Colors.blueGrey[800]!,
                    markerColor: Colors.blueGrey[900]!,
                    value: state.widthWeight,
                    onChanged: (double value) => state.widthWeight = value),
                padding: EdgeInsets.only(bottom: 8, top: 8))));

/*
        children.add(LayoutId(
            id: _Id.height,
            child: Slider(
              value: state.heightWeight,
              min: 0,
              max: 1,
              label: state.heightWeight.round().toString(),
              onChanged: (double value) => state.heightWeight = value,
            )));
*/
        children.add(
            LayoutId(id: _Id.background, child: _buildColorIndicator(state)));
      }
    } else {
      children.add(
          LayoutId(id: _Id.exampleArea, child: Center(child: Text('Loading...'))));
    }

    return Container(
        child: CustomMultiChildLayout(delegate: _Layout(), children: children),
        color: Colors.blueGrey[100]);
  }

  Widget _buildExampleArea(DemoFluAppState state) {
    MenuItem menuItem = state.currentMenuItem!;

    Widget widget = Container();

    if (state.widgetVisible && state.consoleVisible) {
      widget = MultiSplitView(
          axis: Axis.vertical,
          children: [
            _buildExampleContentWidget(state, menuItem),
            ConsoleWidget()
          ],
          controller: state.verticalDividerController);
    } else if (state.widgetVisible) {
      widget = _buildExampleContentWidget(state, menuItem);
    } else if (state.consoleVisible) {
      widget = ConsoleWidget();
    }

    if (menuItem.codeFile != null && state.codeVisible) {
      if (state.widgetVisible || state.consoleVisible) {
        widget = MultiSplitView(
            children: [_buildCodeWidget(context, state.code!), widget],
            controller: state.horizontalDividerController);
      } else {
        widget = _buildCodeWidget(context, state.code!);
      }
    }

    return MultiSplitViewTheme(
        child: widget,
        data: MultiSplitViewThemeData(
            dividerPainter:
            DividerPainters.background(color: Colors.blueGrey[700])));
  }

  /// Builds the example content widget.
  Widget _buildExampleContentWidget(DemoFluAppState state, MenuItem menuItem) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double maxWidth = constraints.maxWidth;
          double maxHeight = constraints.maxHeight;
          Size? maxSize = state.getMaxSize(menuItem);
          if (maxSize != null) {
            maxWidth = math.min(maxWidth, maxSize.width);
            maxHeight = math.min(maxHeight, maxSize.height);
          }
          if (state.isResizable(menuItem)) {
            maxWidth = maxWidth * state.widthWeight;
            maxHeight = maxHeight * state.heightWeight;
          }
          ConstrainedBox constrainedBox = ConstrainedBox(
              child: MultiSplitViewTheme(
                  child: menuItem.example!, data: MultiSplitViewThemeData()),
              constraints:
              BoxConstraints.tightFor(width: maxWidth, height: maxHeight));

          return Container(
              color: state.widgetBackground,
              child: Center(child: Container(child: constrainedBox)));
        });
  }

  /// Builds the widget for example code.
  Widget _buildCodeWidget(BuildContext context, String code) {
    return Container(
        color: Color(0xfff8f8f8),
        child: Stack(children: [
          SingleChildScrollView(
              controller: ScrollController(),
              child: HighlightView(
                code,
                language: 'dart',
                theme: githubTheme,
                padding: EdgeInsets.fromLTRB(16, 24, 16, 16),
                textStyle: TextStyle(fontSize: 16),
              )),
          Positioned(
              child: IconButton(
                icon: const Icon(Icons.content_copy),
                tooltip: 'Copy to clipboard',
                onPressed: () {
                  _copyToClipboard(context, code);
                },
              ),
              right: 0,
              top: 0)
        ]));
  }

  Future<void> _copyToClipboard(BuildContext context, String text) async {
    await Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Copied to clipboard'), duration: Duration(seconds: 2)));
  }

  Widget _buildColorIndicator(DemoFluAppState state) {
    return Padding(
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
            if (await _colorPickerDialog(context)) {
              state.widgetBackground = dialogColor;
            }
          },
        ),
        padding: EdgeInsets.all(8));
  }

  Future<bool> _colorPickerDialog(BuildContext context) async {
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

enum _Id { background, height, width, exampleArea }

class _Layout extends MultiChildLayoutDelegate {
  @override
  void performLayout(Size size) {
    Size? backgroundChooserSize;
    if (hasChild(_Id.background)) {
      backgroundChooserSize = layoutChild(
          _Id.background,
          BoxConstraints(
              minWidth: 0,
              maxWidth: size.width,
              minHeight: 0,
              maxHeight: size.height));
    }

    Size? heightSliderSize;
    if (hasChild(_Id.height)) {
      double maxHeight = size.height;
      if (backgroundChooserSize != null) {
        maxHeight -= backgroundChooserSize.height;
      }
      heightSliderSize = layoutChild(
          _Id.height,
          BoxConstraints(
              minWidth: 0,
              maxWidth: size.width,
              minHeight: 0,
              maxHeight: maxHeight));
    }

    double exampleX = 0;
    if (heightSliderSize != null) {
      exampleX = math.max(exampleX, heightSliderSize.width);
    }
    if (backgroundChooserSize != null) {
      exampleX = math.max(exampleX, backgroundChooserSize.width);
    }

    Size? widthSliderSize;
    if (hasChild(_Id.width)) {
      double width = size.width - exampleX;
      widthSliderSize = layoutChild(
          _Id.width,
          BoxConstraints(
              minWidth: width,
              maxWidth: width,
              minHeight: 0,
              maxHeight: size.height));
    }

    double exampleY = 0;
    if (widthSliderSize != null) {
      exampleY = math.max(exampleY, widthSliderSize.height);
    }
    if (backgroundChooserSize != null) {
      exampleY = math.max(exampleY, backgroundChooserSize.height);
    }

    if (backgroundChooserSize != null) {
      positionChild(_Id.background, Offset(0, 0));
    }
    if (widthSliderSize != null) {
      positionChild(
          _Id.width, Offset(exampleX, exampleY - widthSliderSize.height));
    }
    if (heightSliderSize != null) {
      positionChild(_Id.height, Offset(0, exampleY));
    }
    if (hasChild(_Id.exampleArea)) {
      layoutChild(
          _Id.exampleArea,
          BoxConstraints(
              minWidth: size.width - exampleX,
              maxWidth: size.width - exampleX,
              minHeight: size.height - exampleY,
              maxHeight: size.height - exampleY));
      positionChild(_Id.exampleArea, Offset(exampleX, exampleY));
    }
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) {
    return false;
  }
}
