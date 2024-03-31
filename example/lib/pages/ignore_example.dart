import 'package:flutter/material.dart';

//@demoflu_ignore_start
class ClassToBeIgnored {}
//@demoflu_ignore_end

// Only this class is visible.
class IgnoreExample extends StatelessWidget {
  const IgnoreExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Padding(
            padding: EdgeInsets.all(32),
            child: Text('Demoflu code has been ignored')));
  }
}
