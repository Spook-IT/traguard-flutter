import 'dart:math';

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

  /// Retrieves the device's shortest side (width or height).
  double get shortestSide => MediaQuery.sizeOf(this).shortestSide;

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

/// Extension to provide utility methods for creating `EdgeInsets`
extension PaddingExtensionNum on num {
  /// Converts the number to a `EdgeInsets` object with the same value
  /// for all sides.
  EdgeInsets get paddingAll => EdgeInsets.all(toDouble());

  /// Converts the number to a `EdgeInsets` object with the same value
  /// for vertical sides (top and bottom).
  EdgeInsets get paddingVertical => EdgeInsets.symmetric(vertical: toDouble());

  /// Converts the number to a `EdgeInsets` object with the same value
  /// for horizontal sides (left and right).
  EdgeInsets get paddingHorizontal =>
      EdgeInsets.symmetric(horizontal: toDouble());

  /// Converts the number to a `EdgeInsets` object with the top value
  /// set to the number and the other sides set to 0.
  EdgeInsets get paddingTop => EdgeInsets.only(top: toDouble());

  /// Converts the number to a `EdgeInsets` object with the bottom value
  /// set to the number and the other sides set to 0.
  EdgeInsets get paddingBottom => EdgeInsets.only(bottom: toDouble());

  /// Converts the number to a `EdgeInsets` object with the left value
  /// set to the number and the other sides set to 0.
  EdgeInsets get paddingLeft => EdgeInsets.only(left: toDouble());

  /// Converts the number to a `EdgeInsets` object with the right value
  /// set to the number and the other sides set to 0.
  EdgeInsets get paddingRight => EdgeInsets.only(right: toDouble());
}

/// Extension to provide utility methods for creating `SizedBox`
extension SizedBoxExtensionNum on num {
  /// Creates a `SizedBox` with the specified width and height.
  SizedBox get sizedBox => SizedBox(width: toDouble(), height: toDouble());

  /// Creates a `SizedBox` with the specified width.
  SizedBox get sizedBoxWidth => SizedBox(width: toDouble());

  /// Creates a `SizedBox` with the specified height.
  SizedBox get sizedBoxHeight => SizedBox(height: toDouble());
}

/// Extension to provide utility methods for creating `RegExp` objects
/// and validating matches.
extension RegexExtension on String {
  /// Creates a `RegExp` to validate an email address.
  bool get isValidEmail =>
      RegExp(r'^[\w-\.+]+@([\w-]+\.)+[\w-]{2,6}$').hasMatch(this);
}

/// Extension to provide utility methods for formatting numbers
/// and converting them to strings with specified precision.
extension FormatExtension on num {
  /// Parses the number from a string and returns it as a double.
  double toPrecision(int n) => double.parse(toStringAsFixed(n));

  /// Converts the number to a string with the specified precision.
  String toFormattedPrecision(int n) {
    final value = toPrecision(n);
    final intValue = value.toInt();
    if (value == intValue) {
      return intValue.toString();
    }

    var formattedValue = value.toStringAsFixed(n);
    while (formattedValue.endsWith('0')) {
      formattedValue = formattedValue.substring(0, formattedValue.length - 1);
    }

    return formattedValue;
  }
}

extension RandomString on String {
  static String generateRandomString() {
    const chars =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    final rnd = Random.secure();
    return String.fromCharCodes(
      Iterable.generate(21, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))),
    );
  }
}
