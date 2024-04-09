import 'dart:async';

import 'package:demoflu/demoflu.dart';
import 'package:demoflu/src/internal/app_widget.dart';
import 'package:demoflu/src/internal/model.dart';
import 'package:demoflu/src/internal/provider.dart';
import 'package:demoflu/src/internal/print_notifier.dart';
import 'package:flutter/material.dart';

/// DemoFlu bootstrap.
class DemoFluApp {
  DemoFluApp(
      {required String title,
      required List<DemoMenuItem> rootMenus,
      this.sectionDefaults = const SectionDefaults()})
      : model = DemoFluModel(title: title, rootMenus: rootMenus);

  final DemoFluModel model;
  final PrintNotifier printNotifier = PrintNotifier();
  final SectionDefaults sectionDefaults;

  void run() async {
    runZonedGuarded<Future<void>>(() async {
      WidgetsFlutterBinding.ensureInitialized();
      await model.initializeHighlighter();
      runApp(DemoFluProvider(
          model: model,
          printNotifier: printNotifier,
          sectionDefaults: sectionDefaults,
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
