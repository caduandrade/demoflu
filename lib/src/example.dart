import 'package:flutter/widgets.dart';

abstract class AbstractExample extends ChangeNotifier {
  AbstractExample(
      {this.codeFile, this.resizable, this.maxSize, this.consoleEnabled});

  final String? codeFile;
  final bool? resizable;
  final Size? maxSize;
  final bool? consoleEnabled;

  Widget buildWidget(BuildContext context);

  List<Widget> buildBarWidgets(BuildContext context);

  void resetExample();

  void rebuildWidget() {
    notifyListeners();
  }
}

class Example extends AbstractExample {
  Example(
      {String? codeFile,
      bool? resizable,
      Size? maxSize,
      bool? consoleEnabled,
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
