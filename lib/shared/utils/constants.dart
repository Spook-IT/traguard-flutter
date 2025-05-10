import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:traguard/shared/utils/sizes.dart';

/// A logger instance for logging messages.
final logger = Logger(printer: PrettyPrinter());

/// A list of colors used for charts in the application.
final List<Color> chartColors = [
  Colors.red,
  Colors.blue,
  Colors.green,
  Colors.orange,
  Colors.purple,
  Colors.pink,
  Colors.teal,
  Colors.cyan,
  Colors.indigo,
  Colors.amber,
  Colors.brown,
  Colors.lightBlue,
  Colors.lightGreen,
  Colors.deepOrange,
  Colors.deepPurple,
  const Color(0xFF1B998B),
  const Color(0xFF3185FC),
  const Color(0xFFEF767A),
  const Color(0xFF7D5BA6),
  const Color(0xFF6A0572),
  const Color(0xFF0E79B2),
  const Color(0xFF17BEBB),
];

const disabledColor = Color.fromARGB(255, 220, 220, 220);

/* 
 * ----------------
 *      THEME
 * ----------------
 */

final _colorScheme = ColorScheme.fromSeed(seedColor: const Color(0xFF6B5CC9));

/// The light theme for the application.
final lightTheme = ThemeData(
  colorScheme: _colorScheme,
  brightness: Brightness.light,
  scaffoldBackgroundColor: const Color(0xFFF9FAFB),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    foregroundColor: Color(0xFF020817),
    elevation: 0,
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: _colorScheme.outline.withValues(alpha: .3)),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: _colorScheme.outline.withValues(alpha: .1)),
    ),
  ),
  dropdownMenuTheme: DropdownMenuThemeData(
    menuStyle: MenuStyle(
      backgroundColor: WidgetStateProperty.resolveWith((state) {
        if (state.contains(WidgetState.disabled)) {
          return disabledColor;
        }
        return Colors.white;
      }),
      shape: const WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
      maximumSize: const WidgetStatePropertyAll(Size.fromHeight(200)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: Paddings.mediumHorizontal + Paddings.smallVertical,
      border: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        borderSide: BorderSide(
          color: _colorScheme.outline.withValues(alpha: .3),
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        borderSide: BorderSide(
          color: _colorScheme.outline.withValues(alpha: .1),
        ),
      ),
    ),
  ),
);
