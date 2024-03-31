import 'dart:async';

import 'package:demoflu/demoflu.dart';
import 'package:demoflu/src/internal/app_widget.dart';
import 'package:demoflu/src/internal/model.dart';
import 'package:demoflu/src/internal/provider.dart';
import 'package:demoflu/src/internal/print_notifier.dart';
import 'package:flutter/material.dart';

//TODO menu starting collapsed or expanded?

/// DemoFlu bootstrap.
class DemoFluApp {
  DemoFluApp(
      {required String title,
      required List<DemoMenuItem> rootMenus,
      bool resizable = true,
      Color exampleBackground = Colors.white,
      Size? maxSize,
      double widthWeight = 1,
      double minMenuWidth = 0,
      double maxMenuWidth = 400,
      double heightWeight = 1})
      : model = DemoFluModel(
            title: title,
            rootMenus: rootMenus,
            resizable: resizable,
            exampleBackground: exampleBackground,
            maxSize: maxSize,
            widthWeight: widthWeight,
            minMenuWidth: minMenuWidth,
            maxMenuWidth: maxMenuWidth,
            heightWeight: heightWeight);

  final DemoFluModel model;
  final PrintNotifier printNotifier = PrintNotifier();

  void run() async {
    runZonedGuarded<Future<void>>(() async {
      WidgetsFlutterBinding.ensureInitialized();
      await model.initializeHighlighter();
      runApp(MaterialApp(
          debugShowCheckedModeBanner: false,
          title: model.title,
          theme: ThemeData(
              primarySwatch: Colors.blueGrey,
              scaffoldBackgroundColor: Colors.white),
          home: DemoFluProvider(
              model: model,
              printNotifier: printNotifier,
              child: DemoFluAppWidget())));
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
