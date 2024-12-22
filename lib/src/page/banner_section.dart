import 'package:demoflu/src/macro.dart';
import 'package:demoflu/src/page/page_section.dart';
import 'package:demoflu/src/page/text_section_mixin.dart';
import 'package:demoflu/src/provider.dart';
import 'package:flutter/material.dart';

/// Section to display a banner.
class BannerSection extends PageSection with TextSectionMixin {
  BannerSection(
      {required super.marginLeft,
      required super.marginBottom,
      required super.maxWidth,
      required String text,
      required this.background,
      required this.border,
      required this.icon}) {
    if (text.isNotEmpty) {
      this.text.add(TextSpan(text: text));
    }
  }

  Color background;
  Color border;
  IconData? icon;

  @override
  Widget buildContent(BuildContext context) {
    return _BannerSectionWidget(
        text: TextSpan(children: text),
        background: background,
        border: border,
        icon: icon);
  }

  @override
  void runMacro({required dynamic id, required BuildContext context}) {
    MacroFactory macroFactory = DemoFluProvider.macroFactoryOf(context);
    BannerMacro macro =
        MacroFactoryHelper.getMacro<BannerMacro>(id, 'Banner', macroFactory);
    macro(context, this);
  }
}

/// Widget for banner section.
class _BannerSectionWidget extends StatelessWidget {
  const _BannerSectionWidget(
      {required this.background,
      required this.border,
      required this.text,
      required this.icon});

  final Color background;
  final Color border;
  final TextSpan text;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    Widget widget = _textWidget();
    if (icon != null) {
      widget = Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Icon(icon!, color: border), SizedBox(width: 8),
        Flexible(child: widget) //Expanded(child: widget)
      ]);
    }
    return Align(alignment: Alignment.centerLeft, child: widget);
  }

  Widget _textWidget() {
    return Container(
        decoration: BoxDecoration(
            color: background,
            border: Border(left: BorderSide(color: border, width: 8))),
        child: Padding(
            padding: EdgeInsets.all(8), child: SelectableText.rich(text)));
  }
}
