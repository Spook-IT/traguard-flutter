import 'package:flutter/material.dart';
import 'package:traguard/shared/utils/sizes.dart';

/// This widget is part of the shared widgets of the application.
/// It provides a common menu widget that can be used throughout the app.
class CommonMenu<T> extends StatelessWidget {
  /// Creates a new instance of [CommonMenu].
  const CommonMenu({
    required this.initialSelection,
    required this.onSelected,
    required this.dropdownMenuEntries,
    super.key,
    this.label,
    this.isEnabled = true,
  });

  /// The initial selection of the menu.
  final T? initialSelection;

  /// The callback function to be called when an item is selected.
  final void Function(T?)? onSelected;

  /// The list of entries to be displayed in the dropdown menu.
  final List<DropdownMenuEntry<T>> dropdownMenuEntries;

  /// The label to be displayed above the menu.
  final Widget? label;

  /// Indicates whether the menu is enabled or disabled.
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      label: label,
      enabled: isEnabled,
      enableSearch: false,
      initialSelection: initialSelection,
      expandedInsets: Paddings.largeTop,
      onSelected: onSelected,
      dropdownMenuEntries: dropdownMenuEntries,
    );
  }
}
