import 'package:demoflu/demoflu.dart';
import 'package:example/pages/addon_page.dart';
import 'package:example/pages/console_page.dart';
import 'package:example/pages/ignore_page.dart';
import 'package:example/pages/stateful_page.dart';
import 'package:example/pages/stateless_page.dart';
import 'package:example/pages/text_page.dart';

void main() {
  DemoFluApp(title: 'DemoFlu (2.0.0)', rootMenus: [
    _stateless,
    _stateful,
    _console,
    _addon,
    // _notResizable,
    _ignoreMarkedCode,
    _nestedSection
  ]).run();
}

DemoMenuItem get _stateless => DemoMenuItem('Stateless', page: StatelessPage());

DemoMenuItem get _stateful => DemoMenuItem('Stateful', page: StatefulPage());

DemoMenuItem get _console => DemoMenuItem('Console', page: ConsolePage());

DemoMenuItem get _addon => DemoMenuItem('Addon', page: AddonPage());

/*
DemoMenuItem get _notResizable =>
    DemoMenuItem('Not resizable', example: NotResizableExample());


 */
DemoMenuItem get _ignoreMarkedCode =>
    DemoMenuItem('Ignore marked code', page: IgnorePage());

DemoMenuItem get _nestedSection => DemoMenuItem('Nested sections')
  ..add(_section1WithExample)
  ..add(_section2WithExample);

DemoMenuItem get _section1WithExample =>
    DemoMenuItem('Section 1', page: const TextPage('Section 1'))
      ..add(_leaf1a)
      ..add(_leaf1b);

DemoMenuItem get _leaf1a =>
    DemoMenuItem('Leaf 1a', page: const TextPage('Leaf 1a'));

DemoMenuItem get _leaf1b =>
    DemoMenuItem('Leaf 1b', page: const TextPage('Leaf 1b'));

DemoMenuItem get _section2WithExample =>
    DemoMenuItem('Section 2', page: const TextPage('Section 2'))
      ..add(_leaf2a)
      ..add(_leaf2b);

DemoMenuItem get _leaf2a =>
    DemoMenuItem('Leaf 2a', page: const TextPage('Leaf 2a'));

DemoMenuItem get _leaf2b =>
    DemoMenuItem('Leaf 2b', page: const TextPage('Leaf 2b'));
