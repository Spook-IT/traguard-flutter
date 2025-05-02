import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traguard/features/team_statistics_screen/data/session_filter.dart';
import 'package:traguard/shared/utils/extensions.dart';
import 'package:traguard/shared/utils/sizes.dart';
import 'package:traguard/shared/widgets/base_shimmer.dart';
import 'package:traguard/shared/widgets/common_menu.dart';

class SessionFilterWidget extends ConsumerWidget {
  const SessionFilterWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectionState = ref.watch(sessionFilterProvider);

    return SliverToBoxAdapter(
      child: Padding(
        padding: Paddings.mediumAll,
        child: switch (selectionState) {
          SessionFilterData(:final sessions, :final selectedSession) =>
            CommonMenu(
              initialSelection: selectedSession,
              dropdownMenuEntries: [
                for (final session in sessions.sessions)
                  DropdownMenuEntry(
                    value: session,
                    label: session.name,
                    labelWidget: Padding(
                      padding: Paddings.smallVertical,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(session.name),
                          Text(
                            context.l10n.longDate(session.date),
                            style: context.textTheme.labelSmall?.copyWith(
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
              onSelected: (session) {
                ref
                    .read(sessionFilterProvider.notifier)
                    .setSelectedSession(session!);
              },
              label: const Text('Le tue sessioni'),
            ),
          SessionFilterEmpty() => const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text('Nessuna sessione disponibile'),
          ),
          SessionFilterLoading() => const BaseShimmer(
            child: ShimmerContainer(height: 50, width: double.infinity),
          ),
        },
      ),
    );
  }
}
