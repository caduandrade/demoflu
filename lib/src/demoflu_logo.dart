import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

const _url = 'https://pub.dev/packages/demoflu';

/// The DemoFlu logo widget.
class DemoFluLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Column column = Column(children: [
      Text('built with', style: TextStyle(fontSize: 12)),
      Text('DemoFlu', style: TextStyle(fontSize: 14))
    ], mainAxisAlignment: MainAxisAlignment.center);
    FittedBox fittedBox = FittedBox(child: column, fit: BoxFit.scaleDown);
    EdgeInsets padding = EdgeInsets.fromLTRB(16, 8, 16, 8);
    Container container = Container(child: fittedBox, padding: padding);
    return InkWell(
        child: LimitedBox(child: container, maxHeight: kToolbarHeight),
        onTap: () => _launchURL());
  }

  void _launchURL() async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';
}
