import 'package:demoflu/src/demoflu_settings.dart';
import 'package:flutter/material.dart';

class ConsoleWidget extends StatefulWidget {
  ConsoleWidget({required this.settings});

  final DemoFluSettings settings;

  @override
  State<StatefulWidget> createState() => ConsoleWidgetState();
}

class ConsoleWidgetState extends State<ConsoleWidget> {
  @override
  void initState() {
    super.initState();
    widget.settings.console.addListener(_rebuild);
  }

  @override
  void dispose() {
    widget.settings.console.removeListener(_rebuild);
    super.dispose();
  }

  @override
  void didUpdateWidget(ConsoleWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.settings.console != widget.settings.console) {
      oldWidget.settings.console.removeListener(_rebuild);
      widget.settings.console.addListener(_rebuild);
    }
  }

  void _rebuild() {
    setState(() {
      // rebuild
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: ListView.builder(padding: EdgeInsets.all(8),shrinkWrap: true,
            itemBuilder: _itemBuilder,
            itemCount: widget.settings.console.values.length),color: Colors.white);
  }

  Widget? _itemBuilder(BuildContext context, int index) {
    return Text(widget.settings.console.values[index]);
  }
}
