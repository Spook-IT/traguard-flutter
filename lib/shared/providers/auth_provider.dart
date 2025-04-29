import 'dart:async';
import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:traguard/shared/models/user.dart';
import 'package:traguard/shared/utils/constants.dart';

part 'auth_provider.g.dart';

/// A Riverpod provider class that manages the authentication state of the user.
///
/// This class extends the generated `_$Auth` class and overrides the `build`
/// method to initialize the authentication state. By default, it returns a
/// `User.signedOut()` instance, indicating that the user is not signed in.
@riverpod
class Auth extends _$Auth {
  static const String _loggerKey = '[AuthProvider]: ';
  static const String _sharedPrefsKey = 'user';

  @override
  FutureOr<User> build() async {
    unawaited(_observeUserState());
    return _setupFromSharedPrefs();
  }

  /*
  * ----------------
  * PUBLIC METHODS
  * ----------------
  */

  /// Signs in the user with [email] and [password].
  Future<void> signIn({required String email, required String password}) async {
    try {
      // Simulate a network call
      await Future<void>.delayed(const Duration(seconds: 1));

      // Simulate a successful sign-in
      final user = User.signedIn(
        id: '123',
        name: 'John',
        surname: 'Doe',
        email: email,
      );

      state = AsyncData(user);
    } on Exception catch (e, stack) {
      state = AsyncError(e, stack);
    }
  }

  /// Signs out the user.
  void signOut() {
    state = const AsyncData(User.signedOut());
  }

  /*
  * ----------------
  * PRIVATE METHODS
  * ----------------
  */

  Future<User> _setupFromSharedPrefs() async {
    try {
      final prefs = await SharedPreferencesWithCache.create(
        cacheOptions: const SharedPreferencesWithCacheOptions(),
      );

      final userString = prefs.getString(_sharedPrefsKey);

      if (userString == null) {
        return const User.signedOut();
      }

      final userMap = jsonDecode(userString) as Map<String, dynamic>;
      final user = User.fromJson(userMap);

      return user;
    } on Exception catch (e) {
      logger.e(_loggerKey + e.toString());
      return const User.signedOut();
    }
  }

  Future<void> _observeUserState() async {
    listenSelf((_, next) async {
      if (next.isLoading || next.hasError) return;

      final user = next.requireValue;
      logger.i(_loggerKey + user.toString());
      if (user is UserEmpty) {
        return;
      }

      final prefs = await SharedPreferencesWithCache.create(
        cacheOptions: const SharedPreferencesWithCacheOptions(),
      );

      switch (user) {
        case SignedIn():
          await prefs.setString(_sharedPrefsKey, jsonEncode(user.toJson()));
        case SignedOut():
          await prefs.clear();
        case UserEmpty():
          break;
      }
    });
  }
}
