//@demoflu_ignore_start
import 'package:demoflu/demoflu.dart';
//@demoflu_ignore_end
// Only this import is visible.
import 'package:flutter/material.dart';

//@demoflu_ignore_start
class IgnoreExample extends Example {
  IgnoreExample()
      : super(codeFile: 'lib/examples/ignore.dart', widget: const MainWidget());
}
//@demoflu_ignore_end
// Demoflu code has been ignored.

// Only this class is visible.
class MainWidget extends StatelessWidget {
  const MainWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Demoflu code has been ignored'));
  }
}
