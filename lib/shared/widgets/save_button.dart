import 'package:flutter/material.dart';
import 'package:traguard/shared/utils/extensions.dart';
import 'package:traguard/shared/utils/sizes.dart';

/// A widget that represents a save button.
/// It can be used to save data or perform any other action.
class SaveButton extends StatelessWidget {
  /// Creates a new instance of [SaveButton].
  const SaveButton({
    super.key,
    this.onPressed,
    this.isSaving = false,
    this.canSave = true,
  });

  /// The bool flag that indicates whether the button is in a saving state.
  final bool isSaving;

  /// The bool flag that indicates whether the button can be pressed.
  final bool canSave;

  /// The callback function to be executed when the button is pressed.
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: canSave ? onPressed : null,
      child: Padding(
        padding: Paddings.largeHorizontal,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isSaving) ...[
              const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator.adaptive(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
              Spaces.medium.sizedBoxWidth,
            ],
            Text(context.l10n.save),
          ],
        ),
      ),
    );
  }
}
