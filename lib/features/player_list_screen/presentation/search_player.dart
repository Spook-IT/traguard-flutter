import 'package:flutter/material.dart';
import 'package:traguard/shared/utils/extensions.dart';
import 'package:traguard/shared/utils/sizes.dart';

/// A widget that represents a search field for players.
/// It is used to filter the list of players based on the input text.
class SearchPlayer extends StatelessWidget {
  /// Creates a new instance of [SearchPlayer].
  const SearchPlayer({
    required this.controller,
    required this.onSendValue,
    super.key,
  });

  /// The controller used to manage the text input.
  final TextEditingController controller;

  /// A callback function that is called when the search value is sent.
  final VoidCallback onSendValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Paddings.mediumHorizontal + Paddings.smallVertical,
      child: TextField(
        controller: controller,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: context.l10n.searchAthletes,
          prefixIcon: const Icon(Icons.search, size: 20),
          prefixIconConstraints: const BoxConstraints(
            minWidth: 40,
            maxWidth: 40,
          ),
          contentPadding: EdgeInsets.zero,
        ),
        onTapOutside: (e) {
          FocusManager.instance.primaryFocus?.unfocus();
          onSendValue();
        },
        onSubmitted: (_) {
          onSendValue();
        },
      ),
    );
  }
}
