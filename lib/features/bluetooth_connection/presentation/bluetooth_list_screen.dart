import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:traguard/features/bluetooth_connection/data/bluetooth_finder.dart';
import 'package:traguard/features/bluetooth_connection/domain/bluetooth_finder_state.dart';
import 'package:traguard/features/bluetooth_connection/presentation/bluetooth_not_supported.dart';
import 'package:traguard/features/bluetooth_connection/presentation/bluetooth_off.dart';
import 'package:traguard/features/bluetooth_connection/presentation/device_list.dart';
import 'package:traguard/features/session_management/domain/session_manager.dart';
import 'package:traguard/shared/providers/auth_provider.dart';
import 'package:traguard/shared/router/routes.dart';
import 'package:traguard/shared/utils/extensions.dart';
import 'package:traguard/shared/utils/sizes.dart';

/// A screen that displays a list of Bluetooth devices.
class BluetoothListScreen extends ConsumerWidget {
  /// Creates a new instance of [BluetoothListScreen].
  const BluetoothListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bluetoothFinderState = ref.watch(bluetoothFinderProvider).screenState;
    final child = switch (bluetoothFinderState) {
      BluetoothScreenState.bluetoothOff => const BluetoothOff(),
      BluetoothScreenState.initial ||
      BluetoothScreenState.searching => const DeviceList(),
      BluetoothScreenState.notSupported => const BluetoothNotSupported(),
    };

    final sessionState = ref.watch(sessionManagerProvider);
    final hasActiveSession =
        sessionState.players.any((p) => p.isRecording);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.bluetoothDeviceList),
        actions: [
          IconButton(
            tooltip: context.l10n.logout,
            onPressed: () =>
                ref.read(authProvider.notifier).signOut(),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SafeArea(child: child),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Stack(
        children: [
          FloatingActionButton(
            onPressed: () =>
                const SessionManagementRoute().go(context),
            child:
                Icon(hasActiveSession ? Icons.play_arrow : Icons.add),
          ),
          if (hasActiveSession)
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: context.colorScheme.error,
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: Spaces.small,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              tooltip: 'Giocatori',
              icon: const Icon(Icons.people),
              onPressed: () => const PlayerListRoute().go(context),
            ),
            IconButton(
              tooltip: 'Dispositivi',
              icon: const Icon(Icons.devices),
              onPressed: () => const BluetoothListRoute().go(context),
            ),
            const SizedBox(width: 48),
            IconButton(
              tooltip: 'Statistiche',
              icon: const Icon(Icons.bar_chart),
              onPressed: () => const TeamStatisticsRoute().go(context),
            ),
            IconButton(
              tooltip: 'Dati Fiscali',
              icon: const Icon(Icons.receipt_long),
              onPressed: () => const FiscalDataRoute().go(context),
            ),
          ],
        ),
      ),
    );
  }
}
