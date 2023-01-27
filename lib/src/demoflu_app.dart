import 'package:demoflu/demoflu.dart';
import 'package:demoflu/src/internal/console_controller.dart';
import 'package:demoflu/src/internal/demoflu_logo.dart';
import 'package:demoflu/src/internal/demoflu_settings.dart';
import 'package:demoflu/src/internal/menu_widget.dart';
import 'package:demoflu/src/internal/settings_widget.dart';
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
      this.widthWeight = 1,
      this.heightWeight = 1}) {
    if (heightWeight < 0 || heightWeight > 1) {
      throw ArgumentError(
          'heightWeight must be a value between 0 and 1: $heightWeight');
    }
    if (widthWeight < 0 || widthWeight > 1) {
      throw ArgumentError(
          'widthWeight must be a value between 0 and 1: $widthWeight');
    }
  }

  final String title;
  final List<DemoMenuItem> menuItems;

  /// Defines the default widget background for all examples.
  final Color exampleBackground;

  final Size? maxSize;
  final bool resizable;
  final double widthWeight;
  final double heightWeight;

  @override
  State<StatefulWidget> createState() => DemoFluAppState();
}

/// The [DemoFluApp] state.
class DemoFluAppState extends State<DemoFluApp> {
  late final DemoFluSettings settings;
  final ConsoleController _console = ConsoleController();
  DemoMenuItem? _selectedMenuItem;
  AbstractExample? _example;
  bool _settingsVisible = false;

  @override
  void initState() {
    super.initState();
    settings = DemoFluSettings(
        exampleBackground: widget.exampleBackground,
        widthWeight: widget.widthWeight,
        heightWeight: widget.heightWeight,
        resizable: widget.resizable,
        maxSize: widget.maxSize);
    int menuItemIndex =
        widget.menuItems.indexWhere((menuItem) => menuItem.example != null);
    if (menuItemIndex > -1) {
      _selectedMenuItem = widget.menuItems[menuItemIndex];
      _example = _selectedMenuItem?.example;
    }
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
                actions: [
                  IconButton(
                      onPressed: () =>
                          setState(() => _settingsVisible = !_settingsVisible),
                      icon: Icon(Icons.settings),
                      tooltip: 'Settings'),
                  DemoFluLogo()
                ]),
            body: _buildBody()));
  }

  Widget _buildBody() {
    Widget center = _example == null
        ? Center(child: Text('No example available'))
        : AnimatedBuilder(
            animation: settings,
            builder: (context, child) => SwitchView(
                settings: settings, example: _example!, console: _console));

    List<LayoutId> children = [
      LayoutId(id: 2, child: center),
      LayoutId(
          id: 1,
          child: MenuWidget(
              onMenuItemTap: _onMenuSelect,
              selectedMenuItem: _selectedMenuItem,
              menuItems: widget.menuItems))
    ];

    Widget exampleArea =
        CustomMultiChildLayout(delegate: _Layout(), children: children);

    List<Widget> stackChildren = [Positioned.fill(child: exampleArea)];
    if (_settingsVisible) {
      stackChildren.add(SettingsWidget(
          settings: settings,
          onClose: () => setState(() => _settingsVisible = false)));
    }
    return Stack(children: stackChildren);
  }

  void _onMenuSelect(DemoMenuItem menuItem) {
    _console.clear();
    setState(() {
      _selectedMenuItem = menuItem;
      _example = menuItem.example;
    });
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

/// Utilities.
class DemoFlu {
  /// Prints on demo console.
  static void printOnConsole(BuildContext context, String text) {
    DemoFluAppState? state = context.findAncestorStateOfType<DemoFluAppState>();
    state?._console.update(text);
  }
}
