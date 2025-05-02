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
  });

  /// The initial selection of the menu.
  final T? initialSelection;

  /// The callback function to be called when an item is selected.
  final void Function(T?)? onSelected;

  /// The list of entries to be displayed in the dropdown menu.
  final List<DropdownMenuEntry<T>> dropdownMenuEntries;

  /// The label to be displayed above the menu.
  final Widget? label;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      menuStyle: const MenuStyle(
        backgroundColor: WidgetStatePropertyAll(Colors.white),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        ),
        maximumSize: WidgetStatePropertyAll(Size.fromHeight(200)),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      label: label,
      enableSearch: false,
      initialSelection: initialSelection,
      expandedInsets: Paddings.largeTop,
      onSelected: onSelected,
      dropdownMenuEntries: dropdownMenuEntries,
    );
  }
}
