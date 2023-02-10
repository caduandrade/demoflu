import 'package:demoflu/src/demo_menu_item.dart';
import 'package:demoflu/src/internal/rebuild_notifier.dart';
import 'package:flutter/material.dart';

/// Menu widget
class MenuWidget extends StatelessWidget {
  MenuWidget(
      {required this.menuItems,
      required this.selectedMenuItem,
      required this.onMenuItemTap,
      required this.rebuildNotifier});

  final List<DemoMenuItem> menuItems;
  final DemoMenuItem? selectedMenuItem;
  final OnMenuItemTap onMenuItemTap;
  final RebuildNotifier rebuildNotifier;

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    for (DemoMenuItem menuItem in menuItems) {
      children.add(_MenuItemWidget(
          onMenuItemTap: onMenuItemTap,
          selected: selectedMenuItem == menuItem,
          menuItem: menuItem,
          rebuildNotifier: rebuildNotifier));
    }
    return Container(
      child: SingleChildScrollView(
        child: IntrinsicWidth(
            child: Column(
                children: children,
                crossAxisAlignment: CrossAxisAlignment.stretch)),
      ),
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

/// Menu item widget
class _MenuItemWidget extends StatefulWidget {
  const _MenuItemWidget(
      {required this.onMenuItemTap,
      required this.selected,
      required this.menuItem,
      required this.rebuildNotifier});

  final OnMenuItemTap onMenuItemTap;
  final bool selected;
  final DemoMenuItem menuItem;
  final RebuildNotifier rebuildNotifier;

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
        indent: widget.menuItem.indent,
        onHover: _onHover,
        onTap: widget.menuItem.example != null ? _onItemTap : null));

    if (widget.menuItem.isChildrenEmpty) {
      children.add(_MenuItemIcon(
          iconType: _IconType.item,
          foreground: _foreground,
          onHover: _onHover,
          onTap: widget.menuItem.example != null ? _onItemTap : null));
    } else {
      if (widget.menuItem.expanded) {
        children.add(_MenuItemIcon(
            iconType: _IconType.less,
            foreground: _foreground,
            onHover: _onHover,
            onTap: () => _onExpand(false)));
      } else {
        children.add(_MenuItemIcon(
            iconType: _IconType.more,
            foreground: _foreground,
            onHover: _onHover,
            onTap: () => _onExpand(true)));
      }
    }
    children.add(Flexible(
        child: MenuItemText(
            text: widget.menuItem.name,
            foreground: _foreground,
            onHover: _onHover,
            onTap: widget.menuItem.example != null ? _onItemTap : null)));

    return Container(
        color: _background,
        child: IntrinsicHeight(
            child: Row(
                children: children,
                crossAxisAlignment: CrossAxisAlignment.stretch)));
  }

  void _onExpand(bool expanded) {
    widget.menuItem.expanded = expanded;
    widget.rebuildNotifier.treeStructChange();
  }

  void _onHover(bool value) {
    setState(() {
      _hover = value;
    });
  }

  Color get _foreground {
    if (widget.selected) {
      return Colors.black;
    }
    return Colors.white;
  }

  Color get _background {
    if (widget.selected) {
      return Colors.blueGrey[100]!;
    } else if (_hover) {
      return Colors.blueGrey[700]!;
    }
    return Colors.transparent;
  }

  _onItemTap() {
    widget.onMenuItemTap(widget.menuItem);
  }
}

typedef OnMenuItemTap = void Function(DemoMenuItem menuItem);

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
class MenuItemText extends StatelessWidget {
  const MenuItemText(
      {super.key,
      required this.text,
      required this.foreground,
      required this.onHover,
      required this.onTap});

  final String text;
  final ValueChanged<bool>? onHover;
  final GestureTapCallback? onTap;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Container(
            padding: EdgeInsets.fromLTRB(0, 8, 8, 8),
            child: Text(text,
                style: TextStyle(
                    color: foreground, fontSize: 12, fontStyle: _fontStyle()))),
        onHover: onHover,
        onTap: onTap);
  }

  FontStyle _fontStyle() {
    if (onTap != null) {
      return FontStyle.normal;
    }
    return FontStyle.italic;
  }
}

/// Menu item icon type
enum _IconType { more, less, item }

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
    if (widget.iconType == _IconType.item) {
      return InkWell(
          child: Container(
              padding: EdgeInsets.all(10),
              width: _width,
              child: FittedBox(
                  child: Icon(Icons.circle, color: widget.foreground, size: 1),
                  fit: BoxFit.fitWidth),
              color: _background),
          onTap: widget.onTap,
          onHover: _onHover);
    }

    return InkWell(
        child: SizedBox(
            width: _width,
            child: Container(
                child: FittedBox(
                    child: Icon(
                        widget.iconType == _IconType.more
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
    if (_hover && widget.iconType != _IconType.item) {
      return Colors.blueGrey[300]!;
    }
    return Colors.transparent;
  }
}
