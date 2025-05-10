import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:traguard/shared/utils/constants.dart';
import 'package:traguard/shared/utils/extensions.dart';

/// A widget that allows the user to pick a color
/// and displays the selected color.
/// It also provides a text field to input the color in hex format.
class ColorPickerPlayer extends StatefulWidget {
  /// Creates a [ColorPickerPlayer] widget.
  const ColorPickerPlayer({required this.onColorChanged, super.key});

  /// Callback function that is called when the color is changed.
  final void Function(Color color) onColorChanged;

  @override
  State<ColorPickerPlayer> createState() => _ColorPickerPlayerState();
}

class _ColorPickerPlayerState extends State<ColorPickerPlayer> {
  Color _selectedColor = chartColors.first;
  late final _colorController = TextEditingController(
    text:
        _selectedColor.toARGB32().toRadixString(16).substring(2).toUpperCase(),
  );

  @override
  void dispose() {
    _colorController.dispose();
    super.dispose();
  }

  Future<void> _pickColor() async {
    final newColor =
        await showDialog<Color>(
          context: context,
          builder:
              (context) => AlertDialog(
                title: const Text('Pick a Color'),
                content: SingleChildScrollView(
                  child: BlockPicker(
                    pickerColor: _selectedColor,
                    availableColors: chartColors,
                    onColorChanged: (color) {
                      Navigator.of(context).pop(color);
                    },
                  ),
                ),
              ),
        ) ??
        _selectedColor;

    _updateColor(
      newColor: newColor,
      hexColor: newColor.toARGB32().toRadixString(16).substring(2),
    );
  }

  void _setHexColor(String hexColor) {
    setState(() {
      _colorController.text = hexColor.toUpperCase();
    });

    try {
      final parsedHex = 'ff${hexColor.toLowerCase()}';

      if (!RegExp(r'^[0-9a-f]{2,8}$').hasMatch(parsedHex)) {
        throw Exception('Invalid hex color format');
      }

      final color = Color(int.parse(parsedHex, radix: 16));
      if (color != _selectedColor) {
        _updateColor(newColor: color, hexColor: hexColor);
      }
    } on Exception catch (e) {
      // Handle invalid hex color input
      logger.d('Invalid hex color: $e');
    }
  }

  void _updateColor({required Color newColor, required String hexColor}) {
    setState(() {
      _selectedColor = newColor;
      _colorController.text = hexColor.toUpperCase();
    });
    widget.onColorChanged(newColor);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: _pickColor,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: _selectedColor,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: TextField(
            controller: _colorController,
            onChanged: _setHexColor,
            decoration: InputDecoration(
              labelText: 'Selected Color',
              fillColor: Colors.white,
              filled: true,
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                borderSide: BorderSide(color: Colors.grey),
              ),
              prefix: Text(
                '#',
                style: context.textTheme.labelLarge?.copyWith(fontSize: 16),
              ),
            ),
            keyboardType: TextInputType.text,
            onTapOutside: (e) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'^[0-9a-fA-F]{0,6}$'),
                replacementString: _colorController.text,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
