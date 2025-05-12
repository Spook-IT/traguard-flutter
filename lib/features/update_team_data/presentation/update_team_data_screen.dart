import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traguard/features/update_team_data/data/use_cases.dart';
import 'package:traguard/features/update_team_data/presentation/loading_team.dart';
import 'package:traguard/features/update_team_data/presentation/update_team_form.dart';
import 'package:traguard/shared/utils/extensions.dart';
import 'package:traguard/shared/widgets/error_retry.dart';

/// This widget represents the screen for updating legal data.
class UpdateTeamDataScreen extends ConsumerWidget {
  /// Creates a new instance of [UpdateTeamDataScreen].
  const UpdateTeamDataScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;

    final asyncData = ref.watch(fetchTeamDataProvider).unwrapPrevious();

    final child = switch (asyncData) {
      AsyncData(:final value) => UpdateTeamForm(initialData: value),
      AsyncError() => SliverFillRemaining(
        hasScrollBody: false,
        child: ErrorRetry(
          onRetry: () {
            ref.invalidate(fetchTeamDataProvider);
          },
        ),
      ),
      _ => const SliverToBoxAdapter(child: LoadingTeam()),
    };

    return Scaffold(
      appBar: AppBar(title: Text(l10n.team)),
      body: CustomScrollView(slivers: [child]),
    );
  }
}
