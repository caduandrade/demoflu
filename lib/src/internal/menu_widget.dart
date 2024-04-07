import 'package:demoflu/src/demo_menu_item.dart';
import 'package:demoflu/src/internal/model.dart';
import 'package:demoflu/src/internal/provider.dart';
import 'package:demoflu/src/internal/print_notifier.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

/// Menu widget
@internal
class MenuWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MenuWidgetState();
}

@internal
class MenuWidgetState extends State<MenuWidget> {
  void _rebuild() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    DemoFluModel model = DemoFluProvider.modelOf(context);

    List<Widget> children = [];
    for (DemoMenuItem menuItem in model.fetchMenuItems()) {
      children.add(_MenuItemWidget(
          selected: model.selectedMenuItem == menuItem,
          menuItem: menuItem,
          onExpansionStateChanged: _rebuild));
    }
    return Container(
      child: SingleChildScrollView(
          child: Column(
              children: children,
              crossAxisAlignment: CrossAxisAlignment.stretch)),
      decoration: BoxDecoration(
          color: Colors.white,
          border:
              Border(right: BorderSide(color: Colors.grey[300]!, width: 2))),
    );
  }
}

/// Menu item widget
class _MenuItemWidget extends StatefulWidget {
  const _MenuItemWidget(
      {required this.selected,
      required this.menuItem,
      required this.onExpansionStateChanged});

  final bool selected;
  final DemoMenuItem menuItem;
  final Function onExpansionStateChanged;

  @override
  State<StatefulWidget> createState() => _MenuItemWidgetState();
}

/// The [_MenuItemWidget] state.
class _MenuItemWidgetState extends State<_MenuItemWidget> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    children.add(Indent(
        indent: widget.menuItem.indent, onHover: _onHover, onTap: _onItemTap));

    if (widget.menuItem.page != null ||
        (widget.menuItem.childrenLength > 0 && !widget.menuItem.expanded)) {
      children.add(Expanded(
          child: _MenuItemText(
              text: widget.menuItem.name,
              foreground: _foreground,
              selected: widget.selected,
              onHover: _onHover,
              onTap: _onItemTap)));
    } else {
      children.add(Expanded(
          child: _MenuItemText(
              text: widget.menuItem.name,
              foreground: _foreground,
              selected: widget.selected,
              onHover: null,
              onTap: null)));
    }

    if (!widget.menuItem.isChildrenEmpty) {
      if (widget.menuItem.expanded) {
        children.add(_MenuItemIcon(
            iconType: _IconType.expanded,
            foreground: _foreground,
            onHover: _onHover,
            onTap: () => _onExpand(false)));
      } else {
        children.add(_MenuItemIcon(
            iconType: _IconType.collapsed,
            foreground: _foreground,
            onHover: _onHover,
            onTap: () => _onExpand(true)));
      }
    }

    return Container(
        color: _background,
        child: IntrinsicHeight(
            child: Padding(
                padding: EdgeInsets.fromLTRB(
                    8, 0, widget.menuItem.isChildrenEmpty ? 8 : 0, 0),
                child: Row(
                    children: children,
                    crossAxisAlignment: CrossAxisAlignment.stretch))));
  }

  void _onExpand(bool expanded) {
    widget.menuItem.expanded = expanded;
    widget.onExpansionStateChanged();
  }

  void _onHover(bool value) {
    setState(() {
      _hover = value;
    });
  }

  Color get _foreground {
    if (widget.selected) {
      // return Colors.black;
      return Colors.grey[900]!;
    }
    if (widget.menuItem.page != null) {
      return Colors.grey[900]!;
    }
    return Colors.grey[600]!;
  }

  Color get _background {
    if (widget.selected) {
      return Colors.grey[200]!;
    } else if (_hover) {
      return Colors.grey[300]!;
    }
    return Colors.transparent;
  }

  _onItemTap() {
    PrintNotifier printNotifier = DemoFluProvider.printNotifierOf(context);
    printNotifier.clear(notify: false);

    if (!widget.menuItem.isChildrenEmpty && !widget.menuItem.expanded) {
      widget.menuItem.expanded = true;
      if (widget.menuItem.page == null) {
        widget.onExpansionStateChanged();
      }
    }

    if (widget.menuItem.page != null) {
      DemoFluModel model = DemoFluProvider.modelOf(context);
      model.selectedMenuItem = widget.menuItem;
    }
  }
}

/// Indent widget
class Indent extends StatelessWidget {
  const Indent(
      {super.key,
      required this.indent,
      required this.onHover,
      required this.onTap});

  final int indent;
  final ValueChanged<bool> onHover;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: SizedBox(width: (16 * indent).toDouble()),
        onTap: onTap,
        onHover: onHover);
  }
}

/// Menu item text widget
class _MenuItemText extends StatelessWidget {
  const _MenuItemText(
      {required this.text,
      required this.foreground,
      required this.onHover,
      required this.onTap,
      required this.selected});

  final String text;
  final ValueChanged<bool>? onHover;
  final GestureTapCallback? onTap;
  final Color foreground;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Container(
            padding: EdgeInsets.fromLTRB(0, 8, 8, 8),
            child: Text(text,
                style: TextStyle(
                    color: foreground,
                    fontWeight:
                        selected ? FontWeight.bold : FontWeight.normal))),
        onHover: onHover,
        onTap: onTap);
  }
}

/// Menu item icon type
enum _IconType { collapsed, expanded }

/// Menu item icon widget
class _MenuItemIcon extends StatefulWidget {
  const _MenuItemIcon(
      {required this.iconType,
      required this.foreground,
      required this.onTap,
      required this.onHover});

  final _IconType iconType;
  final Color foreground;
  final GestureTapCallback? onTap;
  final ValueChanged<bool>? onHover;

  @override
  State<StatefulWidget> createState() => _MenuItemIconState();
}

/// The [_MenuItemIcon] state.
class _MenuItemIconState extends State<_MenuItemIcon> {
  bool _hover = false;

  final double _width = 28;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: SizedBox(
            width: _width,
            child: Container(
                child: FittedBox(
                    child: Icon(
                        widget.iconType == _IconType.collapsed
                            ? Icons.expand_more
                            : Icons.expand_less,
                        color: widget.foreground,
                        size: 1),
                    fit: BoxFit.fitWidth),
                color: _background)),
        onTap: widget.onTap,
        onHover: _onHover);
  }

  void _onHover(bool value) {
    setState(() {
      _hover = value;
    });
    if (widget.onHover != null) {
      widget.onHover!(value);
    }
  }

  Color get _background {
    if (_hover) {
      return Colors.grey[400]!;
    }
    return Colors.transparent;
  }
}
