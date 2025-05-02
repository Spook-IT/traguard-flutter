import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traguard/features/team_statistics_screen/data/session_filter.dart';

class SessionFilterWidget extends ConsumerWidget {
  const SessionFilterWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectionState = ref.watch(sessionFilterProvider);

    return SliverToBoxAdapter(
      child: switch (selectionState) {
        SessionFilterData(:final sessions, :final selectedSession) =>
          DropdownButton(
            value: selectedSession,
            items:
                sessions.sessions.map((session) {
                  return DropdownMenuItem(
                    value: session,
                    child: Text(session.name),
                  );
                }).toList(),
            onChanged: (session) {
              ref
                  .read(sessionFilterProvider.notifier)
                  .setSelectedSession(session!);
            },
          ),
        SessionFilterEmpty() => const Text('No sessions available'),
        SessionFilterLoading() => const CircularProgressIndicator(),
      },
    );
  }
}
