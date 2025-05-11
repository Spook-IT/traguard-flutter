import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:traguard/shared/router/routes.dart';
import 'package:traguard/shared/utils/extensions.dart';

/// A widget that represents the screen for displaying fiscal data.
class FiscalDataScreen extends StatelessWidget {
  /// Creates a new instance of [FiscalDataScreen].
  const FiscalDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.fiscalDataTitle)),
      body: CupertinoListSection.insetGrouped(
        children: [
          CupertinoListTile.notched(
            title: Text(l10n.legalRepresentitive),
            leading: Icon(Icons.person, color: context.colorScheme.primary),
            trailing: const CupertinoListTileChevron(),
            onTap: () {
              const UpdateLegalDataRoute().go(context);
            },
          ),
          CupertinoListTile.notched(
            title: Text(l10n.team),
            leading: Icon(
              Icons.sports_soccer,
              color: context.colorScheme.primary,
            ),
            trailing: const CupertinoListTileChevron(),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
