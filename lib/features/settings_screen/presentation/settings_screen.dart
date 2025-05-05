import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:traguard/shared/utils/extensions.dart';
import 'package:traguard/shared/utils/sizes.dart';

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
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              clipBehavior: Clip.none,
              controller: _tabController,
              children: [
                Center(child: Text(context.l10n.general)),
                Center(child: Text(context.l10n.notifications)),
                Center(child: Text(context.l10n.security)),
                Center(child: Text(context.l10n.integrations)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
