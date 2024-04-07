import 'package:demoflu/src/internal/model.dart';
import 'package:demoflu/src/internal/provider.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

/// Settings widget
@internal
@deprecated
class SettingsWidget extends StatelessWidget {
  const SettingsWidget({Key? key, required this.onClose}) : super(key: key);

  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      SliverFillRemaining(
          hasScrollBody: false,
          child: Container(
              color: Colors.white,
              padding: EdgeInsets.all(16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('Settings',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Container(
                        padding: EdgeInsets.fromLTRB(0, 16, 0, 2),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(width: 1, color: Colors.grey))),
                        child: Text('Example background',
                            style: TextStyle(fontSize: 14))),
                    _colorPicker(context),
                    Expanded(child: Container()),
                    Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                            child: Text('Back'), onPressed: onClose))
                  ])))
    ]);
  }

  Widget _colorPicker(BuildContext context) {
    DemoFluModel model = DemoFluProvider.modelOf(context);
    return ColorPicker(
      color: model.exampleBackground,
      onColorChanged: (Color color) => model.exampleBackground = color,
      width: 40,
      height: 40,
      borderRadius: 4,
      spacing: 5,
      runSpacing: 5,
      wheelDiameter: 155,
      heading: Text(
        'Select color',
        style: Theme.of(context).textTheme.titleSmall,
      ),
      subheading: Text(
        'Select color shade',
        style: Theme.of(context).textTheme.titleSmall,
      ),
      wheelSubheading: Text(
        'Selected color and its shades',
        style: Theme.of(context).textTheme.titleSmall,
      ),
      showMaterialName: false,
      showColorName: false,
      showColorCode: false,
      borderColor: Colors.grey,
      hasBorder: true,
      materialNameTextStyle: Theme.of(context).textTheme.bodySmall,
      colorNameTextStyle: Theme.of(context).textTheme.bodySmall,
      colorCodeTextStyle: Theme.of(context).textTheme.bodySmall,
      pickersEnabled: const <ColorPickerType, bool>{
        ColorPickerType.both: false,
        ColorPickerType.primary: true,
        ColorPickerType.accent: false,
        ColorPickerType.bw: true,
        ColorPickerType.custom: false,
        ColorPickerType.wheel: false,
      },
    );
  }
}
