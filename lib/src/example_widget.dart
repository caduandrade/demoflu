import 'package:demoflu/src/console_widget.dart';
import 'package:demoflu/src/demoflu_app.dart';
import 'package:demoflu/src/menu_item.dart';
import 'package:demoflu/src/resizable_example_widget.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/github.dart';
import 'package:multi_split_view/multi_split_view.dart';

class ExampleWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ExampleWidgetState();
}

class ExampleWidgetState extends State<ExampleWidget> {
  Color dialogColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    DemoFluAppState state = DemoFluAppState.of(context)!;

    List<LayoutId> children = [];
    if (state.currentMenuItem != null) {
      children
          .add(LayoutId(id: _Id.exampleArea, child: _buildExampleArea(state)));
      children.add(LayoutId(
          id: _Id.horizontalMenu, child: _buildHorizontalMenu(state)));
    } else {
      children.add(LayoutId(
          id: _Id.exampleArea, child: Center(child: Text('Loading...'))));
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
            ResizableExampleWidget(menuItem: menuItem),
            ConsoleWidget()
          ],
          controller: state.verticalDividerController);
    } else if (state.widgetVisible) {
      widget = ResizableExampleWidget(menuItem: menuItem);
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

  Widget _buildHorizontalMenu(DemoFluAppState state) {
    MenuItem menuItem = state.currentMenuItem!;
    List<Widget> children = [];
    children.add(_buildColorIndicator(state));
    if (menuItem.codeFile != null) {
      children.add(SizedBox(width: 16));

      children.add(Text('code'));
      children.add(Checkbox(
          value: state.codeVisible,
          onChanged: (value) => state.codeVisible = value!));

      children.add(SizedBox(width: 16));

      children.add(Text('widget'));
      children.add(Checkbox(
          value: state.widgetVisible,
          onChanged: (value) => state.widgetVisible = value!));
    }

    if (state.isConsoleEnabled(menuItem)) {
      children.add(SizedBox(width: 16));

      children.add(Text('console'));
      children.add(Checkbox(
          value: state.consoleVisible,
          onChanged: (value) => state.consoleVisible = value!));
    }

    return CheckboxTheme(
        child: SingleChildScrollView(
            controller: ScrollController(), child: Row(children: children)),
        data: CheckboxThemeData(splashRadius: 14));
  }
}

enum _Id {
  exampleArea,
  horizontalMenu
}

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
      exampleY=horizontalMenuSize.height;
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
    return false;
  }
}
