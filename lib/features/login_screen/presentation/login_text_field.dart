import 'package:flutter/material.dart';
import 'package:traguard/shared/utils/extensions.dart';
import 'package:traguard/shared/utils/sizes.dart';

/// A widget that represents a text field for login.
class LoginTextField extends StatefulWidget {
  /// Creates a new instance of [LoginTextField].
  const LoginTextField({
    required this.label,
    required this.validator,
    required this.controller,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.enabled = true,
    super.key,
  });

  /// The label for the text field.
  final String label;

  /// The callback function to be executed when the text field is submitted.
  final String? Function(String? value)? validator;

  /// Indicates whether the text field is for password input.
  final bool isPassword;

  /// The controller for the text field.
  final TextEditingController controller;

  /// The keyboard type for the text field.
  final TextInputType keyboardType;

  /// The action to be performed when the text field is submitted.
  final TextInputAction textInputAction;

  /// Indicates whether the text field is enabled.
  final bool enabled;

  @override
  State<LoginTextField> createState() => _LoginTextFieldState();
}

class _LoginTextFieldState extends State<LoginTextField> {
  late bool _isPasswordVisible = !widget.isPassword;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: TextFormField(
        controller: widget.controller,
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        enabled: widget.enabled,
        decoration: InputDecoration(
          labelText: widget.label,
          labelStyle: TextStyle(
            color: context.colorScheme.onSurface.withOpacity(.7),
          ),
          hintText: widget.label,
          hintStyle: TextStyle(
            color: context.colorScheme.onSurface.withOpacity(.5),
          ),
          floatingLabelAlignment: FloatingLabelAlignment.start,
          floatingLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
          contentPadding: Paddings.largeHorizontal,
          suffixIcon:
              widget.isPassword
                  ? IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  )
                  : null,
        ),
        obscureText: widget.isPassword && !_isPasswordVisible,
        validator: widget.validator,
      ),
    );
  }
}
