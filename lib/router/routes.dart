import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:traguard/features/bluetooth_connection/presentation/bluetooth_list_screen.dart';
import 'package:traguard/features/dashboard_screen/presentation/dashboard_screen.dart';
import 'package:traguard/features/login_screen/presentation/login_screen.dart';
import 'package:traguard/features/splash_screen/presentation/splash_screen.dart';

part 'routes.g.dart';

/// A route class for the Splash screen.
///
/// This class extends `GoRouteData` and is responsible for building
/// the `SplashScreen` widget when the route is accessed.
@TypedGoRoute<SplashRoute>(path: '/splash', name: 'splashRoute')
class SplashRoute extends GoRouteData {
  /// Creates a new instance of [SplashRoute].
  const SplashRoute();

  @override
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) async {
    // TODO(dariowskii): Implement a proper authentication check
    return const LoginRoute().location;
  }

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SplashScreen();
  }
}

/// A route class for the Bluetooth List screen.
///
/// This class extends `GoRouteData` and is responsible for building
/// the `BluetoothListScreen` widget when the route is accessed.
@TypedGoRoute<BluetoothListRoute>(
  path: '/bluetooth-list',
  name: 'bluetoothListRoute',
)
class BluetoothListRoute extends GoRouteData {
  /// Creates a new instance of [BluetoothListRoute].
  const BluetoothListRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const BluetoothListScreen();
  }
}

/// A route class for the Login screen.
///
/// This class extends `GoRouteData` and is responsible for building
/// the `LoginScreen` widget when the route is accessed.
@TypedGoRoute<LoginRoute>(path: '/login', name: 'loginRoute')
class LoginRoute extends GoRouteData {
  /// Creates a new instance of [LoginRoute].
  const LoginRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const LoginScreen();
  }
}

/// A route class for the Dashboard screen.
///
/// This class extends `GoRouteData` and is responsible for building
/// the `DashboardScreen` widget when the route is accessed.
@TypedGoRoute<DashboardRoute>(path: '/', name: 'dashboardRoute')
class DashboardRoute extends GoRouteData {
  /// Creates a new instance of [DashboardRoute].
  const DashboardRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DashboardScreen();
  }
}
