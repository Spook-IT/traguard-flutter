import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traguard/features/session_management/domain/session_manager.dart';
import 'package:traguard/shared/utils/extensions.dart';

/// Screen to control an active recording session.
class SessionManagementScreen extends ConsumerWidget {
  /// Creates a new instance of [SessionManagementScreen].
  const SessionManagementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(sessionManagerProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.sessionManagement),
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
                final name = player.device.advName.isNotEmpty
                    ? player.device.advName
                    : player.device.remoteId.str;
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
