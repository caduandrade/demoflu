import 'dart:async';

import 'package:demoflu/demoflu.dart';
import 'package:demoflu/src/model.dart';
import 'package:demoflu/src/page/code_cache.dart';
import 'package:demoflu/src/provider.dart';
import 'package:demoflu/src/print_notifier.dart';
import 'package:demoflu/src/widgets/app_widget.dart';
import 'package:flutter/material.dart';

/// DemoFlu bootstrap.
class DemoFluApp {
  DemoFluApp(
      {required String title,
      required List<DemoMenuItem> rootMenus,
      DemoFluTheme? theme,
      MacroFactory? macroFactory})
      : _model = DemoFluModel(title: title, rootMenus: rootMenus),
        _theme = theme ?? DemoFluTheme(),
        macro = macroFactory ?? MacroFactory();

  final DemoFluModel _model;
  final PrintNotifier _printNotifier = PrintNotifier();
  final DemoFluTheme _theme;
  final MacroFactory macro;
  final CodeCache _codeCache = CodeCache();

  void run() async {
    runZonedGuarded<Future<void>>(() async {
      WidgetsFlutterBinding.ensureInitialized();
      await _model.initializeHighlighter();
      runApp(DemoFluProvider(
          model: _model,
          printNotifier: _printNotifier,
          theme: _theme,
          macroFactory: macro,
          codeCache: _codeCache,
          child: DemoFluAppWidget()));
    }, (error, stackTrace) {
      print('Error: $error');
      print(stackTrace);
    }, zoneSpecification: ZoneSpecification(
        print: (Zone self, ZoneDelegate parent, Zone zone, String line) {
      parent.print(zone, line);
      _printNotifier.update(line);
    }));
  }
}
