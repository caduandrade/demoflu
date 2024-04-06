import 'package:demoflu/src/internal/resizable_example_widget.dart';
import 'package:demoflu/src/internal/sections/titled_widget.dart';
import 'package:demoflu/src/page.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@internal
class WidgetContainer extends StatelessWidget {
  WidgetContainer(this.section);

  final WidgetSection section;

  //@override
  Widget build3(BuildContext context) {
    return Align(
        alignment: Alignment.centerLeft,
        child: Container(
            height: 20,
            color: Colors.green,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [Text('?')],
            )));
  }

  //@override
  Widget build(BuildContext context) {
    if (section.listenable != null) {
      return ListenableBuilder(
          listenable: section.listenable!,
          builder: (BuildContext context, Widget? child) {
            return _container(context);
          });
    }
    return _container(context);
  }

  Widget _container(BuildContext context) {
    return Align(
        alignment: Alignment.centerLeft,
        child: ConstrainedBox(
          constraints: BoxConstraints(
              minWidth: section.minWidth,
              minHeight: section.minHeight,
              maxWidth: section.maxWidth,
              maxHeight: section.maxHeight
              // maxHeight: 400
              ),
          child: _aspectRatio(context),
        ));
  }

  Widget _aspectRatio(BuildContext context) {
    Widget widget = TitledWidget(
        child: _ex(context), title: section.title, bordered: section.bordered);

    if (section.aspectRatio != null) {
      return AspectRatio(aspectRatio: section.aspectRatio!, child: widget);
    }
    return widget;
  }

  Widget _ex(BuildContext context) {
    if (false) {
      return Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Container(
          color: Colors.yellow,
          width: 20,
          height: 22,
        ),
        Expanded(child: section.widgetBuilder(context))
      ]);
    }
    return section.widgetBuilder(context);
  }
}