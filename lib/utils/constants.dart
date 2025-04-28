import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

/// A logger instance for logging messages.
final logger = Logger(printer: PrettyPrinter());

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
