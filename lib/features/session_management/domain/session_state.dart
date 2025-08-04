import 'package:flutter_blue_plus/flutter_blue_plus.dart';

/// Represents a player's connection and recording state.
class PlayerSession {
  PlayerSession({required this.device, this.isRecording = true});

  final BluetoothDevice device;
  bool isRecording;
}

/// Holds session information for all connected players.
class SessionState {
  SessionState({this.players = const []});

  final List<PlayerSession> players;

  SessionState copyWith({List<PlayerSession>? players}) =>
      SessionState(players: players ?? this.players);
}
