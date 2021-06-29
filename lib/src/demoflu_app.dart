import 'package:demoflu/demoflu.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:multi_split_view/multi_split_view.dart';

class DemoFluApp extends StatefulWidget {
  const DemoFluApp({required this.title, required this.menuSections});

  final String title;
  final List<DemoFluMenuSection> menuSections;

  @override
  State<StatefulWidget> createState() => _DemoFluAppState();
}

class _DemoFluAppState extends State<DemoFluApp> {
  DemoFluMenuItem? _currentMenuItem;

  @override
  void initState() {
    super.initState();
    if (widget.menuSections.isNotEmpty) {
      DemoFluMenuSection section = widget.menuSections.first;
      if (section.menuItems.isNotEmpty) {
        _currentMenuItem = section.menuItems.first;
      }
    }
  }

  void updateFor(DemoFluMenuItem menuItem) async {
    String? code;
    if (menuItem.codeFile != null) {
      code = await rootBundle.loadString(menuItem.codeFile!);
      print(code);
    }
    setState(() {
      _currentMenuItem = menuItem;
    });
  }

  List<DemoFluMenuSection> get menuSections => widget.menuSections;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: widget.title,
        theme: ThemeData(
            primarySwatch: Colors.blueGrey,
            scaffoldBackgroundColor: Colors.white),
        home: Scaffold(
            appBar:
                AppBar(title: Text(widget.title), actions: [_DemoFluLogo()]),
            body: _DemoFluAppInheritedWidget(state: this, child: _Body())));
  }

  static _DemoFluAppState? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_DemoFluAppInheritedWidget>()
        ?.state;
  }
}

class _DemoFluAppInheritedWidget extends InheritedWidget {
  _DemoFluAppInheritedWidget({required this.state, required Widget child})
      : super(child: child);

  final _DemoFluAppState state;

  @override
  bool updateShouldNotify(covariant _DemoFluAppInheritedWidget oldWidget) =>
      true;
}

class _DemoFluLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Column column = Column(children: [
      Text('Built with', style: TextStyle(color: Colors.black, fontSize: 12)),
      Text('DemoFlu', style: TextStyle(color: Colors.black, fontSize: 14))
    ], mainAxisAlignment: MainAxisAlignment.center);
    FittedBox fittedBox = FittedBox(child: column, fit: BoxFit.scaleDown);
    EdgeInsets padding = EdgeInsets.fromLTRB(16, 8, 16, 8);
    Container container = Container(
        child: fittedBox,
        padding: padding,
        color: Colors.white.withOpacity(.7));
    return InkWell(
        child: LimitedBox(child: container, maxHeight: kToolbarHeight),
        onTap: () => print('Tap'));
  }
}

class _MenuWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _DemoFluAppState state = _DemoFluAppState.of(context)!;
    ThemeData theme = Theme.of(context);
    List<Widget> children = [];
    for (DemoFluMenuSection menuSection in state.menuSections) {
      children.add(_MenuSectionWidget(menuSection));
    }
    return SingleChildScrollView(
        child: Container(
            child: Column(children: children), color: theme.accentColor));
  }
}

class _MenuSectionWidget extends StatelessWidget {
  _MenuSectionWidget(this.menuSection);

  final DemoFluMenuSection menuSection;

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    for (DemoFluMenuItem menuItem in menuSection.menuItems) {
      children.add(_MenuItemWidget(menuItem));
    }
    return Column(children: children);
  }
}

class _MenuItemWidget extends StatelessWidget {
  _MenuItemWidget(this.menuItem);

  final DemoFluMenuItem menuItem;

  @override
  Widget build(BuildContext context) {
    _DemoFluAppState state = _DemoFluAppState.of(context)!;
    return InkWell(
        child: Text(menuItem.text), onTap: () => state.updateFor(menuItem));
  }
}

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _DemoFluAppState state = _DemoFluAppState.of(context)!;
    ThemeData theme = Theme.of(context);
    Widget content = Container();
    if (state._currentMenuItem != null) {
      DemoFluMenuItem menuItem = state._currentMenuItem!;
      content = menuItem.builder(context);

      if (menuItem.resizableContent) {
        var dividerPainter =
            (Axis axis, bool resizable, Canvas canvas, Size size) {
          var paint = Paint()
            ..style = PaintingStyle.stroke
            ..color = Colors.black
            ..isAntiAlias = true;
          if (axis == Axis.vertical) {
            double dashHeight = 9, dashSpace = 5, startY = 0;
            while (startY < size.height) {
              canvas.drawLine(Offset(size.width / 2, startY),
                  Offset(size.width / 2, startY + dashHeight), paint);
              startY += dashHeight + dashSpace;
            }
          } else {
            double dashWidth = 9, dashSpace = 5, startX = 0;
            while (startX < size.width) {
              canvas.drawLine(Offset(startX, size.height / 2),
                  Offset(startX + dashWidth, size.height / 2), paint);
              startX += dashWidth + dashSpace;
            }
          }
        };
        content = MultiSplitView(
            axis: Axis.vertical,
            children: [
              SizedBox(height: 30),
              MultiSplitView(
                  children: [SizedBox(width: 30), content, SizedBox(width: 30)],
                  dividerThickness: 10,
                  dividerPainter: dividerPainter),
              SizedBox(height: 30)
            ],
            dividerThickness: 10,
            dividerPainter: dividerPainter);
      }
      content = Container(child: content, color: theme.scaffoldBackgroundColor);
      if (menuItem.limitedSize != null) {
        //TODO min layout builder size
        content = Container(
            color: Colors.grey[200],
            child: Center(
                child: Container(
              child: content,
              width: menuItem.limitedSize!.width,
              height: menuItem.limitedSize!.height,
            )));
      }
    }
    return Row(
        children: [_MenuWidget(), Expanded(child: content)],
        crossAxisAlignment: CrossAxisAlignment.stretch);
  }
}
