import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:traguard/features/bluetooth_connection/presentation/bluetooth_list_screen.dart';
import 'package:traguard/features/dashboard_screen/presentation/dashboard_screen.dart';
import 'package:traguard/features/login_screen/presentation/login_screen.dart';
import 'package:traguard/features/player_list_screen/presentation/player_list_screen.dart';
import 'package:traguard/features/settings_screen/presentation/settings_screen.dart';
import 'package:traguard/features/splash_screen/presentation/splash_screen.dart';
import 'package:traguard/features/team_statistics_screen/presentation/team_statistics_screen.dart';
import 'package:traguard/shared/models/user.dart';
import 'package:traguard/shared/providers/auth_provider.dart';

part 'routes.g.dart';

/// A route class for the Splash screen.
///
/// This class extends [GoRouteData] and is responsible for building
/// the [SplashScreen] widget when the route is accessed.
@TypedGoRoute<SplashRoute>(path: '/splash', name: 'splashRoute')
class SplashRoute extends GoRouteData {
  /// Creates a new instance of [SplashRoute].
  const SplashRoute();

  @override
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) async {
    final container = ProviderScope.containerOf(context);
    final auth = container.read(authProvider);
    return auth.moveFromSplash();
  }

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SplashScreen();
  }
}

/// A route class for the Login screen.
///
/// This class extends [GoRouteData] and is responsible for building
/// the [LoginScreen] widget when the route is accessed.
@TypedGoRoute<LoginRoute>(path: '/login', name: 'loginRoute')
class LoginRoute extends GoRouteData {
  /// Creates a new instance of [LoginRoute].
  const LoginRoute();

  @override
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) async {
    final container = ProviderScope.containerOf(context);
    final auth = container.read(authProvider);
    return auth.redirectToHomeIfNeeded();
  }

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const LoginScreen();
  }
}

/// A route class for the Dashboard screen.
///
/// This class extends [GoRouteData] and is responsible for building
/// the [DashboardScreen] widget when the route is accessed.
@TypedGoRoute<DashboardRoute>(
  path: '/',
  name: 'dashboardRoute',
  routes: [
    TypedGoRoute<BluetoothListRoute>(
      path: 'bluetooth-list',
      name: 'bluetoothListRoute',
    ),
    TypedGoRoute<TeamStatisticsRoute>(
      path: 'team-statistics',
      name: 'teamStatisticsRoute',
    ),
    TypedGoRoute<SettingsRoute>(path: 'settings', name: 'settingsRoute'),
    TypedGoRoute<PlayerListRoute>(path: 'player-list', name: 'playerListRoute'),
  ],
)
class DashboardRoute extends GoRouteData {
  /// Creates a new instance of [DashboardRoute].
  const DashboardRoute();

  @override
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) async {
    final container = ProviderScope.containerOf(context);
    final auth = container.read(authProvider);
    return auth.redirectToLoginIfNeeded();
  }

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DashboardScreen();
  }
}

/// A route class for the Bluetooth List screen.
///
/// This class extends [GoRouteData] and is responsible for building
/// the [BluetoothListScreen] widget when the route is accessed.
class BluetoothListRoute extends GoRouteData {
  /// Creates a new instance of [BluetoothListRoute].
  const BluetoothListRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const BluetoothListScreen();
  }
}

/// A route class for the Team Statistics screen.
///
/// This class extends [GoRouteData] and is responsible for building
/// the [TeamStatisticsScreen] widget when the route is accessed.
class TeamStatisticsRoute extends GoRouteData {
  /// Creates a new instance of [TeamStatisticsRoute].
  const TeamStatisticsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const TeamStatisticsScreen();
  }
}

/// A route class for the Settings screen.
///
/// This class extends [GoRouteData] and is responsible for building
/// the [SettingsScreen] widget when the route is accessed.
class SettingsRoute extends GoRouteData {
  /// Creates a new instance of [SettingsRoute].
  const SettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SettingsScreen();
  }
}

/// A route class for the Player List screen.
///
/// This class extends [GoRouteData] and is responsible for building
/// the [PlayerListScreen] widget when the route is accessed.
class PlayerListRoute extends GoRouteData {
  /// Creates a new instance of [PlayerListRoute].
  const PlayerListRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const PlayerListScreen();
  }
}
