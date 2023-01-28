import 'package:demoflu/src/example.dart';
import 'package:demoflu/src/internal/code_widget.dart';
import 'package:demoflu/src/internal/console_controller.dart';
import 'package:demoflu/src/internal/demoflu_settings.dart';
import 'package:demoflu/src/internal/example_container.dart';
import 'package:demoflu/src/internal/ratio.dart';
import 'package:demoflu/src/internal/switch_view/ratio_toggle_buttons.dart';
import 'package:demoflu/src/internal/switch_view/switch_view_toggle_buttons.dart';
import 'package:demoflu/src/internal/view.dart';
import 'package:flutter/material.dart';

class SwitchView extends StatelessWidget {
  const SwitchView(
      {Key? key,
      required this.settings,
      required this.example,
      required this.console})
      : super(key: key);

  static final GlobalKey exampleGlobalKey = GlobalKey(debugLabel: 'example');
  static final GlobalKey codeGlobalKey = GlobalKey(debugLabel: 'code');

  final DemoFluSettings settings;
  final AbstractExample example;
  final ConsoleController console;

  @override
  Widget build(BuildContext context) {
    List<Widget> barExtraWidgets = example.buildBarWidgets(context);

    final bool resizable = example.resizable ?? settings.resizable;

    if (resizable) {
      barExtraWidgets.insert(
          0,
          _CheckWidget(
              value: settings.resizeEnabled,
              title: 'resizable',
              onChanged: (value) =>
                  settings.resizeEnabled = !settings.resizeEnabled));
    }

    Widget exampleWidget = ExampleContainer(
        key: exampleGlobalKey,
        settings: settings,
        console: console,
        resizable: resizable ? settings.resizeEnabled : false,
        example: example);
    CodeWidget? codeWidget = example.codeFile != null
        ? CodeWidget(key: codeGlobalKey, codeFile: example.codeFile!)
        : null;

    if (codeWidget == null && barExtraWidgets.isEmpty) {
      // example widget only
      return exampleWidget;
    }

    List<Widget> barWidgetChildren = [];
    Widget? bodyWidget;
    if (codeWidget != null) {
      barWidgetChildren.add(SwitchViewToggleButtons(settings: settings));
      if (settings.view == DemofluView.both) {
        barWidgetChildren.add(RatioToggleButtons(settings: settings));
        int codeFlex = 1;
        int exampleFlex = 1;
        if (settings.ratio == DemofluRatio.ratio1_2) {
          exampleFlex = 2;
        } else if (settings.ratio == DemofluRatio.ratio_2_1) {
          codeFlex = 2;
        }
        bodyWidget = Row(children: [
          Expanded(child: codeWidget, flex: codeFlex),
          Container(width: 2, color: Colors.blueGrey[800]),
          Expanded(child: exampleWidget, flex: exampleFlex)
        ], crossAxisAlignment: CrossAxisAlignment.stretch);
      } else {
        List<Widget> stackChildren = [];
        if (settings.view == DemofluView.example) {
          stackChildren.add(codeWidget);
          stackChildren.add(exampleWidget);
        } else if (settings.view == DemofluView.code) {
          stackChildren.add(exampleWidget);
          stackChildren.add(codeWidget);
        }
        bodyWidget = Stack(children: stackChildren, fit: StackFit.expand);
      }
    } else {
      bodyWidget = exampleWidget;
    }

    barWidgetChildren.addAll(barExtraWidgets);

    return Column(children: [
      _BarWidget(children: barWidgetChildren),
      Expanded(child: bodyWidget)
    ], crossAxisAlignment: CrossAxisAlignment.stretch);
  }
}

class _BarWidget extends StatelessWidget {
  const _BarWidget({Key? key, required this.children}) : super(key: key);

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Wrap(
            children: children,
            spacing: 16,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 3,
                offset: Offset(0, 0), // changes position of shadow
              ),
            ],
            color: Colors.blueGrey[50],
            border: Border(bottom: BorderSide(color: Colors.blueGrey[700]!))));
  }
}

class _CheckWidget extends StatelessWidget {
  const _CheckWidget(
      {Key? key,
      required this.title,
      required this.value,
      required this.onChanged})
      : super(key: key);

  final String title;
  final bool value;
  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
        children: [Text(title), Checkbox(value: value, onChanged: onChanged)],
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center);
  }
}
