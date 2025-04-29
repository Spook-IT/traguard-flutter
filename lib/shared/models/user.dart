import 'package:freezed_annotation/freezed_annotation.dart';

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
  }) = SignedIn;

  const factory User.signedOut() = SignedOut;

  const factory User.empty() = UserEmpty;

  /// A method to check if the user is authenticated.
  bool get isAuth => switch (this) {
    SignedIn() => true,
    _ => false,
  };
}
