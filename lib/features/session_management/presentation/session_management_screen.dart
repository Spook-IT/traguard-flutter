import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traguard/features/session_management/domain/session_manager.dart';
import 'package:traguard/shared/utils/extensions.dart';

/// Screen to control an active recording session.
class SessionManagementScreen extends ConsumerStatefulWidget {
  /// Creates a new instance of [SessionManagementScreen].
  const SessionManagementScreen({super.key});

  @override
  ConsumerState<SessionManagementScreen> createState() =>
      _SessionManagementScreenState();
}

class _SessionManagementScreenState
    extends ConsumerState<SessionManagementScreen> {
  Duration _elapsed = Duration.zero;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final start = ref.read(sessionManagerProvider).startTime;
      if (start != null) {
        setState(() {
          _elapsed = DateTime.now().difference(start);
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _format(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(sessionManagerProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('${context.l10n.sessionManagement} - ${_format(_elapsed)}'),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(sessionManagerProvider.notifier).stopAll();
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.stop),
            tooltip: context.l10n.stopSession,
          ),
        ],
      ),
      body: state.players.isEmpty
          ? Center(child: Text(context.l10n.noDevicesConnected))
          : ListView.separated(
              itemCount: state.players.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final player = state.players[index];
                final name = player.playerName;
                return ListTile(
                  title: Text(name),
                  subtitle: Text(
                    player.isRecording
                        ? context.l10n.recording
                        : context.l10n.paused,
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      player.isRecording
                          ? Icons.pause_circle_filled
                          : Icons.play_circle_fill,
                    ),
                    onPressed: () => ref
                        .read(sessionManagerProvider.notifier)
                        .toggle(player.device),
                  ),
                );
              },
            ),
    );
  }
}
