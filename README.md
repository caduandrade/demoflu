[![](https://img.shields.io/pub/v/demoflu.svg)](https://pub.dev/packages/demoflu)
[![](https://github.com/caduandrade/demoflu/actions/workflows/test.yml/badge.svg)](#)
[![](https://img.shields.io/badge/demo-try%20it%20out-blue)](https://caduandrade.github.io/demoflu_demo/)
[![](https://img.shields.io/badge/Flutter-%E2%9D%A4-red)](https://flutter.dev/)
[![](https://img.shields.io/badge/%F0%9F%91%8D%20and%20%E2%AD%90-are%20free%20and%20motivate%20me-yellow)](#)

# DemoFlu

Package demo builder. Web application to display package widgets usage.

![](https://caduandrade.github.io/demoflu/screenshot_1_v2.png)

## Tutorial

### main.dart

Use the `DemoFluApp` configuring menu and examples.

```dart
import 'package:demoflu/demoflu.dart';
import 'package:flutter/material.dart';
import 'package:tutorial/examples/stateless.dart';

void main() {
  runApp(DemoFluApp(title: 'Tutorial', menuItems: [
    DemoMenuItem(name: 'Section'),
    DemoMenuItem(name: 'Stateless', example: StatelessExample(), indent: 2)
  ]));
}
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
            codeFile: 'lib/examples/stateless.dart',
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
flutter build web --release
```

> Use `--base-href` if necessary

### Need more?

See the committed example for more details.