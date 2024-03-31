[![](https://img.shields.io/pub/v/demoflu.svg)](https://pub.dev/packages/demoflu)
[![](https://img.shields.io/badge/demo-try%20it%20out-blue)](https://caduandrade.github.io/demoflu_demo/)
[![](https://img.shields.io/badge/Flutter-%E2%9D%A4-red)](https://flutter.dev/)
[![](https://img.shields.io/badge/%F0%9F%91%8D%20and%20%E2%AD%90-are%20free%20and%20motivate%20me-yellow)](#)

# DemoFlu

Package demo builder. Web application to display package widgets usage.

![](https://caduandrade.github.io/demoflu/screenshot_1_v3.png)

## Tutorial

### main.dart

Use the `DemoFluApp` to configure the menu.

```dart
import 'package:demoflu/demoflu.dart';
import 'package:flutter/material.dart';
import 'package:tutorial/examples/stateless_example.dart';

void main() {
  runApp(DemoFluApp(title: 'Tutorial', rootMenus: [_firstExample, _section]));
}

DemoMenuItem get _firstExample =>
    DemoMenuItem('First', example: StatelessExample());

DemoMenuItem get _section =>
    DemoMenuItem('Section', children: [_secondExample]);

DemoMenuItem get _secondExample =>
    DemoMenuItem('Second', example: StatelessExample());
```

### Examples

Create examples using your package.

```dart
import 'package:demoflu/demoflu.dart';
import 'package:flutter/material.dart';

class StatelessExample extends Example {
  StatelessExample()
      : super(
            widget: const MainWidget(),
            codeFile: 'lib/examples/stateless_example.dart',
            resizable: true);
}

class MainWidget extends StatelessWidget {
  const MainWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.blue[200], child: const Center(child: Text('Stateless')));
  }
}
```

### pubspec.yaml

Configure the assets to make the source code available.

```yaml
  assets:
    - lib/examples/
```

### Build for web

```
flutter clean
flutter build web --release
```

> Use `--base-href` if necessary

### Need more?

See the committed example for more details.