import 'package:demoflu/src/console_widget.dart';
import 'package:demoflu/src/demoflu_settings.dart';
import 'package:demoflu/src/example.dart';
import 'package:demoflu/src/resizable_example_widget.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/github.dart';
import 'package:multi_split_view/multi_split_view.dart';

class ExampleWidget extends StatefulWidget {
  const ExampleWidget({required this.settings});

  final DemoFluSettings settings;

  @override
  State<StatefulWidget> createState() => ExampleWidgetState();
}

class ExampleWidgetState extends State<ExampleWidget> {
  Color dialogColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    List<LayoutId> children = [
      LayoutId(id: _Id.horizontalMenu, child: _buildHorizontalMenu()),
      LayoutId(id: _Id.exampleArea, child: _buildExampleArea())
    ];

    return Container(
        child: CustomMultiChildLayout(delegate: _Layout(), children: children),
        color: Colors.blueGrey[100]);
  }

  Widget _buildExampleArea() {
    List<Widget> horizontalChildren = [];

    if (widget.settings.code != null && widget.settings.codeVisible) {
      horizontalChildren.add(_buildCodeWidget(context));
    }

    if (widget.settings.widgetVisible && widget.settings.consoleVisible) {
      horizontalChildren.add(MultiSplitView(
          axis: Axis.vertical,
          children: [
            ResizableExampleWidget(settings: widget.settings),
            ConsoleWidget(settings: widget.settings)
          ],
          controller: widget.settings.verticalDividerController));
    } else if (widget.settings.widgetVisible) {
      horizontalChildren.add(ResizableExampleWidget(settings: widget.settings));
    } else if (widget.settings.consoleVisible) {
      horizontalChildren.add(ConsoleWidget(settings: widget.settings));
    }

    final Example example = widget.settings.example!;

    if (widget.settings.extraWidgetsVisible) {
      List<Widget> children = [];
      ExtraWidgetsMixin mixin = example as ExtraWidgetsMixin;
      for (String name in widget.settings.extraWidgetsNames) {
        Widget? w = mixin.buildExtraWidget(context, name);
        if (w != null) {
          children.add(Container(
              child: Text(name, style: TextStyle(color: Colors.white)),
              color: Colors.blueGrey[900],
              padding: EdgeInsets.all(8)));
          children.add(w);
        }
      }
      if (children.isNotEmpty) {
        horizontalChildren.add(Container(
            child: SingleChildScrollView(
                child: Column(
                    children: children,
                    crossAxisAlignment: CrossAxisAlignment.stretch)),
            color: Colors.white));
      }
    }

    Widget exampleArea = Container();
    if (horizontalChildren.length == 1) {
      exampleArea = horizontalChildren.first;
    } else if (horizontalChildren.length > 1) {
      exampleArea = MultiSplitView(
          children: horizontalChildren,
          controller: widget.settings.horizontalDividerController);
    }

    return MultiSplitViewTheme(
        child: exampleArea,
        data: MultiSplitViewThemeData(
            dividerPainter: DividerPainters.grooved2(
                backgroundColor: Colors.blueGrey[700],
                color: Colors.blueGrey[300]!,
                highlightedColor: Colors.blueGrey[50])));
  }

  /// Builds the widget for example code.
  Widget _buildCodeWidget(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Color(0xfff8f8f8),
            border: Border.all(color: Colors.blueGrey[700]!)),
        child: Stack(children: [
          Positioned.fill(
              child: SingleChildScrollView(
                  controller: ScrollController(),
                  child: HighlightView(
                    widget.settings.code!,
                    language: 'dart',
                    theme: githubTheme,
                    padding: EdgeInsets.fromLTRB(16, 24, 16, 16),
                    textStyle: TextStyle(fontSize: 16),
                  ))),
          Positioned(
              child: IconButton(
                icon: const Icon(Icons.content_copy),
                tooltip: 'Copy to clipboard',
                onPressed: () {
                  _copyToClipboard(context, widget.settings.code!);
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

  Widget _buildColorIndicator() {
    return Padding(
        child: ColorIndicator(
          width: 28,
          height: 28,
          borderRadius: 4,
          hasBorder: true,
          borderColor: Colors.grey[700],
          color: widget.settings.widgetBackground,
          onSelectFocus: false,
          onSelect: () async {
            dialogColor = widget.settings.widgetBackground;
            if (await _colorPickerDialog(context)) {
              widget.settings.widgetBackground = dialogColor;
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

  Widget _buildHorizontalMenu() {
    List<Widget> children = [];
    children.add(SizedBox(width: 16));
    children.add(Text('background'));
    children.add(_buildColorIndicator());

    if (widget.settings.code != null) {
      children.add(SizedBox(width: 16));
      children.add(Text('code'));
      children.add(Checkbox(
          value: widget.settings.codeVisible,
          onChanged: (value) => widget.settings.codeVisible = value!));
    }

    children.add(SizedBox(width: 16));
    if (widget.settings.extraWidgetsEnabled) {
      children.add(Text('main widget'));
    } else {
      children.add(Text('widget'));
    }
    children.add(Checkbox(
        value: widget.settings.widgetVisible,
        onChanged: (value) => widget.settings.widgetVisible = value!));

    if (widget.settings.extraWidgetsEnabled) {
      children.add(SizedBox(width: 16));
      children.add(Text('extra widgets'));
      children.add(Checkbox(
          value: widget.settings.extraWidgetsVisible,
          onChanged: (value) => widget.settings.extraWidgetsVisible = value!));
    }

    if (widget.settings.consoleEnabled) {
      children.add(SizedBox(width: 16));

      children.add(Text('console'));
      children.add(Checkbox(
          value: widget.settings.consoleVisible,
          onChanged: (value) => widget.settings.consoleVisible = value!));
    }

    return CheckboxTheme(
        child: SingleChildScrollView(
            controller: ScrollController(), child: Row(children: children)),
        data: CheckboxThemeData(splashRadius: 14));
  }
}

enum _Id { exampleArea, horizontalMenu }

class _Layout extends MultiChildLayoutDelegate {
  @override
  void performLayout(Size size) {
    double exampleY = 0;
    if (hasChild(_Id.horizontalMenu)) {
      Size horizontalMenuSize = layoutChild(
          _Id.horizontalMenu,
          BoxConstraints(
              minWidth: size.width,
              maxWidth: size.width,
              minHeight: 0,
              maxHeight: size.height));
      positionChild(_Id.horizontalMenu, Offset(0, 0));
      exampleY = horizontalMenuSize.height;
    }
    if (hasChild(_Id.exampleArea)) {
      layoutChild(
          _Id.exampleArea,
          BoxConstraints(
              minWidth: size.width,
              maxWidth: size.width,
              minHeight: size.height - exampleY,
              maxHeight: size.height - exampleY));
      positionChild(_Id.exampleArea, Offset(0, exampleY));
    }
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) {
    return true;
  }
}
