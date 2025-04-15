import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:traguard/models/user.dart';

part 'auth_provider.g.dart';

/// A Riverpod provider class that manages the authentication state of the user.
///
/// This class extends the generated `_$Auth` class and overrides the `build`
/// method to initialize the authentication state. By default, it returns a
/// `User.signedOut()` instance, indicating that the user is not signed in.
@riverpod
class Auth extends _$Auth {
  @override
  FutureOr<User> build() async {
    return const User.signedOut();
  }
}
