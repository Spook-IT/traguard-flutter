import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

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

/* 
 * ----------------
 *      THEME
 * ----------------
 */

/// The light theme for the application.
final lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6B5CC9)),
  brightness: Brightness.light,
  scaffoldBackgroundColor: const Color(0xFFF9FAFB),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    foregroundColor: Color(0xFF020817),
    elevation: 0,
  ),
);
