import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:traguard/shared/utils/extensions.dart' hide DurationExtensions;
import 'package:traguard/shared/utils/sizes.dart';
import 'package:traguard/shared/widgets/save_button.dart';

/// This widget represents a form for updating legal data.
/// It includes fields for the user's name, email, and phone number.
/// It also includes a save button that is enabled when all fields are valid.
class UpdateLegalForm extends StatelessWidget {
  /// Creates a new instance of [UpdateLegalForm].
  const UpdateLegalForm({
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.isSaving,
    required this.canSave,
    required this.onSave,
    super.key,
  });

  /// The key used to identify the form.
  final GlobalKey<FormState> formKey;

  /// The controller for the name field.
  final TextEditingController nameController;

  /// The controller for the email field.
  final TextEditingController emailController;

  /// The controller for the phone number field.
  final TextEditingController phoneController;

  /// The boolean flag that indicates whether the form is currently saving.
  final bool isSaving;

  /// The boolean flag that indicates whether the form can be saved.
  final bool canSave;

  /// The callback function to be executed when the save button is pressed.
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final delay = 100.ms;
    final moveYDuration = 300.ms;
    const moveYCurve = Curves.decelerate;
    const moveYBegin = 20.0;
    const moveYEnd = 0.0;

    return SliverFillRemaining(
      hasScrollBody: false,
      child: Form(
        key: formKey,
        child: Padding(
          padding: Paddings.mediumAll,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: Spaces.small,
            children: [
              TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    autofillHints: const [
                      AutofillHints.name,
                      AutofillHints.familyName,
                    ],
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return l10n.nameAndSurnameValidator;
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: '${l10n.nameAndSurname}*',
                    ),
                    onTapOutside: (event) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                  )
                  .animate()
                  .moveY(
                    duration: moveYDuration,
                    begin: moveYBegin,
                    end: moveYEnd,
                    curve: moveYCurve,
                  )
                  .fadeIn(),
              TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    autofillHints: const [AutofillHints.email],
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return context.l10n.emailEmpty;
                      }

                      if (!value.isValidEmail) {
                        return context.l10n.emailInvalid;
                      }

                      return null;
                    },
                    decoration: InputDecoration(labelText: '${l10n.email}*'),
                    onTapOutside: (event) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                  )
                  .animate(delay: delay)
                  .moveY(
                    duration: moveYDuration,
                    begin: moveYBegin,
                    end: moveYEnd,
                    curve: moveYCurve,
                  )
                  .fadeIn(),
              TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    autofillHints: const [AutofillHints.telephoneNumber],
                    textInputAction: TextInputAction.done,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'^\+?[0-9]*$'),
                        replacementString: phoneController.text,
                      ),
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return l10n.phoneEmpty;
                      }

                      return null;
                    },
                    decoration: InputDecoration(labelText: '${l10n.phone}*'),
                    onTapOutside: (event) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                  )
                  .animate(delay: delay * 2)
                  .moveY(
                    duration: moveYDuration,
                    begin: moveYBegin,
                    end: moveYEnd,
                    curve: moveYCurve,
                  )
                  .fadeIn(),
              const Spacer(),
              SafeArea(
                child: SaveButton(
                      isSaving: isSaving,
                      canSave: canSave,
                      onPressed: onSave,
                    )
                    .animate(delay: delay * 3)
                    .moveY(
                      duration: 750.ms,
                      begin: 100,
                      end: moveYEnd,
                      curve: Curves.easeOutCubic,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
