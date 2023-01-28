import 'package:demoflu/src/demo_menu_item.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DemoMenuItem', () {
    test('fetch', () {
      //root1
      //root1-a
      //root1-a-a
      //root1-b
      //root1-b-a
      //root1-b-b
      //root1-b-b-a
      DemoMenuItem root1 = DemoMenuItem(name: 'root1', children: [
        DemoMenuItem(
            name: 'root1-a', children: [DemoMenuItem(name: 'root1-a-a')]),
        DemoMenuItem(name: 'root1-b', children: [
          DemoMenuItem(name: 'root1-b-a'),
          DemoMenuItem(
              name: 'root1-b-b', children: [DemoMenuItem(name: 'root1-b-b-a')])
        ])
      ]);
      //root2
      //root2-a
      //root2-a-a
      //root2-a-a-a
      //root2-b
      //root2-c
      //root2-c-a
      DemoMenuItem root2 = DemoMenuItem(name: 'root2', children: [
        DemoMenuItem(name: 'root2-a', children: [
          DemoMenuItem(
              name: 'root2-a-a', children: [DemoMenuItem(name: 'root2-a-a-a')])
        ]),
        DemoMenuItem(name: 'root2-b'),
        DemoMenuItem(
            name: 'root2-c', children: [DemoMenuItem(name: 'root2-c-a')])
      ]);

      expect(DemoMenuItem.recursiveFetch([root1]).length, 7);
      expect(DemoMenuItem.recursiveFetch([root1]).length, 7);
      List<DemoMenuItem> list = DemoMenuItem.recursiveFetch([root1, root2]);
      expect(list.length, 14);
      expect(list[0].name, 'root1');
      expect(list[1].name, 'root1-a');
      expect(list[2].name, 'root1-a-a');
      expect(list[3].name, 'root1-b');
      expect(list[4].name, 'root1-b-a');
      expect(list[5].name, 'root1-b-b');
      expect(list[6].name, 'root1-b-b-a');
      expect(list[7].name, 'root2');
      expect(list[8].name, 'root2-a');
      expect(list[9].name, 'root2-a-a');
      expect(list[10].name, 'root2-a-a-a');
      expect(list[11].name, 'root2-b');
      expect(list[12].name, 'root2-c');
      expect(list[13].name, 'root2-c-a');
    });
    test('indentation', () {
      DemoMenuItem root = DemoMenuItem(name: '1', children: [
        DemoMenuItem(name: '2', children: [
          DemoMenuItem(name: '3', children: [DemoMenuItem(name: '4')])
        ])
      ]);
      List<DemoMenuItem> list = DemoMenuItem.recursiveFetch([root]);
      expect(list.length, 4);
      expect(list[0].name, '1');
      expect(list[0].indentation, 1);
      expect(list[1].name, '2');
      expect(list[1].indentation, 2);
      expect(list[2].name, '3');
      expect(list[2].indentation, 3);
      expect(list[3].name, '4');
      expect(list[3].indentation, 4);
    });
  });
}
