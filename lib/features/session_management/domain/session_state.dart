import 'package:flutter_blue_plus/flutter_blue_plus.dart';

/// Represents a player's connection and recording state.
class PlayerSession {
  PlayerSession({required this.device, required this.playerName, this.isRecording = true});

  final BluetoothDevice device;
  final String playerName;
  bool isRecording;
}

/// Holds session information for all connected players.
class SessionState {
  SessionState({this.players = const [], this.startTime});

  final List<PlayerSession> players;
  final DateTime? startTime;

  SessionState copyWith({List<PlayerSession>? players, DateTime? startTime}) =>
      SessionState(
        players: players ?? this.players,
        startTime: startTime ?? this.startTime,
      );
}
