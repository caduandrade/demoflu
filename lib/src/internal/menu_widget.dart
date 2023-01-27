import 'package:demoflu/src/internal/demoflu_settings.dart';
import 'package:demoflu/src/demo_menu_item.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class MenuWidget extends StatelessWidget {
  MenuWidget({required this.settings, required this.menuItems});

  final DemoFluSettings settings;
  final List<DemoMenuItem> menuItems;

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    for (DemoMenuItem menuItem in menuItems) {
      children.add(_MenuItemWidget(
          settings: settings,
          selected: settings.currentMenuItem == menuItem,
          menuItem: menuItem));
    }
    return Container(
      child: SingleChildScrollView(
          child: IntrinsicWidth(
              child: Column(
                  children: children,
                  crossAxisAlignment: CrossAxisAlignment.stretch))),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 0), // changes position of shadow
            ),
          ],
          color: Colors.blueGrey[900],
          border: Border(
              right: BorderSide(color: Colors.blueGrey[900]!, width: 2))),
    );
  }
}

class _MenuItemWidget extends StatefulWidget {
  const _MenuItemWidget(
      {required this.settings, required this.selected, required this.menuItem});

  final DemoFluSettings settings;
  final bool selected;
  final DemoMenuItem menuItem;

  @override
  State<StatefulWidget> createState() => _MenuItemWidgetState();
}

class _MenuItemWidgetState extends State<_MenuItemWidget> {
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
    widget.settings.updateCurrentExample(widget.menuItem);
  }
}
