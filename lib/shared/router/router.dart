import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:traguard/shared/providers/auth_provider.dart';
import 'package:traguard/shared/router/routes.dart';

part 'router.g.dart';

/*
 * ----------------
 *      ROUTER
 * ----------------
 */

/// A global key used to uniquely identify the navigator state for the router.
///
/// This key can be used to access the navigator state, enabling navigation
/// operations such as pushing or popping routes outside of the widget tree.
///
/// The `debugLabel` is set to 'routerKey' to help identify this key during
/// debugging.
final routerKey = GlobalKey<NavigatorState>(debugLabel: 'routerKey');

/// A Riverpod provider that creates and manages the `GoRouter` instance.
@riverpod
Raw<GoRouter> router(Ref ref) {
  final initState = ValueNotifier<AsyncValue<bool>>(const AsyncLoading());

  ref.listen(
    authProvider.select((value) => value.whenData((value) => value.isAuth)),
    (_, next) {
      initState.value = next;
    },
    fireImmediately: true,
  );

  final router = GoRouter(
    navigatorKey: routerKey,
    refreshListenable: initState,
    initialLocation: const SplashRoute().location,
    debugLogDiagnostics: true,
    routes: $appRoutes,
  );

  ref
    ..onDispose(initState.dispose)
    ..onDispose(router.dispose);

  return router;
}
