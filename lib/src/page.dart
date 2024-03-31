import 'package:demoflu/src/internal/source_code_widget.dart';
import 'package:demoflu/src/internal/console_widget.dart';
import 'package:flutter/material.dart';

abstract class DemoFluPage {
  const DemoFluPage();

  List<DemoFluPageSection> getSections();
}

class DemoFluPageSection {
  DemoFluPageSection.title(String title)
      : _builder = _TitleWidgetBuilder(title);
  DemoFluPageSection.example(
      {String? title,
      required WidgetBuilder builder,
      Listenable? listenable,
      double minWidth = 0.0,
      double maxWidth = double.infinity,
      double minHeight = 0.0,
      double maxHeight = double.infinity,
      double? aspectRatio})
      : _builder = _ExampleWidgetBuilder(
            builder: builder,
            title: title,
            listenable: listenable,
            minHeight: minHeight,
            minWidth: minWidth,
            maxHeight: maxHeight,
            maxWidth: maxWidth,
            aspectRatio: aspectRatio);
  DemoFluPageSection.dartCode(
      {String? title,
      required String file,
      bool wrap = true,
      bool ignoreEnabled = true})
      : _builder = _DartCodeWidgetBuilder(
            title: title, file: file, wrap: wrap, ignoreEnabled: ignoreEnabled);
  DemoFluPageSection.console({String? title = 'Console', double height = 150})
      : _builder = _ConsoleWidgetBuilder(title: title, height: height);

  final _WidgetBuilder _builder;

  Widget buildWidget(BuildContext context) {
    return _builder.build(context);
  }
}

typedef WidgetBuilder = Widget Function(BuildContext context);

abstract class _WidgetBuilder {
  const _WidgetBuilder();
  Widget build(BuildContext context);
}

class _TitleWidgetBuilder extends _WidgetBuilder {
  const _TitleWidgetBuilder(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
  }
}

class _ExampleWidgetBuilder extends _WidgetBuilder {
  const _ExampleWidgetBuilder(
      {required this.builder,
      required this.title,
      required this.listenable,
      required this.minWidth,
      required this.maxWidth,
      required this.minHeight,
      required this.maxHeight,
      required this.aspectRatio});

  final WidgetBuilder builder;
  final String? title;
  final Listenable? listenable;
  final double minWidth;
  final double maxWidth;
  final double minHeight;
  final double maxHeight;
  final double? aspectRatio;

  @override
  Widget build(BuildContext context) {
    if (title != null) {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [Text(title!), _exampleInListenable(context)]);
    }
    return _exampleInListenable(context);
  }

  Widget _exampleInListenable(BuildContext context) {
    if (listenable != null) {
      return ListenableBuilder(
          listenable: listenable!,
          builder: (BuildContext context, Widget? child) {
            return _exampleInContainer(context);
          });
    }
    return _exampleInContainer(context);
  }

  Widget _exampleInContainer(BuildContext context) {
    return Align(
        alignment: Alignment.centerLeft,
        child: ConstrainedBox(
            constraints: BoxConstraints(
                minWidth: minWidth,
                minHeight: minHeight,
                maxWidth: maxWidth,
                maxHeight: maxHeight),
            child: Container(
                child: _exampleInAspectRatio(context),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black26, width: 1)))));
  }

  Widget _exampleInAspectRatio(BuildContext context) {
    Widget widget = this.builder(context);
    if (aspectRatio != null) {
      return AspectRatio(aspectRatio: aspectRatio!, child: widget);
    }
    return widget;
  }
}

class _DartCodeWidgetBuilder extends _WidgetBuilder {
  _DartCodeWidgetBuilder(
      {required this.title,
      required this.file,
      required this.wrap,
      required this.ignoreEnabled});

  final String? title;
  final String file;
  final bool wrap;
  final bool ignoreEnabled;

  @override
  Widget build(BuildContext context) {
    if (title != null) {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [Text(title!), _codeInContainer(context)]);
    }
    return _codeInContainer(context);
  }

  Widget _codeInContainer(BuildContext context) {
    return SourceCodeWidget(
      file: file,
      wrap: wrap,
      ignoreEnabled: ignoreEnabled,
      key: ValueKey(file),
    );
  }
}

class _ConsoleWidgetBuilder extends _WidgetBuilder {
  _ConsoleWidgetBuilder({required this.title, required this.height});

  final String? title;
  final double height;

  @override
  Widget build(BuildContext context) {
    if (title != null) {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [Text(title!), _consoleInContainer(context)]);
    }
    return _consoleInContainer(context);
  }

  Widget _consoleInContainer(BuildContext context) {
    return Container(
        child: ConsoleWidget(height: height),
        decoration:
            BoxDecoration(border: Border.all(color: Colors.black26, width: 1)));
  }
}
