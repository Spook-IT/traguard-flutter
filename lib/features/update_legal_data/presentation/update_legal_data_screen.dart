import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:traguard/shared/utils/extensions.dart';
import 'package:traguard/shared/utils/sizes.dart';
import 'package:traguard/shared/widgets/save_button.dart';

/// This widget represents the screen for updating legal data.
class UpdateLegalDataScreen extends ConsumerStatefulWidget {
  /// Creates a new instance of [UpdateLegalDataScreen].
  const UpdateLegalDataScreen({super.key});

  @override
  ConsumerState<UpdateLegalDataScreen> createState() =>
      _UpdateLegalDataScreenState();
}

class _UpdateLegalDataScreenState extends ConsumerState<UpdateLegalDataScreen> {
  late final _formKey = GlobalKey<FormState>();
  late final _nameController = TextEditingController();
  late final _emailController = TextEditingController();
  late final _phoneController = TextEditingController();

  bool _isSaving = false;
  bool get _canSave =>
      !_isSaving &&
      _nameController.text.isNotEmpty &&
      _emailController.text.isNotEmpty &&
      _phoneController.text.isNotEmpty;

  @override
  void initState() {
    super.initState();

    // TODO(dariowskii): fetch initial data

    _nameController.addListener(_listenTextController);
    _emailController.addListener(_listenTextController);
    _phoneController.addListener(_listenTextController);
  }

  @override
  void dispose() {
    _nameController
      ..removeListener(_listenTextController)
      ..dispose();
    _emailController
      ..removeListener(_listenTextController)
      ..dispose();
    _phoneController
      ..removeListener(_listenTextController)
      ..dispose();
    super.dispose();
  }

  void _listenTextController() {
    setState(() {});
  }

  Future<void> _saveData() async {
    if (!_canSave) {
      return;
    }

    if (_formKey.currentState?.validate() != true) {
      return;
    }

    setState(() {
      _isSaving = true;
    });

    try {
      // final request = CreatePlayerModel(
      //   fullName: _nameController.text.trim(),
      //   playerNumber: int.tryParse(_playerNumberController.text) ?? 0,
      //   playerRole: _playerRole ?? PlayerRole.unknown,
      //   playerStatus: _playerStatus ?? PlayerStatus.unknown,
      //   playerColorHex: _playerColorHex,
      // );

      // await ref.read(createPlayerProvider(player: request).future);
      // if (!mounted) return;

      // ref.invalidate(fetchPlayersProvider);

      // context.showSuccessSnackbar(context.l10n.playerCreatedSuccessfully);
      context.pop();
    } on Exception catch (e) {
      if (mounted) {
        context.showErrorSnackbar(
          context.l10n.errorCreatingPlayer(e.toString()),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.legalRepresentitive)),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Form(
              key: _formKey,
              child: Padding(
                padding: Paddings.mediumAll,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  spacing: Spaces.small,
                  children: [
                    TextFormField(
                      controller: _nameController,
                      keyboardType: TextInputType.name,
                      autofillHints: const [
                        AutofillHints.name,
                        AutofillHints.familyName,
                      ],
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return l10n.nameAndSurnameValidator;
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: '${l10n.nameAndSurname}*',
                      ),
                      onTapOutside: (event) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                    ),

                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      autofillHints: const [AutofillHints.email],
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return context.l10n.emailEmpty;
                        }

                        if (!value.isValidEmail) {
                          return context.l10n.emailInvalid;
                        }

                        return null;
                      },
                      decoration: InputDecoration(labelText: '${l10n.email}*'),
                      onTapOutside: (event) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                    ),
                    TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      autofillHints: const [AutofillHints.telephoneNumber],
                      textInputAction: TextInputAction.done,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^\+?[0-9]*$'),
                          replacementString: _phoneController.text,
                        ),
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return l10n.phoneEmpty;
                        }

                        return null;
                      },
                      decoration: InputDecoration(labelText: '${l10n.phone}*'),
                      onTapOutside: (event) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                    ),
                    const Spacer(),
                    SafeArea(
                      child: SaveButton(
                        isSaving: _isSaving,
                        canSave: _canSave,
                        onPressed: _saveData,
                      ),
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
