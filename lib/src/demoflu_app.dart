import 'package:demoflu/src/console_widget.dart';
import 'package:demoflu/src/example.dart';
import 'package:demoflu/src/example_menu_widget.dart';
import 'package:demoflu/src/example_widget.dart';
import 'package:demoflu/src/app_menu_widget.dart';
import 'package:demoflu/src/section.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:multi_split_view/multi_split_view.dart';
import 'package:url_launcher/url_launcher.dart';

const _url = 'https://pub.dev/packages/demoflu';

/// Demo app to be instantiated.
class DemoFluApp extends StatefulWidget {
  /// Builds a [DemoFluApp].
  ///
  /// The [widgetBackground] defines the default widget background for all
  /// examples.
  const DemoFluApp._(
      {required this.title,
      required this.sections,
      required this.resizable,
      required this.widgetBackground,
      this.maxSize,
      required this.consoleEnabled,
      this.initialWidthWeight,
      this.initialHeightWeight});

  factory DemoFluApp(
      {required String title,
      required List<Section> sections,
      Color widgetBackground = Colors.white,
      Size? maxSize,
      bool resizable = false,
      bool consoleEnabled = false,
      double? initialWidthWeight,
      double? initialHeightWeight}) {
    int index = 1;
    sections.forEach((section) {
      section.examples.forEach((example) {
        example.index = index++;
      });
    });
    return DemoFluApp._(
        title: title,
        sections: sections,
        consoleEnabled: consoleEnabled,
        widgetBackground: widgetBackground,
        resizable: resizable,
        maxSize: maxSize,
        initialWidthWeight: initialWidthWeight,
        initialHeightWeight: initialHeightWeight);
  }

  final String title;
  final List<Section> sections;
  final Color widgetBackground;
  final Size? maxSize;
  final bool resizable;
  final bool consoleEnabled;
  final double? initialWidthWeight;
  final double? initialHeightWeight;

  @override
  State<StatefulWidget> createState() => DemoFluAppState();
}

/// Utilities.
class DemoFlu {
  /// Prints on demo console.
  static void printOnConsole(BuildContext context, String text) {
    DemoFluAppState? state = DemoFluAppState.of(context);
    state?.consoleNotifier.update(text);
  }

  static void notifyMenuButtonClick(BuildContext context, int buttonIndex) {
    DemoFluAppState? state = DemoFluAppState.of(context);
    state?._buttonClickNotifier.notifyClick(buttonIndex);
  }
}

/// The [DemoFluApp] state.
class DemoFluAppState extends State<DemoFluApp> {
  final ButtonClickNotifier _buttonClickNotifier = ButtonClickNotifier();

  final MultiSplitViewController verticalDividerController =
      MultiSplitViewController(weights: [.9, .1]);
  final MultiSplitViewController horizontalDividerController =
      MultiSplitViewController(weights: [.5, .5]);

  late Color _widgetBackground;

  Color get widgetBackground => _widgetBackground;

  void set widgetBackground(Color color) {
    setState(() {
      _widgetBackground = color;
    });
  }

  Size? getMaxSize(Example example) {
    return example.maxSize ?? widget.maxSize;
  }

  /// Indicates whether console view is enabled.
  bool isConsoleEnabled(Example example) {
    return example.consoleEnabled ?? widget.consoleEnabled;
  }

  /// Indicates whether example is resizable.
  bool isResizable(Example example) {
    return example.resizable ?? widget.resizable;
  }

  ConsoleNotifier _consoleNotifier = ConsoleNotifier();

  ConsoleNotifier get consoleNotifier => _consoleNotifier;

  Example? _currentExample;

  /// Gets the current selected example.
  Example? get currentExample => _currentExample;

  String? _code;

  String? get code => _code;

  bool _codeVisible = false;

  /// Indicates whether code view is visible.
  bool get codeVisible => _codeVisible;

  set codeVisible(bool visible) {
    setState(() {
      _codeVisible = visible;
    });
  }

  bool _widgetVisible = true;

  /// Indicates whether widget view is visible.
  bool get widgetVisible => _widgetVisible;

  set widgetVisible(bool visible) {
    setState(() {
      _widgetVisible = visible;
      if (!visible) {
        _consoleVisible = false;
      }
    });
  }

  bool _consoleVisible = false;

  /// Indicates whether console view is visible.
  bool get consoleVisible => _consoleVisible;

  set consoleVisible(bool visible) {
    setState(() {
      _consoleVisible = visible;
    });
  }

  double _widthWeight = 1;

  double get widthWeight => _widthWeight;

  set widthWeight(double value) {
    setState(() {
      _widthWeight = value;
    });
  }

  double _heightWeight = 1;

  double get heightWeight => _heightWeight;

  set heightWeight(double value) {
    setState(() {
      _heightWeight = value;
    });
  }

  @override
  void initState() {
    super.initState();
    _widgetBackground = widget.widgetBackground;

    if (widget.initialHeightWeight != null) {
      _heightWeight = widget.initialHeightWeight!;
      if (_heightWeight < 0 || _heightWeight > 1) {
        throw ArgumentError(
            'initialHeightWeight must be a value between 0 and 1');
      }
    }
    if (widget.initialWidthWeight != null) {
      _widthWeight = widget.initialWidthWeight!;
      if (_widthWeight < 0 || _widthWeight > 1) {
        throw ArgumentError(
            'initialWidthWeight must be a value between 0 and 1');
      }
    }
    if (widget.sections.isNotEmpty) {
      Section section = widget.sections.first;
      if (section.examples.isNotEmpty) {
        updateCurrentExample(section.examples.first);
      }
    }
  }

  /// Updates the current example.
  void updateCurrentExample(Example example) async {
    setState(() {
      _buttonClickNotifier.unregister();
      _currentExample = null;
      _code = null;
    });
    String? newCode;
    if (example.codeFile != null) {
      newCode = await rootBundle.loadString(example.codeFile!);
    }
    setState(() {
      if (!isConsoleEnabled(example)) {
        _consoleVisible = false;
      }
      _code = newCode;
      _consoleNotifier = ConsoleNotifier();
      _currentExample = example;
    });
  }

  List<Section> get sections => widget.sections;

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
                actions: [_DemoFluLogo()]),
            body: _DemoFluAppInheritedWidget(state: this, child: _Body())));
  }

  static DemoFluAppState? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_DemoFluAppInheritedWidget>()
        ?.state;
  }
}

class _DemoFluAppInheritedWidget extends InheritedWidget {
  _DemoFluAppInheritedWidget({required this.state, required Widget child})
      : super(child: child);

  final DemoFluAppState state;

  @override
  bool updateShouldNotify(covariant _DemoFluAppInheritedWidget oldWidget) =>
      true;
}

/// The DemoFlu logo widget.
class _DemoFluLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Column column = Column(children: [
      Text('built with', style: TextStyle(fontSize: 12)),
      Text('DemoFlu', style: TextStyle(fontSize: 14))
    ], mainAxisAlignment: MainAxisAlignment.center);
    FittedBox fittedBox = FittedBox(child: column, fit: BoxFit.scaleDown);
    EdgeInsets padding = EdgeInsets.fromLTRB(16, 8, 16, 8);
    Container container = Container(child: fittedBox, padding: padding);
    return InkWell(
        child: LimitedBox(child: container, maxHeight: kToolbarHeight),
        onTap: () => _launchURL());
  }

  void _launchURL() async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';
}

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DemoFluAppState state = DemoFluAppState.of(context)!;
    Widget? exampleContent;
    List<Widget> children = [LayoutId(id: 1, child: AppMenuWidget())];
    if (state.currentExample != null) {
      children.add(LayoutId(id: 3, child: ExampleMenu()));
      exampleContent =
          ExampleWidget(buttonClickNotifier: state._buttonClickNotifier);
    } else {
      exampleContent = Center(child: Text('Loading...'));
    }
    children.add(LayoutId(id: 2, child: exampleContent));
    return CustomMultiChildLayout(delegate: _BodyLayout(), children: children);
  }
}

class _BodyLayout extends MultiChildLayoutDelegate {
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

    Size exampleMenuSize = Size.zero;
    if (hasChild(3)) {
      exampleMenuSize = layoutChild(
          3,
          BoxConstraints(
              minWidth: 0,
              maxWidth: size.width - appMenuSize.width,
              minHeight: size.height,
              maxHeight: size.height));
      positionChild(3, Offset(appMenuSize.width, 0));
    }

    layoutChild(
        2,
        BoxConstraints.tight(Size(
            size.width - appMenuSize.width - exampleMenuSize.width,
            size.height)));
    positionChild(2, Offset(appMenuSize.width + exampleMenuSize.width, 0));
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) {
    return false;
  }
}
