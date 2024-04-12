import 'dart:async';

import 'package:demoflu/demoflu.dart';
import 'package:demoflu/src/model.dart';
import 'package:demoflu/src/provider.dart';
import 'package:demoflu/src/print_notifier.dart';
import 'package:demoflu/src/widgets/app_widget.dart';
import 'package:flutter/material.dart';

/// DemoFlu bootstrap.
class DemoFluApp {
  DemoFluApp(
      {required String title,
      required List<DemoMenuItem> rootMenus,
      DemoFluTheme? theme})
      : model = DemoFluModel(title: title, rootMenus: rootMenus),
        theme = theme ?? DemoFluTheme();

  final DemoFluModel model;
  final PrintNotifier printNotifier = PrintNotifier();
  final DemoFluTheme theme;

  void run() async {
    runZonedGuarded<Future<void>>(() async {
      WidgetsFlutterBinding.ensureInitialized();
      await model.initializeHighlighter();
      runApp(DemoFluProvider(
          model: model,
          printNotifier: printNotifier,
          theme: theme,
          child: DemoFluAppWidget()));
    }, (error, stackTrace) {
      print('Error: $error');
      print(stackTrace);
    }, zoneSpecification: ZoneSpecification(
        print: (Zone self, ZoneDelegate parent, Zone zone, String line) {
      parent.print(zone, line);
      printNotifier.update(line);
    }));
  }
}
