import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traguard/shared/models/user.dart';
import 'package:traguard/shared/providers/auth_provider.dart';
import 'package:traguard/shared/utils/extensions.dart';
import 'package:traguard/shared/utils/sizes.dart';
import 'package:traguard/shared/widgets/base_section_card.dart';

/// A widget that displays the user information in the settings screen.
/// It shows the user's name and email address, and allows the user to edit
/// them. It also provides a save button to save the changes.
class UserSection extends ConsumerStatefulWidget {
  /// Creates a new instance of [UserSection].
  const UserSection({super.key});

  @override
  ConsumerState<UserSection> createState() => _UserSectionState();
}

class _UserSectionState extends ConsumerState<UserSection> {
  late final _formKey = GlobalKey<FormState>();

  late final _nameController = TextEditingController();
  late final _emailController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(
      authProvider.select((userAsync) {
        if (userAsync is AsyncData) {
          final user = userAsync.value;
          return switch (user) {
            SignedIn(:final name, :final email) => (name, email),
            _ => (null, null),
          };
        }
        return (null, null);
      }),
    );

    final name = user.$1 ?? '';
    final email = user.$2 ?? '';

    final nameEnabled = name.isNotEmpty;
    // final emailEnabled = email.isNotEmpty;
    const emailEnabled = false; // TODO(dariowskii): False only for demo

    return BaseSectionCard(
      title: context.l10n.user,
      child: Expanded(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                enabled: nameEnabled,
                readOnly: !nameEnabled,
                keyboardType: TextInputType.name,
                autofillHints: const [AutofillHints.name],
                textInputAction: TextInputAction.next,
                onTapOutside: (_) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                decoration: InputDecoration(
                  labelText: context.l10n.name,
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                ),
                controller: _nameController..text = name,
              ),
              Spaces.medium.sizedBoxHeight,
              TextFormField(
                enabled: emailEnabled,
                readOnly: !emailEnabled,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                onTapOutside: (_) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                decoration: InputDecoration(
                  labelText: context.l10n.email,
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                ),
                controller: _emailController..text = email,
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    // TODO(dariowskii): Implement save functionality
                  },
                  child: Text(context.l10n.save),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
