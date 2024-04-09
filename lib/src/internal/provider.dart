import 'package:demoflu/src/internal/model.dart';
import 'package:demoflu/src/internal/print_notifier.dart';
import 'package:demoflu/src/sections_defaults.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

/// Provider to provide the notifiers and model.
@internal
class DemoFluProvider extends InheritedWidget {
  DemoFluProvider({
    super.key,
    required this.model,
    required this.printNotifier,
    required this.sectionDefaults,
    required super.child,
  });

  final DemoFluModel model;

  final PrintNotifier printNotifier;

  final SectionDefaults sectionDefaults;

  @override
  bool updateShouldNotify(DemoFluProvider oldWidget) => false;

  static DemoFluProvider _of(BuildContext context) {
    DemoFluProvider? provider =
        context.dependOnInheritedWidgetOfExactType<DemoFluProvider>();
    if (provider == null) {
      throw StateError('Widget is not inheriting from DemoFluProvider');
    }
    return provider;
  }

  static DemoFluModel modelOf(BuildContext context) {
    DemoFluProvider provider = _of(context);
    return provider.model;
  }

  static PrintNotifier printNotifierOf(BuildContext context) {
    DemoFluProvider provider = _of(context);
    return provider.printNotifier;
  }

  static SectionDefaults sectionDefaultsOf(BuildContext context) {
    DemoFluProvider provider = _of(context);
    return provider.sectionDefaults;
  }
}
