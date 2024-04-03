import 'package:demoflu/demoflu.dart';
import 'package:example/pages/banner_page.dart';
import 'package:example/pages/listenable_page.dart';
import 'package:example/pages/console_page.dart';
import 'package:example/pages/boostrap.dart';
import 'package:example/pages/get_started_page.dart';
import 'package:example/pages/ignoring_page.dart';
import 'package:example/pages/page.dart';
import 'package:example/pages/source_code_page.dart';
import 'package:example/pages/stateful_page.dart';
import 'package:example/pages/stateless_page.dart';
import 'package:example/pages/text_page.dart';

void main() {
  DemoFluApp(title: 'DemoFlu (2.0.0)', rootMenus: [
    _getStarted,
    _main,
    _page,
    _pageSections,
    // _notResizable
  ]).run();
}

DemoMenuItem get _getStarted =>
    DemoMenuItem('Get started', page: () => GetStartedPage());

DemoMenuItem get _main =>
    DemoMenuItem('Bootstrap', page: () => BootstrapPage());

DemoMenuItem get _page => DemoMenuItem('Page', page: () => Page());

DemoMenuItem get _pageSections => DemoMenuItem('Page sections',
    children: [_sourceCode, _text, _banner, _widgetSection, _console]);

DemoMenuItem get _sourceCode => DemoMenuItem('Source code',
    page: () => SourceCodePage(), children: [_ignoringMarkedCode]);

DemoMenuItem get _ignoringMarkedCode =>
    DemoMenuItem('Ignoring marked code', page: () => IgnoringPage());

DemoMenuItem get _text => DemoMenuItem('Text', page: () => TextPage());

DemoMenuItem get _banner => DemoMenuItem('Banner', page: () => BannerPage());

DemoMenuItem get _widgetSection =>
    DemoMenuItem('Widget', children: [_stateless, _stateful, _listenable]);

DemoMenuItem get _stateless =>
    DemoMenuItem('Stateless', page: () => StatelessPage());

DemoMenuItem get _stateful =>
    DemoMenuItem('Stateful', page: () => StatefulPage());

DemoMenuItem get _listenable =>
    DemoMenuItem('Listenable', page: () => ListenablePage());

DemoMenuItem get _console => DemoMenuItem('Console', page: () => ConsolePage());

/*
DemoMenuItem get _notResizable =>
    DemoMenuItem('Not resizable', example: NotResizableExample());
 */
