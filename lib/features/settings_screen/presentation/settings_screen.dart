import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:traguard/features/settings_screen/presentation/user_section.dart';
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
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    _tabController.addListener(_listenPageChange);
  }

  @override
  void dispose() {
    _tabController
      ..removeListener(_listenPageChange)
      ..dispose();
    super.dispose();
  }

  void _listenPageChange() {
    if (!mounted) return;
    setState(() {
      _currentIndex = _tabController.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: _currentIndex == 0,
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
              groupValue: _currentIndex,
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
              child: Padding(
                padding: Paddings.smallBottom,
                child: TabBarView(
                  controller: _tabController,
                  viewportFraction: 0.9,
                  children: [
                    const UserSection(),
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
          ),
        ],
      ),
    );
  }
}
