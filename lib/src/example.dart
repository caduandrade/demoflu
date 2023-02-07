import 'package:flutter/widgets.dart';

/// Abstract example
abstract class AbstractExample extends ChangeNotifier {
  AbstractExample(
      {this.codeFile,
      this.resizable,
      this.maxSize,
      this.consoleEnabled = false});

  final String? codeFile;
  final bool? resizable;
  final Size? maxSize;
  final bool consoleEnabled;

  /// Builds the example widget.
  Widget buildWidget(BuildContext context);

  /// Builds extra bar widgets.
  List<Widget> buildBarWidgets(BuildContext context);

  /// Resets the example.
  void resetExample();

  /// Trigger notification to rebuild example widget
  void rebuildWidget() {
    notifyListeners();
  }
}

/// Simple example
class Example extends AbstractExample {
  Example(
      {String? codeFile,
      bool? resizable,
      Size? maxSize,
      bool consoleEnabled = false,
      required this.widget})
      : super(
            codeFile: codeFile,
            resizable: resizable,
            maxSize: maxSize,
            consoleEnabled: consoleEnabled);

  final Widget widget;

  @override
  Widget buildWidget(BuildContext context) => widget;

  @override
  void resetExample() {}

  @override
  List<Widget> buildBarWidgets(BuildContext context) => [];
}
