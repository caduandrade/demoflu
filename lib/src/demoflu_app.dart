import 'package:demoflu/demoflu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:multi_split_view/multi_split_view.dart';
import 'package:url_launcher/url_launcher.dart';

const _url = 'https://flutter.dev';

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
            appBar: AppBar(
                title: Text(widget.title),
                backgroundColor: Colors.blueGrey[900],
                actions: [_DemoFluLogo()]),
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

class _MenuWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _DemoFluAppState state = _DemoFluAppState.of(context)!;
    List<Widget> children = [];
    for (DemoFluMenuSection menuSection in state.menuSections) {
      children.add(_MenuSectionWidget(menuSection));
    }
    return Container(
        child: SingleChildScrollView(
            padding: EdgeInsets.all(8), child: Column(children: children)),
        decoration: BoxDecoration(
            color: Colors.blueGrey[800],
            border: Border(
                right: BorderSide(width: 1, color: Colors.blueGrey[900]!))));
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
        child: Text(menuItem.text, style: TextStyle(color: Colors.white)),
        onTap: () => state.updateFor(menuItem));
  }
}

class _ExampleBar extends StatelessWidget {
  const _ExampleBar(this.menuItem);

  final DemoFluMenuItem menuItem;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Text(menuItem.text),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.blueGrey[100],
            border: Border(
                bottom: BorderSide(width: 1, color: Colors.blueGrey[500]!))));
  }
}

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _DemoFluAppState state = _DemoFluAppState.of(context)!;
    ThemeData theme = Theme.of(context);
    Widget content = Container();
    List<Widget> children = [LayoutId(id: 1, child: _MenuWidget())];
    if (state._currentMenuItem != null) {
      children
          .add(LayoutId(id: 3, child: _ExampleBar(state._currentMenuItem!)));

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
    children.add(LayoutId(id: 2, child: content));

    return CustomMultiChildLayout(delegate: _BodyLayout(), children: children);
  }
}

class _BodyLayout extends MultiChildLayoutDelegate {
  @override
  void performLayout(Size size) {
    Size menuSize = layoutChild(
        1,
        BoxConstraints(
            maxWidth: 250,
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
