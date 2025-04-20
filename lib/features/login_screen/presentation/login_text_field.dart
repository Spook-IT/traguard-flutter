import 'package:flutter/material.dart';
import 'package:traguard/utils/sizes.dart';

/// A widget that represents a text field for login.
class LoginTextField extends StatefulWidget {
  /// Creates a new instance of [LoginTextField].
  const LoginTextField({
    required this.label,
    required this.validator,
    required this.controller,
    this.isPassword = false,
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
        decoration: InputDecoration(
          labelText: widget.label,
          labelStyle: const TextStyle(color: Colors.black),
          floatingLabelAlignment: FloatingLabelAlignment.start,
          floatingLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(99)),
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
