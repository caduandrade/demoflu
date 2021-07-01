import 'package:demoflu/src/demoflu_app.dart';
import 'package:demoflu/src/example.dart';
import 'package:demoflu/src/example/bar/name_bar.dart';
import 'package:demoflu/src/example/bar/size_bar.dart';
import 'package:demoflu/src/menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ExampleBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DemoFluAppState state = DemoFluAppState.of(context)!;

    DFExample example = state.currentMenuItem!.example;

    List<Widget> children = [NameBar()];
    if (example.resizable || example.maxSize != null) {
      children.add(SizeBar());
    }

    if (children.length == 1) {
      return children.first;
    }

    return Column(
        children: children, crossAxisAlignment: CrossAxisAlignment.stretch);
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

      if (example.resizable) {}
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
