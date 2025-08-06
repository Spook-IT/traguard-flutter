import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'session_state.dart';

/// Manages recording state for each connected device.
class SessionManager extends StateNotifier<SessionState> {
  SessionManager() : super(SessionState());

  Timer? _pollTimer;
  Timer? _sendTimer;
  final Map<String, List<Map<String, double>>> _buffer = {};

  /// Starts a new session for [devices] with associated [names].
  void startSession(List<BluetoothDevice> devices, List<String> names) {
    final players = <PlayerSession>[];
    for (var i = 0; i < devices.length; i++) {
      players.add(PlayerSession(device: devices[i], playerName: names[i]));
    }
    state = state.copyWith(players: players, startTime: DateTime.now());

    _pollTimer?.cancel();
    _pollTimer = Timer.periodic(const Duration(milliseconds: 250), (_) {
      for (final p in state.players.where((e) => e.isRecording)) {
        final pos = {
          'lat': Random().nextDouble(),
          'lng': Random().nextDouble(),
        };
        _buffer.putIfAbsent(p.playerName, () => []).add(pos);
      }
    });

    _sendTimer?.cancel();
    _sendTimer = Timer.periodic(const Duration(seconds: 5), (_) async {
      if (_buffer.isEmpty) return;
      final data = Map<String, List<Map<String, double>>>.from(_buffer);
      _buffer.clear();
      try {
        await http.post(
          Uri.parse('https://httpbin.org/post'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(data),
        );
      } catch (_) {}
    });
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

  /// Stops recording for all players and sends stop event.
  Future<void> stopAll() async {
    _pollTimer?.cancel();
    _sendTimer?.cancel();
    final updated = state.players
        .map((p) => p..isRecording = false)
        .toList(growable: false);
    state = state.copyWith(players: updated, startTime: null);
    try {
      await http.post(Uri.parse('https://httpbin.org/post'), body: 'stop');
    } catch (_) {}
  }
}

/// Provider for the [SessionManager].
final sessionManagerProvider =
    StateNotifierProvider<SessionManager, SessionState>((ref) {
      return SessionManager();
    });
