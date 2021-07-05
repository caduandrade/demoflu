import 'package:demoflu/src/demoflu_app.dart';
import 'package:demoflu/src/example.dart';
import 'package:demoflu/src/section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AppMenuWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DemoFluAppState state = DemoFluAppState.of(context)!;
    List<Widget> children = [];
    for (DFSection section in state.sections) {
      if (section.name != null) {
        children.add(Container(
            child: Text(section.name!,
                style: TextStyle(
                    fontStyle: FontStyle.italic, color: Colors.grey[300])),
            padding: EdgeInsets.only(left: 8, right: 16, top: 8)));
      }
      for (DFExample example in section.examples) {
        children.add(_MenuItem(state.currentExample == example, example));
      }
    }
    return Container(
        child: SingleChildScrollView(
            child: Column(
                children: children,
                crossAxisAlignment: CrossAxisAlignment.start)),
        decoration: BoxDecoration(
            color: Colors.blueGrey[800],
            border: Border(
                right: BorderSide(width: 1, color: Colors.blueGrey[900]!))));
  }
}

class _MenuItem extends StatefulWidget {
  const _MenuItem(this.selected, this.example);

  final bool selected;
  final DFExample example;

  @override
  State<StatefulWidget> createState() => _MenuItemState();
}

class _MenuItemState extends State<_MenuItem> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
        onEnter: _onEnter,
        onExit: _onExit,
        child: Container(
            margin: EdgeInsets.only(top: 8, bottom: 0, right: 16),
            decoration: BoxDecoration(
                border:
                    Border(left: BorderSide(width: 8, color: _borderColor()))),
            child: _text()));
  }

  Color _borderColor() {
    if (widget.selected) {
      return Colors.white;
    } else if (hover) {
      return Colors.white.withOpacity(.4);
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

  Widget _text() {
    return InkWell(
        child: Padding(
            child: Text(widget.example.name,
                style: TextStyle(color: Colors.white)),
            padding: EdgeInsets.only(left: 8)),
        onTap: _onTap);
  }

  _onTap() {
    DemoFluAppState state = DemoFluAppState.of(context)!;
    state.updateCurrentExample(widget.example);
  }
}
