import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

/// Stacks an icon for copying to the clipboard on top of a widget.
@internal
class ClipboardCopyWidget extends StatefulWidget {
  const ClipboardCopyWidget(
      {Key? key, required this.codeSupplier, required this.child})
      : super(key: key);

  final CodeSupplier? codeSupplier;
  final Widget child;

  @override
  State<StatefulWidget> createState() => ClipboardCopyWidgetState();
}

typedef CodeSupplier = String Function();

class ClipboardCopyWidgetState extends State<ClipboardCopyWidget> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    if (widget.codeSupplier == null) {
      return widget.child;
    }
    return MouseRegion(
        onEnter: (event) => _setHover(true),
        onExit: (event) => _setHover(false),
        child: Stack(fit: StackFit.passthrough, children: [
          widget.child,
          if (_hover) Positioned(child: _iconButton(), right: 0, top: 0)
        ]));
  }

  void _setHover(bool value) {
    setState(() {
      _hover = value;
    });
  }

  Widget _iconButton() {
    return Tooltip(
        message: 'Copy to clipboard',
        child: Container(
            padding: EdgeInsets.all(8),
            color: Colors.white.withOpacity(.7),
            child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () =>
                      _copyToClipboard(context, widget.codeSupplier!()),
                  child: const Icon(Icons.content_copy),
                ))));
  }

  Future<void> _copyToClipboard(BuildContext context, String text) async {
    await Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Copied to clipboard'), duration: Duration(seconds: 2)));
  }
}
