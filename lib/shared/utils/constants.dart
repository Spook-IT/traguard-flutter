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

/// The color scheme for the dark theme, using a neon cyan seed color.
final _darkColorScheme = ColorScheme.fromSeed(
  seedColor: const Color(0xFF00FFFF),
  brightness: Brightness.dark,
);

/// A dark theme with neon cyan accents and soft shadows.
final darkTheme = ThemeData(
  colorScheme: _darkColorScheme,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFF0C1116),
  shadowColor: const Color(0x8000FFFF),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF13181F),
    foregroundColor: Colors.white,
    elevation: 0,
    shadowColor: Color(0x8000FFFF),
  ),
  cardColor: const Color(0xFF13181F),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFF13181F),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: Color(0xFF00FFFF)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: Color(0xFF33FFFF)),
    ),
  ),
  dropdownMenuTheme: DropdownMenuThemeData(
    menuStyle: MenuStyle(
      backgroundColor: WidgetStateProperty.resolveWith((state) {
        if (state.contains(WidgetState.disabled)) {
          return const Color(0xFF1A1F28);
        }
        return const Color(0xFF13181F);
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
      fillColor: const Color(0xFF13181F),
      contentPadding: Paddings.mediumHorizontal + Paddings.smallVertical,
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        borderSide: BorderSide(color: Color(0xFF00FFFF)),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        borderSide: BorderSide(color: Color(0xFF33FFFF)),
      ),
    ),
  ),
);
