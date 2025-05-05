import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:traguard/shared/utils/extensions.dart';
import 'package:traguard/shared/utils/sizes.dart';
import 'package:traguard/shared/widgets/base_section_card.dart';

/// A screen that displays the settings of the application.
/// This screen allows users to customize their preferences and settings.
class SettingsScreen extends StatefulWidget {
  /// Creates a new instance of [SettingsScreen].
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController = TabController(
    length: 4,
    vsync: this,
  );

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.settings)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: Paddings.largeAll,
            child: CupertinoSlidingSegmentedControl(
              children: {
                0: Text(context.l10n.general),
                1: Text(context.l10n.notifications),
                2: Text(context.l10n.security),
                3: Text(context.l10n.integrations),
              },
              groupValue: _tabController.index,
              onValueChanged: (value) {
                if (value != null) {
                  setState(() {
                    _tabController.index = value;
                  });
                }
              },
            ),
          ),
          Expanded(
            child: SafeArea(
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _tabController,
                viewportFraction: 0.9,
                children: [
                  BaseSectionCard(
                    title: context.l10n.user,
                    child: Expanded(
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(16),
                                ),
                              ),
                            ),
                            controller: TextEditingController(),
                            enabled: true,
                          ),
                          Spaces.medium.sizedBoxHeight,
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: context.l10n.email,
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(16),
                                ),
                              ),
                            ),
                            controller: TextEditingController(),
                            enabled: true,
                          ),
                          const Spacer(),
                          SizedBox(
                            width: double.infinity,
                            child: FilledButton(
                              onPressed: () {
                                // TODO: Implement save functionality
                              },
                              child: const Text('Save'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  BaseSectionCard(
                    title: context.l10n.notifications,
                    child: Container(),
                  ),
                  BaseSectionCard(
                    title: context.l10n.security,
                    child: Container(),
                  ),
                  BaseSectionCard(
                    title: context.l10n.integrations,
                    child: Container(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
