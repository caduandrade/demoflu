import 'package:demoflu/src/demoflu_app.dart';
import 'package:demoflu/src/menu_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AppMenuWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DemoFluAppState state = DemoFluAppState.of(context)!;
    List<Widget> children = [];
    for (MenuItem menuItem in state.menuItems) {
      children.add(_MenuItem(state.currentMenuItem == menuItem, menuItem));
    }
    return Container(
        child: SingleChildScrollView(
            child: IntrinsicWidth(
                child: Column(
                    children: children,
                    crossAxisAlignment: CrossAxisAlignment.stretch))),
        decoration: BoxDecoration(color: Colors.blueGrey[900]));
  }
}

class _MenuItem extends StatefulWidget {
  const _MenuItem(this.selected, this.menuItem);

  final bool selected;
  final MenuItem menuItem;

  @override
  State<StatefulWidget> createState() => _MenuItemState();
}

class _MenuItemState extends State<_MenuItem> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    double left = 8;
    if (widget.menuItem.indentation > 1) {
      left = left * widget.menuItem.indentation;
    }
    Widget text = Padding(
        child: Text(widget.menuItem.name,
            style: TextStyle(color: _textColor(), fontStyle: _fontStyle())),
        padding: EdgeInsets.fromLTRB(left, 8, 8, 8));

    if (widget.menuItem.example == null) {
      return text;
    }

    return MouseRegion(
        onEnter: _onEnter,
        onExit: _onExit,
        child: Container(
            color: _background(), child: InkWell(child: text, onTap: _onTap)));
  }

  FontStyle _fontStyle() {
    if (widget.menuItem.italic) {
      return FontStyle.italic;
    }
    return FontStyle.normal;
  }

  Color _textColor() {
    if (widget.selected) {
      return Colors.black;
    }
    return Colors.white;
  }

  Color _background() {
    if (widget.selected) {
      return Colors.blueGrey[100]!;
    } else if (hover) {
      return Colors.blueGrey[700]!;
    }
    return Colors.transparent;
  }

  void _onEnter(PointerEnterEvent event) {
    setState(() {
      hover = true;
    });
  }

  void _onExit(PointerExitEvent event) {
    setState(() {
      hover = false;
    });
  }

  _onTap() {
    DemoFluAppState state = DemoFluAppState.of(context)!;
    state.updateCurrentExample(widget.menuItem);
  }
}
