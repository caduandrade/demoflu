import 'package:demoflu/src/demoflu_settings.dart';
import 'package:flutter/material.dart';

class SettingsButton extends StatelessWidget {
  const SettingsButton({Key? key, required this.settings}) : super(key: key);

  final DemoFluSettings settings;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => settings.settingsVisible = !settings.settingsVisible,
        icon: Icon(Icons.settings),
        tooltip: 'Settings');
  }
}
