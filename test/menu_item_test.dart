import 'package:demoflu/src/demo_menu_item.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DemoMenuItem', () {
    test('indent', () {
      DemoMenuItem leaf = DemoMenuItem('leaf');
      DemoMenuItem middle = DemoMenuItem('middle', children: [leaf]);
      DemoMenuItem root = DemoMenuItem('root', children: [middle]);
      expect(root.indent, 0);
      expect(middle.indent, 1);
      expect(leaf.indent, 2);
    });
  });
}
