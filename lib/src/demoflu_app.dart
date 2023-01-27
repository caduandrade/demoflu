import 'package:demoflu/src/demo_menu_item.dart';
import 'package:demoflu/src/internal/demoflu_settings.dart';
import 'package:demoflu/src/internal/demoflu_logo.dart';
import 'package:demoflu/src/internal/menu_widget.dart';
import 'package:demoflu/src/internal/settings/settings_button.dart';
import 'package:demoflu/src/internal/settings/settings_widget.dart';
import 'package:demoflu/src/internal/switch_view/switch_view.dart';
import 'package:flutter/material.dart';

/// Demo app to be instantiated.
class DemoFluApp extends StatefulWidget {
  DemoFluApp(
      {required this.title,
      required this.menuItems,
      this.resizable = true,
      this.exampleBackground = Colors.white,
      this.maxSize,
      this.initialWidthWeight,
      this.initialHeightWeight}) {
    if (initialHeightWeight != null &&
        (initialHeightWeight! < 0 || initialHeightWeight! > 1)) {
      throw ArgumentError(
          'initialHeightWeight must be a value between 0 and 1: $initialHeightWeight');
    }
    if (initialWidthWeight != null &&
        (initialWidthWeight! < 0 || initialWidthWeight! > 1)) {
      throw ArgumentError(
          'initialWidthWeight must be a value between 0 and 1: $initialWidthWeight');
    }
  }

  final String title;
  final List<DemoMenuItem> menuItems;

  /// Defines the default widget background for all examples.
  final Color exampleBackground;

  final Size? maxSize;
  final bool resizable;
  final double? initialWidthWeight;
  final double? initialHeightWeight;

  @override
  State<StatefulWidget> createState() => DemoFluAppState(
      settings: DemoFluSettings(
          exampleBackground: exampleBackground,
          widthWeight: initialWidthWeight,
          heightWeight: initialHeightWeight,
          resizable: resizable,
          defaultMaxSize: maxSize));
}

/// Utilities.
class DemoFlu {
  /// Prints on demo console.
  static void printOnConsole(BuildContext context, String text) {
    DemoFluAppState? state = context.findAncestorStateOfType<DemoFluAppState>();
    state?.settings.console.update(text);
  }
}

/// The [DemoFluApp] state.
class DemoFluAppState extends State<DemoFluApp> {
  DemoFluAppState({required this.settings});

  final DemoFluSettings settings;

  @override
  void initState() {
    super.initState();
    int menuItemIndex =
        widget.menuItems.indexWhere((menuItem) => menuItem.example != null);
    if (menuItemIndex > -1) {
      settings.updateCurrentExample(widget.menuItems[menuItemIndex]);
    }
    settings.addListener(_rebuild);
  }

  @override
  void dispose() {
    settings.removeListener(_rebuild);
    super.dispose();
  }

  void _rebuild() {
    setState(() {
      //rebuilds
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: widget.title,
        theme: ThemeData(
            primarySwatch: Colors.blueGrey,
            scaffoldBackgroundColor: Colors.white),
        home: Scaffold(
            appBar: AppBar(
                title: Text(widget.title),
                backgroundColor: Colors.blueGrey[900],
                actions: [SettingsButton(settings: settings), DemoFluLogo()]),
            body: _buildBody()));
  }

  Widget _buildBody() {
    Widget center = settings.example == null
        ? Center(child: Text('Loading...'))
        : SwitchView(settings: settings);

    List<LayoutId> children = [
      LayoutId(id: 2, child: center),
      LayoutId(
          id: 1,
          child: MenuWidget(settings: settings, menuItems: widget.menuItems))
    ];

    Widget exampleArea =
        CustomMultiChildLayout(delegate: _Layout(), children: children);

    List<Widget> stackChildren = [Positioned.fill(child: exampleArea)];
    if (settings.settingsVisible) {
      stackChildren.add(SettingsWidget(settings: settings));
    }
    return Stack(children: stackChildren);
  }
}

class _Layout extends MultiChildLayoutDelegate {
  @override
  void performLayout(Size size) {
    Size appMenuSize = layoutChild(
        1,
        BoxConstraints(
            minWidth: 0,
            maxWidth: 200,
            minHeight: size.height,
            maxHeight: size.height));
    positionChild(1, Offset.zero);

    layoutChild(
        2,
        BoxConstraints.tight(
            Size(size.width - appMenuSize.width, size.height)));
    positionChild(2, Offset(appMenuSize.width, 0));
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) {
    return false;
  }
}
