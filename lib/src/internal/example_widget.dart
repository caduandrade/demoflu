import 'package:demoflu/src/internal/titled_widget.dart';
import 'package:demoflu/src/page.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@internal
class ExampleWidget extends StatelessWidget {
  ExampleWidget(this.section);

  final ExampleSection section;

  @override
  Widget build(BuildContext context) {
    return TitledWidget(
        child: _exampleInListenable(context), title: section.title);
  }

  Widget _exampleInListenable(BuildContext context) {
    if (section.listenable != null) {
      return ListenableBuilder(
          listenable: section.listenable!,
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
              minWidth: section.minWidth,
              minHeight: section.minHeight,
              maxWidth: section.maxWidth,
              maxHeight: section.maxHeight),
          child: _exampleInAspectRatio(context),
        ));
  }

  Widget _exampleInAspectRatio(BuildContext context) {
    if (section.aspectRatio != null) {
      return AspectRatio(
          aspectRatio: section.aspectRatio!,
          child: section.widgetBuilder(context));
    }
    return section.widgetBuilder(context);
  }
}
