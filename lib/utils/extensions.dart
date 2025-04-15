import 'package:flutter/material.dart';
import 'package:traguard/l10n/gen_l10n/app_localizations.dart';

/// Extension to provide localization utilities for `BuildContext`.
extension LocalizationExtension on BuildContext {
  /// Retrieves the `AppLocalizations` instance for the current `BuildContext`.
  AppLocalizations get l10n => AppLocalizations.of(this);
}

/// Extension to provide utility methods for `BuildContext` related to theme,
/// media query, and device properties.
extension BuildContextUtilsExtension on BuildContext {
  /// Retrieves the `ThemeData` for the current `BuildContext`.
  ThemeData get theme => Theme.of(this);

  /// Retrieves the `TextTheme` from the current theme.
  TextTheme get textTheme => theme.textTheme;

  /// Retrieves the `ColorScheme` from the current theme.
  ColorScheme get colorScheme => theme.colorScheme;

  /// Retrieves the `MediaQueryData` for the current `BuildContext`.
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// Retrieves the screen width of the current device.
  double get screenWidth => MediaQuery.sizeOf(this).width;

  /// Retrieves the screen height of the current device.
  double get screenHeight => MediaQuery.sizeOf(this).height;

  /// Retrieves the device's pixel ratio (scale factor).
  double get scaleFactor => mediaQuery.devicePixelRatio;

  /// Checks if the device is in portrait orientation.
  bool get isPortrait => MediaQuery.orientationOf(this) == Orientation.portrait;

  /// Checks if the device is in landscape orientation.
  bool get isLandscape =>
      MediaQuery.orientationOf(this) == Orientation.landscape;

  /// Checks if the current theme is in dark mode.
  bool get isDarkMode => theme.brightness == Brightness.dark;

  /// Checks if the current theme is in light mode.
  bool get isLightMode => theme.brightness == Brightness.light;
}

/// Extension to provide utility methods for `ThemeData`
/// to access common colors.
extension ThemeDataUtilsExtension on ThemeData {
  /// Retrieves the primary color from the `ColorScheme`.
  Color get primaryColor => colorScheme.primary;

  /// Retrieves the secondary color from the `ColorScheme`.
  Color get secondaryColor => colorScheme.secondary;

  /// Retrieves the error color from the `ColorScheme`.
  Color get errorColor => colorScheme.error;

  /// Retrieves the surface color from the `ColorScheme`.
  Color get surfaceColor => colorScheme.surface;

  /// Retrieves the on-primary color from the `ColorScheme`.
  Color get onPrimaryColor => colorScheme.onPrimary;

  /// Retrieves the on-secondary color from the `ColorScheme`.
  Color get onSecondaryColor => colorScheme.onSecondary;

  /// Retrieves the on-error color from the `ColorScheme`.
  Color get onErrorColor => colorScheme.onError;

  /// Retrieves the on-surface color from the `ColorScheme`.
  Color get onSurfaceColor => colorScheme.onSurface;
}

/// Extension to provide utility methods for creating `Duration` objects
/// from numeric values.
extension DurationExtensions on num {
  /// Converts the number to a `Duration` in microseconds.
  Duration get microseconds => Duration(microseconds: round());

  /// Converts the number to a `Duration` in milliseconds.
  Duration get ms => (this * 1000).microseconds;

  /// Converts the number to a `Duration` in seconds.
  Duration get seconds => (this * 1000 * 1000).microseconds;

  /// Converts the number to a `Duration` in minutes.
  Duration get minutes => (this * 1000 * 1000 * 60).microseconds;

  /// Converts the number to a `Duration` in hours.
  Duration get hours => (this * 1000 * 1000 * 60 * 60).microseconds;

  /// Converts the number to a `Duration` in days.
  Duration get days => (this * 1000 * 1000 * 60 * 60 * 24).microseconds;
}
