import 'package:demoflu/src/example.dart';
import 'package:demoflu/src/example_bar_widget.dart';
import 'package:demoflu/src/example_widget.dart';
import 'package:demoflu/src/menu_widget.dart';
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
      this.widgetBackground,
      required this.consoleEnabled});

  factory DemoFluApp(
      {required String title,
      required List<DFSection> sections,
      Color? widgetBackground,
      bool consoleEnabled = false}) {
    int index = 1;
    sections.forEach((section) {
      section.examples.forEach((example) {
        example.index = index++;
        print(example.index);
      });
    });
    return DemoFluApp._(
        title: title,
        sections: sections,
        consoleEnabled: consoleEnabled,
        widgetBackground: widgetBackground);
  }

  final String title;
  final List<DFSection> sections;
  final Color? widgetBackground;
  final bool consoleEnabled;

  @override
  State<StatefulWidget> createState() => DemoFluAppState();
}

/// Abstract demo [StatelessWidget] to code reuse.
abstract class DemoStatelessWidget extends StatelessWidget {
  demoConsole(BuildContext context, String text) {
    DemoFluAppState? state = DemoFluAppState.of(context);
    state?.console = text;
  }
}

/// Abstract demo [State] to code reuse.
abstract class DemoState<T extends StatefulWidget> extends State<T> {
  demoConsole(String text) {
    DemoFluAppState? state = DemoFluAppState.of(context);
    state?.console = text;
  }
}

/// The [DemoFluApp] state.
class DemoFluAppState extends State<DemoFluApp> {
  final MultiSplitViewController verticalDividerController =
      MultiSplitViewController(weights: [.9, .1]);
  final MultiSplitViewController horizontalDividerController =
      MultiSplitViewController(weights: [.5, .5]);

  Color? get widgetBackground => widget.widgetBackground;

  /// Indicates whether console view is enabled.
  bool isConsoleEnabled(DFExample example) {
    return example.consoleEnabled ?? widget.consoleEnabled;
  }

  String? _consoleText;
  String? _consoleTime;

  /// Gets the console text.
  String get console {
    if (_consoleText != null && _consoleTime != null) {
      return '[$_consoleTime]  $_consoleText';
    }
    return '';
  }

  /// Sets the console text.
  set console(String text) {
    setState(() {
      _consoleText = text;
      _consoleTime = DateTime.now().toIso8601String();
    });
  }

  DFExample? _currentExample;

  DFExample? get currentExample => _currentExample;

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
    if (widget.sections.isNotEmpty) {
      DFSection section = widget.sections.first;
      if (section.examples.isNotEmpty) {
        updateCurrentExample(section.examples.first);
      }
    }
  }

  /// Updates the current example.
  void updateCurrentExample(DFExample example) async {
    setState(() {
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
      _consoleText = null;
      _consoleTime = null;
      _widthWeight = 1;
      _heightWeight = 1;
      _currentExample = example;
    });
  }

  List<DFSection> get sections => widget.sections;

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
    List<Widget> children = [LayoutId(id: 1, child: MenuWidget())];
    if (state.currentExample != null) {
      children.add(LayoutId(id: 3, child: ExampleBar()));
      exampleContent = ExampleWidget();
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
    Size menuSize = layoutChild(
        1,
        BoxConstraints(
            maxWidth: 200,
            minWidth: 100,
            maxHeight: size.height,
            minHeight: size.height));
    positionChild(1, Offset.zero);

    Size exampleBarSize = Size.zero;
    if (hasChild(3)) {
      exampleBarSize = layoutChild(
          3, BoxConstraints.tightFor(width: size.width - menuSize.width));
      positionChild(3, Offset(menuSize.width, 0));
    }

    layoutChild(
        2,
        BoxConstraints.tightFor(
            width: size.width - menuSize.width,
            height: size.height - exampleBarSize.height));
    positionChild(2, Offset(menuSize.width, exampleBarSize.height));
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) {
    return false;
  }
}
