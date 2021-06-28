import 'package:demoflu/demoflu.dart';
import 'package:flutter/material.dart';
import 'package:multi_split_view/multi_split_view.dart';

class DemoFluApp extends StatefulWidget {
  const DemoFluApp({required this.title, required this.menu});

  final String title;
  final DemoFluMenu menu;

  @override
  State<StatefulWidget> createState() => DemoFluAppState();
}

class DemoFluAppState extends State<DemoFluApp> {
  WidgetBuilder? _widgetBuilder;
  bool _resizableContent = false;

  @override
  void initState() {
    super.initState();
    if (widget.menu.sections.isNotEmpty) {
      DemoFluMenuSection section = widget.menu.sections.first;
      if (section.menuItems.isNotEmpty) {
        DemoFluMenuItem menuItem = section.menuItems.first;
        _widgetBuilder = menuItem.builder;
        _resizableContent = menuItem.resizableContent;
      }
    }
  }

  void updateFor(DemoFluMenuItem menuItem) {
    setState(() {
      _widgetBuilder = menuItem.builder;
      _resizableContent = menuItem.resizableContent;
    });
  }

  DemoFluMenu get menu => widget.menu;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: widget.title,
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: Scaffold(
            appBar:
                AppBar(title: Text(widget.title), actions: [_DemoFluLogo()]),
            body: _DemoFluAppInheritedWidget(
                state: this, child: _DemoFluBody())));
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

class _DemoFluBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DemoFluAppState state = DemoFluAppState.of(context)!;
    Widget content = Container();
    if (state._widgetBuilder != null) {
      content = state._widgetBuilder!(context);
    }

    if (state._resizableContent) {
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

    return Row(
        children: [state.menu, Expanded(child: content)],
        crossAxisAlignment: CrossAxisAlignment.stretch);
  }
}
