import 'package:demoflu/src/page/borders/section_border.dart';
import 'package:demoflu/src/page/page_section_group.dart';
import 'package:demoflu/src/page/section_collection.dart';
import 'package:flutter/material.dart';

/// Page to display content in page.
/// Use different methods to create page according to your needs.
class DemoFluPage with SectionCollectionMixin {
  PageSectionGroup group(
      {double? marginLeft,
      double? marginBottom,
      EdgeInsetsGeometry? padding,
      Color? background,
      SectionBorder? border,
      double maxWidth = double.infinity,
      String? title}) {
    PageSectionGroup group = PageSectionGroup(
        title: title,
        marginLeft: marginLeft,
        marginBottom: marginBottom,
        padding: padding,
        background: background,
        border: border,
        maxWidth: maxWidth);
    SectionCollectionHelper.addSectionOn(group, this);
    return group;
  }
}
