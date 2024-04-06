import 'package:flutter/material.dart';

//@demoflu_start:ignore
class ClassToBeIgnored {}
//@demoflu_end:ignore

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  //@demoflu_start:show
  @override
  Widget build(BuildContext context) {
    return const Text('Hello');
  }
  //@demoflu_end:show
}
