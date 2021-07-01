import 'package:demoflu/src/demoflu_app.dart';
import 'package:demoflu/src/example.dart';
import 'package:demoflu/src/menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:multi_split_view/multi_split_view.dart';

class ExampleBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DemoFluAppState state = DemoFluAppState.of(context)!;

    String? sectionName = state.currentMenuItem!.sectionName;
    DFExample example = state.currentMenuItem!.example;

    String name = example.name;
    if (sectionName != null) {
      name = '$sectionName > $name';
    }

    return Container(
        child: Text(name),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.blueGrey[100],
            border: Border(
                bottom: BorderSide(width: 1, color: Colors.blueGrey[500]!))));
  }
}

class ExampleBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DemoFluAppState state = DemoFluAppState.of(context)!;
    ThemeData theme = Theme.of(context);
    Widget content = Container();
    List<Widget> children = [LayoutId(id: 1, child: MenuWidget())];
    if (state.currentMenuItem != null) {
      children.add(LayoutId(id: 3, child: ExampleBar()));

      DFExample example = state.currentMenuItem!.example;
      content = example.builder(context);

      if (example.resizable) {
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
      if (example.maxSize != null) {
        //TODO min layout builder size
        content = Container(
            color: Colors.grey[200],
            child: Center(
                child: Container(
              child: content,
              width: example.maxSize!.width,
              height: example.maxSize!.height,
            )));
      }
    }
    children.add(LayoutId(id: 2, child: content));

    return CustomMultiChildLayout(delegate: BodyLayout(), children: children);
  }
}

class BodyLayout extends MultiChildLayoutDelegate {
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
