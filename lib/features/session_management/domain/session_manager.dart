import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traguard/shared/providers/connected_devices.dart';
import 'session_state.dart';

/// Manages recording state for each connected device.
class SessionManager extends StateNotifier<SessionState> {
  SessionManager(this.ref) : super(SessionState()) {
    ref.listen(
      connectedDevicesProvider,
      (_, __) => _initialize(),
      fireImmediately: true,
    );
  }

  final Ref ref;

  void _initialize() {
    final devices = ref.read(connectedDevicesProvider).devices;
    final players = devices
        .map((d) => PlayerSession(device: d))
        .toList(growable: false);
    state = state.copyWith(players: players);
  }

  /// Toggles recording for the given [device].
  void toggle(BluetoothDevice device) {
    final updated = state.players
        .map((p) {
          if (p.device.remoteId == device.remoteId) {
            p.isRecording = !p.isRecording;
          }
          return p;
        })
        .toList(growable: false);
    state = state.copyWith(players: updated);
  }

  /// Stops recording for all players.
  void stopAll() {
    final updated = state.players
        .map((p) => p..isRecording = false)
        .toList(growable: false);
    state = state.copyWith(players: updated);
  }
}

/// Provider for the [SessionManager].
final sessionManagerProvider =
    StateNotifierProvider<SessionManager, SessionState>((ref) {
      return SessionManager(ref);
    });
