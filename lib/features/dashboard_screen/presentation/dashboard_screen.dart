import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:traguard/features/dashboard_screen/presentation/session_preview.dart';
import 'package:traguard/features/session_management/domain/session_manager.dart';
import 'package:traguard/shared/providers/auth_provider.dart';
import 'package:traguard/shared/router/routes.dart';
import 'package:traguard/shared/utils/extensions.dart';
import 'package:traguard/shared/utils/sizes.dart';

/// Dashboard screen inspired by the provided mockup.
/// It shows a list of training sessions and basic stats for the
/// selected session. The content is static and aims only to replicate
/// the layout of the mockup without real backend integration.
class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  SessionPreview? selectedSession;

  @override
  Widget build(BuildContext context) {
    final sessionState = ref.watch(sessionManagerProvider);
    final hasActiveSession =
        sessionState.players.any((p) => p.isRecording);

    return Scaffold(
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Dashboard GPS Analytics',
                style: context.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Seleziona una sessione di allenamento per visualizzare i dati di performance',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
              const SizedBox(height: 16),
              _buildSessionsCard(context),
              if (selectedSession != null) ...[
                const SizedBox(height: 24),
                _buildSelectedSessionCard(context),
                const SizedBox(height: 24),
                _buildMetricsGrid(context),
              ],
            ],
          ),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Stack(
        children: [
          FloatingActionButton(
            onPressed: () {
              const NewSessionRoute().go(context);
            },
            child: Icon(
              hasActiveSession ? Icons.play_arrow : Icons.add,
            ),
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
              tooltip: 'Dashboard',
              icon: const Icon(Icons.home),
              onPressed: () => const DashboardRoute().go(context),
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

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: ShaderMask(
        shaderCallback: (bounds) => const LinearGradient(
          colors: [Colors.cyan, Colors.cyanAccent],
        ).createShader(bounds),
        child: const Text(
          'TRAGUAR',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      actions: [
        IconButton(
          tooltip: context.l10n.logout,
          onPressed: () => ref.read(authProvider.notifier).signOut(),
          icon: const Icon(Icons.logout),
        ),
      ],
    );
  }

  Widget _buildSessionsCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sessioni di Allenamento',
                      style: context.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '${sampleSessions.length} sessioni trovate',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
                IconButton(
                  tooltip: 'Filtri',
                  onPressed: () {},
                  icon: const Icon(Icons.filter_list),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 200,
              child: ListView.separated(
                itemCount: sampleSessions.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final session = sampleSessions[index];
                  final isSelected = session == selectedSession;
                  return InkWell(
                    onTap: () => setState(() => selectedSession = session),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected
                              ? context.colorScheme.primary
                              : context.colorScheme.outlineVariant,
                        ),
                        color: isSelected
                            ? context.colorScheme.primary.withOpacity(0.1)
                            : null,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                session.name,
                                style: context.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: intensityColor(context, session.intensity)
                                      .withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: intensityColor(context, session.intensity)
                                        .withOpacity(0.4),
                                  ),
                                ),
                                child: Text(
                                  session.intensity,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: intensityColor(
                                        context, session.intensity),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Text(session.formattedDate,
                                  style: context.textTheme.bodySmall),
                              const SizedBox(width: 12),
                              Text('${session.durationMinutes} min',
                                  style: context.textTheme.bodySmall),
                              const SizedBox(width: 12),
                              Text('${session.players} giocatori',
                                  style: context.textTheme.bodySmall),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedSessionCard(BuildContext context) {
    final session = selectedSession!;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  session.name,
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: intensityColor(context, session.intensity)
                        .withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: intensityColor(context, session.intensity)
                          .withOpacity(0.4),
                    ),
                  ),
                  child: Text(
                    session.intensity,
                    style: TextStyle(
                      fontSize: 12,
                      color: intensityColor(context, session.intensity),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 16,
              runSpacing: 8,
              children: [
                _infoRow(Icons.calendar_today, session.formattedDate),
                _infoRow(Icons.schedule, '${session.durationMinutes} min'),
                _infoRow(Icons.group, '${session.players} giocatori'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: Colors.grey.shade600),
        const SizedBox(width: 4),
        Text(text),
      ],
    );
  }

  Widget _buildMetricsGrid(BuildContext context) {
    final session = selectedSession!;
    final cards = [
      _metricCard(
        context,
        icon: Icons.access_time,
        value: '${session.durationMinutes} minuti',
        label: 'Durata Totale',
      ),
      _metricCard(
        context,
        icon: Icons.people,
        value: '${session.players}',
        label: 'Giocatori Coinvolti',
      ),
      _metricCard(
        context,
        icon: Icons.public,
        value: '${session.distanceKm.toStringAsFixed(1)} km',
        label: 'Distanza Totale',
      ),
      _metricCard(
        context,
        icon: Icons.show_chart,
        value: '${session.averageSpeed.toStringAsFixed(1)} km/h',
        label: 'Velocità Media',
      ),
      _metricCard(
        context,
        icon: Icons.flash_on,
        value: '${session.maxSpeed.toStringAsFixed(1)} km/h',
        label: 'Velocità Massima',
      ),
      _metricCard(
        context,
        icon: Icons.trending_up,
        value: session.intensity,
        label: 'Intensità',
      ),
    ];

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 3 / 2,
      children: cards,
    );
  }

  Widget _metricCard(
    BuildContext context, {
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(icon, size: 28, color: context.colorScheme.primary),
                Text(
                  value,
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              label,
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
