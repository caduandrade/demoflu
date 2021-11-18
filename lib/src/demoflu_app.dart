import 'package:demoflu/src/demoflu_logo.dart';
import 'package:demoflu/src/demoflu_settings.dart';
import 'package:demoflu/src/menu_item.dart';
import 'package:demoflu/src/menu_widget.dart';
import 'package:demoflu/src/example_widget.dart';
import 'package:flutter/material.dart';

typedef AppMenuBuilder = List<MenuItem> Function();

/// Demo app to be instantiated.
class DemoFluApp extends StatefulWidget {
  /// Builds a [DemoFluApp].
  ///
  /// The [widgetBackground] defines the default widget background for all
  /// examples.
  DemoFluApp(
      {required this.title,
      required this.appMenuBuilder,
      this.resizable = false,
      this.widgetBackground = Colors.white,
      this.maxSize,
      this.consoleEnabled = false,
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
  final AppMenuBuilder appMenuBuilder;
  final Color widgetBackground;
  final Size? maxSize;
  final bool resizable;
  final bool consoleEnabled;
  final double? initialWidthWeight;
  final double? initialHeightWeight;

  @override
  State<StatefulWidget> createState() => DemoFluAppState(
      settings: DemoFluSettings(
          widgetBackground: widgetBackground,
          widthWeight: initialWidthWeight,
          heightWeight: initialHeightWeight,
          defaultConsoleEnabled: consoleEnabled,
          defaultResizable: resizable,
          defaultMaxSize: maxSize),
  menuItems: appMenuBuilder());
}

/// Utilities.
class DemoFlu {
  /// Prints on demo console.
  static void printOnConsole(BuildContext context, String text) {
    DemoFluAppState? state = context.findAncestorStateOfType<DemoFluAppState>();
    state?.settings.consoleNotifier.update(text);
  }
}

/// The [DemoFluApp] state.
class DemoFluAppState extends State<DemoFluApp> {
  DemoFluAppState({required this.settings, required this.menuItems });

  final DemoFluSettings settings;
  final List<MenuItem> menuItems;

  @override
  void initState() {
    super.initState();
    settings.addListener(_rebuild);

    int menuItemIndex =
        menuItems.indexWhere((menuItem) => menuItem.builder != null);
    if (menuItemIndex > -1) {
      settings.updateCurrentExample(menuItems[menuItemIndex]);
    }
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
                actions: [DemoFluLogo()]),
            body: _buildBody()));
  }

  Widget _buildBody() {
    Widget? exampleContent;
    if (settings.widget != null) {
      exampleContent = ExampleWidget(settings: settings);
    } else {
      exampleContent = Center(child: Text('Loading...'));
    }

    List<LayoutId> children = [
      LayoutId(
          id: 1, child: MenuWidget(settings: settings, menuItems: menuItems)),
      LayoutId(id: 2, child: exampleContent)
    ];

    return CustomMultiChildLayout(delegate: _Layout(), children: children);
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
