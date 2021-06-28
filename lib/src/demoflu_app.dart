import 'package:flutter/material.dart';

class DemoFluApp extends StatelessWidget {
  const DemoFluApp({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: Scaffold(
            appBar: AppBar(title: Text(title), actions: [_DemoFluLogo()]),
            body: Center(
              child: Text('Test'),
            )));
  }
}

class _DemoFluLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Column column = Column(children: [
      Text('Built with', style: TextStyle(color: Colors.black, fontSize: 12)),
      Text('DemoFlu', style: TextStyle(color: Colors.black, fontSize: 14))
    ], mainAxisAlignment: MainAxisAlignment.center);
    FittedBox fittedBox = FittedBox(child: column, fit: BoxFit.scaleDown);
    EdgeInsets padding = EdgeInsets.fromLTRB(16, 8, 16, 8);
    Container container = Container(
        child: fittedBox,
        padding: padding,
        color: Colors.white.withOpacity(.7));
    return LimitedBox(child: container, maxHeight: kToolbarHeight);
  }
}
