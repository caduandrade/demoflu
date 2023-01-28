import 'package:demoflu/src/demo_menu_item.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DemoMenuItem', () {
    test('indent', () {
      DemoMenuItem item = DemoMenuItem(name: 'name', indent: 0);
      expect(item.indent, 1);
      item = DemoMenuItem(name: 'name', indent: 2);
      expect(item.indent, 2);
      item = DemoMenuItem(name: 'name', indent: -10);
      expect(item.indent, 1);
    });
  });
}
