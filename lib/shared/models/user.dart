import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:traguard/shared/router/routes.dart';

part 'user.freezed.dart';
part 'user.g.dart';

/// A sealed class representing a user, which can either be
/// signed in or signed out.
///
/// This class uses the `freezed` package to generate immutable data classes and
/// pattern matching capabilities. It provides two states:
/// - `SignedIn`: Represents a user who is signed in, with optional user details
/// - `SignedOut`: Represents a user who is signed out.
@freezed
sealed class User with _$User {
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  const User._();

  const factory User.signedIn({
    String? id,
    String? name,
    String? surname,
    String? email,
    String? role,
  }) = SignedIn;

  const factory User.signedOut() = SignedOut;

  const factory User.empty() = UserEmpty;

  /// A method to check if the user is authenticated.
  bool get isAuth => switch (this) {
    SignedIn() => true,
    _ => false,
  };

  /// Compose the full name of the user.
  String get fullName => switch (this) {
    SignedIn(name: final name, surname: final surname) => '$name $surname',
    _ => '',
  };
}

/// This extension provides utility methods for the `AsyncValue<User>` type.
extension AsyncValueUser on AsyncValue<User> {
  /// This method checks if the user is authenticated.
  /// It returns [DashboardRoute] if the user is signed in,
  /// otherwise it returns to [LoginRoute].
  String? moveFromSplash() {
    if (value is SignedIn) {
      return const DashboardRoute().location;
    }

    if (value is SignedOut) {
      return const LoginRoute().location;
    }

    return null;
  }

  /// This method checks if the user is signed in.
  /// If the user is signed in, it returns [DashboardRoute],
  /// otherwise it returns `null`.
  String? redirectToHomeIfNeeded() {
    if (value is SignedIn) {
      return const DashboardRoute().location;
    }

    return null;
  }

  /// This method checks if the user is signed out.
  /// If the user is signed out, it returns [LoginRoute],
  /// otherwise it returns `null`.
  String? redirectToLoginIfNeeded() {
    if (value is SignedIn) {
      return null;
    }

    return const LoginRoute().location;
  }
}
